From: Laurent Canet <lc@tekila.org>
Subject: HP PA-RISC harmony driver
Date: Fri, 6 Dec 2002 20:10:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021206201002.409a6267.lc@tekila.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__6_Dec_2002_20:10:02_+0100_082d3da8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart_Fri__6_Dec_2002_20:10:02_+0100_082d3da8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I've wrote an ALSA driver for the harmony chipset. This chipset
is found in some HP PA-RISC workstations. 
My driver is in very early stage, so I would like your appreciations on
the code.

The actual state of the driver is 
-initialisation of the driver works perfectly. 
-Playback open (with mpg321 -o alsa09) is successful.
-But after 2-3 interrupts, and the first call to the pointer function, 
the libao stops the playback (stop trigger) and print an error on stderr 
(ALSA unknown error 1024). After this, it immediately restart the playback

Some noise can be heard, but it's sluggish, probably due to printks in the
interruption routine.

(Compiling this driver is a little bit hard, since alsa-driver distributions
don't have any support for the hppa platform. I suggest 'by hand' compiling
with gcc)

Technical specifications of the harmony chipset can be found at :
http://ftp.parisc-linux.org/docs/lasi_ers.ps, page 42-52

My preliminary version (ie: dirty and buggy ;^) ) of the driver is attached 
to this mail.


Thanks.

--
Laurent Canet
PA/Linux ESIEE Team
http://pateam.esiee.fr

--Multipart_Fri__6_Dec_2002_20:10:02_+0100_082d3da8
Content-Type: text/x-csrc;
 name="harmony.c"
Content-Disposition: attachment;
 filename="harmony.c"
Content-Transfer-Encoding: 7bit

/*
 *  Harmony chipset driver
 *
 *	This is a sound driver for ASP's and Lasi's Harmony sound chip
 *	and is unlikely to be used for anything other than on a HP PA-RISC.
 *
 *	Harmony is found in HP 712s, 715/new and many other GSC based machines.
 *	On older 715 machines you'll find the technically identical chip 
 *	called 'Vivace'. Both Harmony and Vicace are supported by this driver.
 *
 *  this ALSA driver is based on OSS driver by:
 *	Copyright 2000 (c) Linuxcare Canada, Alex deVries <alex@linuxcare.com>
 *	Copyright 2000-2002 (c) Helge Deller <deller@gmx.de>
 *	Copyright 2001 (c) Matthieu Delahaye <delahaym@esiee.fr>
 *
 * TODO:
 * - capture is still untested (and probaby unworked)
 * - spin locks
 * - implement non-consistent DMA pages
 * - implement gain meter
 * - module parameters
 * - correct cleaning sequence
 * - better error checking
 *   
 */

/*
 * Harmony chipset 'modus operandi'.
 * - This chipset is found in some HP 32bit workstations, like 712, or B132 class.
 * most of controls are done through registers. Register are found at a fixed offset
 * from the hard physical adress, given in struct dev by register_parisc_driver.
 *
 * Playback and recording use 4kb pages (dma or not, depending on the machine).
 *
 * Most of PCM playback & capture is done through interrupt. When harmony needs
 * a new buffer to put recorded data or read played PCM, it sends an interrupt.
 * Bits 2 and 10 of DSTATUS register are '1' when harmony needs respectively
 * a new page for recording and playing. 
 * Interrupt are disabled/enabled by writing to bit 32 of DSTATUS. 
 * Adresses of next page to be played is put in PNXTADD register, next page
 * to be recorded is put in RNXTADD. There is 2 read-only registers, PCURADD and 
 * RCURADD that provides adress of current page.
 * The basic idea is to use 10 rotating buffers of 4kb. 
 * 
 * Harmony has no way to controll full duplex or half duplex mode. It means
 * that we always need to provide adresses of playback and capture data, even
 * when this is not needed. That's why we statically alloc one graveyard
 * buffer (to put recorded data in play-only mode) and a silence buffer.
 * (silence buffer is not yet implemented by this driver).
 * 
 * Bitrate, number of channels and data format are controlled with
 * the CNTL register.
 *
 * Mixer work is done through one register (GAINCTL). Only input gain,
 * output attenuation and general gain control is provided. There is
 * also only controls for enabling/disabling internal speaker, line
 * input.
 *
 * Buffers used by this driver are all DMA consistent. Since harmony is
 * not "real" pci device, we use a fake struct pci_dev for
 * pci_alloc_consistent().
 * (note that some machines -712 for ex.- don't implement DMA consistent
 * memory, so we will need to use kmalloc instead)
 */

#include <linux/delay.h>
#include <sound/driver.h>
#include <linux/init.h>
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 0)
#include <linux/jiffies.h>
#else
#include <linux/sched.h>
#endif
#include <linux/slab.h>
#include <linux/time.h>
#include <linux/wait.h>
#include <sound/core.h>
#include <sound/control.h>
#include <sound/pcm.h>
#include <sound/rawmidi.h>
#define SNDRV_GET_ID
#include <sound/initval.h>
#include <sound/info.h>
#ifdef CONFIG_PARISC
#include <asm/hardware.h>
#include <asm/gsc.h>
#include <asm/io.h>
#endif

MODULE_AUTHOR("Laurent Canet <canetl@esiee.fr>");
MODULE_DESCRIPTION("ALSA Harmony sound driver");
MODULE_LICENSE("GPL");
MODULE_CLASSES("{sound}");
MODULE_DEVICES("{{ALSA,Harmony soundcard}}");

#define DEBUG
#ifdef DEBUG
# define DPRINTK printk 
#else
# define DPRINTK(x,...)
#endif

#define PFX	"harmony: "

#define MAX_PCM_DEVICES		1
#define MAX_PCM_SUBSTREAMS	4
#define MAX_MIDI_DEVICES	0

#define BUFFER_SIZE			4096
#define MAX_BUFS			10
#define GRAVEYARD_BUFS		3
#define MAX_BUFFER_SIZE		(MAX_BUFS * BUFFER_SIZE)
#define HARMONY_BUF_SIZE	BUFFER_SIZE

#define HARMONY_CNTL_C		0x80000000

#define HARMONY_DSTATUS_PN	0x00000200
#define HARMONY_DSTATUS_RN	0x00000002
#define HARMONY_DSTATUS_IE	0x80000000

#define HARMONY_DF_16BIT_LINEAR	0x00000000
#define HARMONY_DF_8BIT_ULAW	0x00000001
#define HARMONY_DF_8BIT_ALAW	0x00000002

#define HARMONY_SS_MONO		0x00000000
#define HARMONY_SS_STEREO	0x000000001

/*
 * Channels Mask in mixer register
 */

#define HARMONY_GAIN_TOTAL_SILENCE 0x00F00FFF
#define HARMONY_GAIN_DEFAULT       0x0FF00000

/* useless since only one card is supported ATM */
static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;

/* Register offset (from base hpa) */
#define REG_ID		0x00
#define REG_RESET	0x04
#define REG_CNTL	0x08
#define REG_GAINCTL	0x0C
#define REG_PNXTADD	0x10
#define REG_PCURADD	0x14
#define REG_RNXTADD	0x18
#define REG_RCURADD	0x1C
#define REG_DSTATUS	0x20
#define REG_OV		0x24
#define REG_PIO		0x28
#define REG_DIAG	0x3C

/*
 * main harmony structure
 */

typedef struct snd_card_harmony {

	/* spinlocks (To be done) */
	spinlock_t mixer_lock;
	spinlock_t control_lock;

	/* parameters */	
	int irq;
	unsigned long hpa;
	int id;
	int rev;
	
	u32 current_gain;
	int data_format;		/* HARMONY_DF_xx_BIT_xxx */
	int sample_rate;		/* HARMONY_SR_xx_KHZ */
	int stereo_select;	/* HARMONY_SS_MONO or HARMONY_SS_STEREO */
	int format_initialized;
	
	unsigned long ply_buffer;
	int ply_count; 
	int ply_paused;
	int ply_stopped;
	
	unsigned long cap_buffer;
	int cap_count;
	int cap_paused;
	int cap_stopped;

	int audio_open;

	struct pci_dev *fake_pci_dev; /* The fake pci_dev needed for 
					pci_* functions under ccio. */

	/* the graveyard buffer is used as recording buffer when playback, 
	 * because harmony always want a buffer to put recorded data */

	unsigned char *graveyard_addr;
	dma_addr_t graveyard_dma;
	int graveyard_count;

	/* alsa stuff */
	snd_card_t *card;
	snd_pcm_t *pcm;
	snd_pcm_substream_t *playback_substream;
	snd_pcm_substream_t *capture_substream;
	snd_info_entry_t *proc_entry;
} snd_card_harmony_t;
#define chip_t snd_card_harmony_t

static snd_card_t *snd_harmony_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;

/*
 * sample rate routines 
 */
static unsigned int snd_card_harmony_rates[] = {
	5125, 6615, 8000, 9600,
	11025, 16000, 18900, 22050,
	27428, 32000, 33075, 37800,
	44100, 48000
};

#define RATES sizeof(snd_card_harmony_rates) / sizeof(snd_card_harmony_rates[0])

static snd_pcm_hw_constraint_list_t hw_constraint_rates = {
	.count = RATES,
	.list = snd_card_harmony_rates,
	.mask = 0,
};

#define HARMONY_SR_8KHZ		0x08
#define HARMONY_SR_16KHZ	0x09
#define HARMONY_SR_27KHZ	0x0A
#define HARMONY_SR_32KHZ	0x0B
#define HARMONY_SR_48KHZ	0x0E
#define HARMONY_SR_9KHZ		0x0F
#define HARMONY_SR_5KHZ		0x10
#define HARMONY_SR_11KHZ	0x11
#define HARMONY_SR_18KHZ	0x12
#define HARMONY_SR_22KHZ	0x13
#define HARMONY_SR_37KHZ	0x14
#define HARMONY_SR_44KHZ	0x15
#define HARMONY_SR_33KHZ	0x16
#define HARMONY_SR_6KHZ		0x17

/* snd_card_harmony_rate_bits
 * @rate:	index of current data rate in list
 * returns: harmony hex code for registers
 */
static unsigned int snd_card_harmony_rate_bits(int rate)
{
	unsigned int idx;
	
	printk(KERN_ERR PFX "Rate bits rate=%d\n", rate);
	for (idx = 0; idx <= RATES; idx++)
		if (snd_card_harmony_rates[idx] == rate) break;
	
	switch (idx) {
		case 0: return HARMONY_SR_5KHZ;
		case 1: return HARMONY_SR_6KHZ;
		case 2: return HARMONY_SR_8KHZ;
		case 3: return HARMONY_SR_9KHZ;
		case 4: return HARMONY_SR_11KHZ;
		case 5: return HARMONY_SR_16KHZ;
		case 6: return HARMONY_SR_18KHZ;
		case 7: return HARMONY_SR_22KHZ;
		case 8: return HARMONY_SR_27KHZ;
		case 9: return HARMONY_SR_32KHZ;
		case 10: return HARMONY_SR_33KHZ;
		case 11: return HARMONY_SR_37KHZ;
		case 12: return HARMONY_SR_44KHZ;
		case 13: return HARMONY_SR_48KHZ;
		default:  /* fallback */
				return HARMONY_SR_44KHZ;
	}
}

/*
 * update controls (data format, sample rate, number of channels)
 * according to value supplied in data structure
 */
void snd_harmony_update_control(snd_card_harmony_t *harmony) 
{
	u32 default_cntl;
	
	/* Set CNTL */
	default_cntl = (HARMONY_CNTL_C |  	/* The C bit */
		(harmony->data_format << 6) |	/* Set the data format */
		(harmony->stereo_select << 5) |	/* Stereo select */
		(harmony->sample_rate));		/* Set sample rate */
	
	/* initialize CNTL */
	while (gsc_readl(harmony->hpa+REG_CNTL) & HARMONY_CNTL_C) 
		/* Wait */ ;	
	gsc_writel(default_cntl, harmony->hpa+REG_CNTL);
	
}

/*
 * silence a buffer
 * XXX: alsa could probably do this by itself
 * XXX: memset hpmc, commented.
 */

void snd_harmony_silence(snd_card_harmony_t *harmony,
		void *addr, int length)
{
	u8 silence_char;
	
	switch(harmony->data_format) {
			case HARMONY_DF_8BIT_ULAW: silence_char = 0x55; break;
			case HARMONY_DF_8BIT_ALAW: silence_char = 0xff; break;
			case HARMONY_DF_16BIT_LINEAR:
			default:
									   silence_char = 0;
	}
	//memset(addr, silence_char, length);
}

/*
 * interruption controls routines
 */

static void snd_harmony_disable_interrupts(snd_card_harmony_t *chip) 
{
	while (gsc_readl(chip->hpa+REG_CNTL) & HARMONY_CNTL_C)
		/* Wait */ ;	
	gsc_writel(0, chip->hpa+REG_DSTATUS); 
}

static void snd_harmony_enable_interrupts(snd_card_harmony_t *chip) 
{
	while (gsc_readl(chip->hpa+REG_CNTL) & HARMONY_CNTL_C)
		/* Wait */ ;	
	gsc_writel(HARMONY_DSTATUS_IE, chip->hpa+REG_DSTATUS); 
}

/*
 * interruption routine:
 * The interrupt routine must provide adresse of next physical pages 
 * used by harmony
 */
void snd_card_harmony_interrupt(int irq, void *dev, struct pt_regs *regs)
{
	snd_card_harmony_t *harmony = (snd_card_harmony_t *)dev;
	u32 dstatus = 0;
	unsigned long hpa = harmony->hpa;
	
	/* Turn off interrupts */
	snd_harmony_disable_interrupts(harmony);
	
	/* wait for control to free */
	while (gsc_readl(hpa+REG_CNTL) & HARMONY_CNTL_C)
		/* Wait */ ;	
	/* Read dstatus and pcuradd (the current address) */
	dstatus = gsc_readl(hpa+REG_DSTATUS);
	
	DPRINTK(KERN_INFO PFX "in interrupt hpa=%lx dstatus=%d\n", (unsigned long)hpa, dstatus); 
	/* Check if this is a request to get the next play buffer */
	if ((dstatus & HARMONY_DSTATUS_PN) && (harmony->playback_substream)) {
		gsc_writel(harmony->ply_buffer + 
					(HARMONY_BUF_SIZE*harmony->ply_count),
					hpa+REG_PNXTADD);
		harmony->ply_count++;
		harmony->ply_count %= MAX_BUFS;
		
		DPRINTK(KERN_INFO PFX "Interrupt received: %u, plybuf=%lx, plycount=%u\n", 
			dstatus, (unsigned long)harmony->ply_buffer, harmony->ply_count);
	
		snd_pcm_period_elapsed(harmony->playback_substream);
		snd_harmony_enable_interrupts(harmony);
	}
	
	/* Check if we're being asked to fill in a recording buffer */
	if (dstatus & HARMONY_DSTATUS_RN) {
		if (harmony->capture_substream) {
			gsc_writel(harmony->cap_buffer + 
						(HARMONY_BUF_SIZE*harmony->cap_count),
						hpa+REG_RNXTADD);
			harmony->cap_count++;
			harmony->cap_count %= MAX_BUFS;
			snd_pcm_period_elapsed(harmony->capture_substream);
			snd_harmony_enable_interrupts(harmony);
		} else {
			/* graveyard buffer */
			gsc_writel(harmony->graveyard_dma +
						(HARMONY_BUF_SIZE*harmony->graveyard_count),
						hpa+REG_RNXTADD);
			harmony->graveyard_count++;
			harmony->graveyard_count %= GRAVEYARD_BUFS;
			DPRINTK(KERN_INFO PFX "wrote graveyard %d\n", harmony->graveyard_count);
		}
	}
}

/* 
 * proc entry
 * this proc file will give some debugging info
 */

static void snd_harmony_proc_read(snd_info_entry_t *entry, snd_info_buffer_t *buffer)
{
	snd_card_harmony_t *harmony = (snd_card_harmony_t *)entry->private_data;

	snd_iprintf(buffer, "LASI Harmony driver\nLaurent Canet <canetl@esiee.fr>\n\n");
	snd_iprintf(buffer, "IRQ %d, hpa %lx, id %d rev %d\n",
			harmony->irq, harmony->hpa,
			harmony->id, harmony->rev);
	snd_iprintf(buffer, "Current gain %lx\n", (unsigned long) harmony->current_gain);
	snd_iprintf(buffer, "\tsample rate=%d\n", harmony->sample_rate);
	snd_iprintf(buffer, "\tstereo select=%d\n", harmony->stereo_select);
	snd_iprintf(buffer, "\tbitperchan=%d\n\n", harmony->data_format);
	
	snd_iprintf(buffer, "Play status:\n");
	snd_iprintf(buffer, "\tstopped %d\n", harmony->ply_stopped);
	snd_iprintf(buffer, "\tpaused %d\n", harmony->ply_stopped);
	snd_iprintf(buffer, "\tbuffer %lx, count %d\n", harmony->ply_buffer, harmony->ply_count);

	snd_iprintf(buffer, "Capture status:\n");
	snd_iprintf(buffer, "\tstopped %d\n", harmony->cap_stopped);
	snd_iprintf(buffer, "\tpaused %d\n", harmony->cap_stopped);
	snd_iprintf(buffer, "\tbuffer %lx, count %d\n\n", harmony->cap_buffer, harmony->cap_count);
	
	snd_iprintf(buffer, "Register:\n");
	snd_iprintf(buffer, "\tgainctl: %lx\n", (unsigned long) gsc_readl(harmony->hpa+REG_GAINCTL));
	snd_iprintf(buffer, "\tcntl: %lx\n", (unsigned long) gsc_readl(harmony->hpa+REG_CNTL));
	snd_iprintf(buffer, "\tid: %lx\n", (unsigned long) gsc_readl(harmony->hpa+REG_ID));
	snd_iprintf(buffer, "\tpcuradd: %lx\n", (unsigned long) gsc_readl(harmony->hpa+REG_PCURADD));
	snd_iprintf(buffer, "\trcuradd: %lx\n", (unsigned long) gsc_readl(harmony->hpa+REG_RCURADD));
	snd_iprintf(buffer, "\tpnxtadd: %lx\n", (unsigned long) gsc_readl(harmony->hpa+REG_PNXTADD));
	snd_iprintf(buffer, "\trnxtadd: %lx\n", (unsigned long) gsc_readl(harmony->hpa+REG_RNXTADD));
	snd_iprintf(buffer, "\tdstatus: %lx\n", (unsigned long) gsc_readl(harmony->hpa+REG_DSTATUS));
	snd_iprintf(buffer, "\tov: %lx\n\n", (unsigned long) gsc_readl(harmony->hpa+REG_OV));
	
	snd_iprintf(buffer, "Graveyard addr=%lx dma=%lx count=%d\n", (unsigned long) harmony->graveyard_addr,
			(unsigned long) harmony->graveyard_dma, harmony->graveyard_count);
}

static void __devinit snd_harmony_proc_init(snd_card_harmony_t *harmony)
{
	snd_info_entry_t *entry;
	
	if ((entry = snd_info_create_card_entry(harmony->card, "harmony", harmony->card->proc_root)) != NULL) {
		entry->content = SNDRV_INFO_CONTENT_TEXT;
		entry->private_data = harmony;
		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
		entry->c.text.read_size = 2048;
		entry->c.text.read = snd_harmony_proc_read;
		if (snd_info_register(entry) < 0) {
			snd_info_free_entry(entry);
			entry = NULL;
		}
	}
	harmony->proc_entry = entry;
}

static void snd_harmony_proc_done(snd_card_harmony_t *harmony)
{
	if (harmony->proc_entry) {
		snd_info_unregister(harmony->proc_entry);
		harmony->proc_entry = NULL;
	}
}

/* 
 * PCM Stuff
 */

static int snd_card_harmony_playback_ioctl(snd_pcm_substream_t * substream,
				         unsigned int cmd,
				         void *arg)
{
	DPRINTK(KERN_INFO PFX "Playback IOCTL %d\n", cmd);
	return snd_pcm_lib_ioctl(substream, cmd, arg);
}

static int snd_card_harmony_capture_ioctl(snd_pcm_substream_t * substream,
					unsigned int cmd,
					void *arg)
{
	DPRINTK(KERN_INFO PFX "Capture IOCTL %d\n", cmd);
	return snd_pcm_lib_ioctl(substream, cmd, arg);
}

static int snd_card_harmony_playback_trigger(snd_pcm_substream_t * substream,
					   int cmd)
{
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	
	DPRINTK(KERN_INFO PFX "Playback trigger %d\n", cmd);
	switch (cmd) {
		case SNDRV_PCM_TRIGGER_STOP:
			if (harmony->ply_stopped) 
				return -EBUSY;
			harmony->ply_stopped = 1;
			snd_harmony_disable_interrupts(harmony);
			break;
		case SNDRV_PCM_TRIGGER_START:
			if (!harmony->ply_stopped)
				return -EBUSY;
			harmony->ply_stopped = 0;
			snd_harmony_enable_interrupts(harmony);
			break;
		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
		case SNDRV_PCM_TRIGGER_SUSPEND:
			DPRINTK(KERN_INFO PFX "received unimplemented trigger: %d\n", cmd);
		default:
			return -EINVAL;
	}
	return 0;
}

static int snd_card_harmony_capture_trigger(snd_pcm_substream_t * substream,
					  int cmd)
{
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	
	DPRINTK(KERN_INFO PFX "Capture trigger %d\n", cmd);
	switch (cmd) {
		case SNDRV_PCM_TRIGGER_STOP:
			if (harmony->cap_stopped) 
				return -EBUSY;
			harmony->cap_stopped = 1;;
			snd_harmony_disable_interrupts(harmony);
			break;
		case SNDRV_PCM_TRIGGER_START:
			if (!harmony->cap_stopped)
				return -EBUSY;
			harmony->cap_stopped = 0;
			snd_harmony_enable_interrupts(harmony);
			break;
		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
		case SNDRV_PCM_TRIGGER_SUSPEND:
			DPRINTK(KERN_INFO PFX "Received unimplemented trigger: %d\n", cmd);
		default:
			return -EINVAL;
	}
	return 0;
}

static int snd_card_harmony_playback_prepare(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	
	harmony->ply_count			= 0;
	harmony->ply_paused			= 0;
	harmony->ply_stopped		= 1;
	
	/* initialize given sample rate */
	harmony->sample_rate = snd_card_harmony_rate_bits(runtime->rate);

	/* data format */
	if (snd_pcm_format_width(runtime->format) == 16) harmony->data_format = HARMONY_DF_16BIT_LINEAR;
	else harmony->data_format = HARMONY_DF_8BIT_ULAW;
	
	/* number of channels */
	if (runtime->channels == 2) harmony->stereo_select = HARMONY_SS_STEREO;
	else harmony->stereo_select = HARMONY_SS_MONO;
	
	DPRINTK(KERN_INFO PFX "Playback prepare, sr=%d(%x), df=%x, ss=%x hpa=%lx\n", runtime->rate,
				harmony->sample_rate, harmony->data_format, harmony->stereo_select, harmony->hpa);
	snd_harmony_update_control(harmony);
	harmony->format_initialized = 1;
	
	runtime->dma_bytes = MAX_BUFFER_SIZE;	
	harmony->ply_buffer = runtime->dma_addr;
	
	return 0;
}

static int snd_card_harmony_capture_prepare(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	
	harmony->cap_buffer		 	= runtime->dma_addr;
	harmony->cap_count			= 0;
	harmony->cap_paused			= 0;
	harmony->cap_stopped		= 1;

	/* initialize given sample rate */
	harmony->sample_rate = snd_card_harmony_rate_bits(runtime->rate);
	
	/* data format */
	if (snd_pcm_format_width(runtime->format) == 16) harmony->data_format = HARMONY_DF_16BIT_LINEAR;
	else harmony->data_format = HARMONY_DF_8BIT_ULAW;
	
	/* number of channels */
	if (runtime->channels == 1) harmony->stereo_select = HARMONY_SS_MONO;
	else if (runtime->channels == 2) harmony->stereo_select = HARMONY_SS_STEREO;
		
	snd_harmony_update_control(harmony);
	harmony->format_initialized = 1;

	return 0;
}

static snd_pcm_uframes_t snd_card_harmony_capture_pointer(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	
	if (harmony->cap_stopped) return 0;
		
	return bytes_to_frames(runtime, harmony->cap_count*HARMONY_BUF_SIZE);
}

/*
 * Current position in buffer CANNOT exactly be known, we just 
 * know what 4kb-buffer is currently being played.
 */

static snd_pcm_uframes_t snd_card_harmony_playback_pointer(snd_pcm_substream_t * substream)
{
	snd_pcm_runtime_t *runtime = substream->runtime;
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	
	if (harmony->ply_stopped) return 0;
	
	return bytes_to_frames(runtime, harmony->ply_count*HARMONY_BUF_SIZE);
}

static snd_pcm_hardware_t snd_card_harmony_playback =
{
	.info =			(SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP | 
			SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_HALF_DUPLEX),
	.formats =		(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_BE | 
					SNDRV_PCM_FMTBIT_A_LAW | SNDRV_PCM_FMTBIT_MU_LAW),
	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
	.rate_min =		5500,
	.rate_max =		48000,
	.channels_min =		1,
	.channels_max =		2,
	.buffer_bytes_max =	MAX_BUFFER_SIZE,
	.period_bytes_min =	64,
	.period_bytes_max =	HARMONY_BUF_SIZE,
	.periods_min =		1,
	.periods_max =		MAX_BUFS*4,
	.fifo_size =		0,
};

static snd_pcm_hardware_t snd_card_harmony_capture =
{
	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
				 SNDRV_PCM_INFO_HALF_DUPLEX),
	.formats =		(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_BE | 
					SNDRV_PCM_FMTBIT_A_LAW | SNDRV_PCM_FMTBIT_MU_LAW),
	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
	.rate_min =		5500,
	.rate_max =		48000,
	.channels_min =		1,
	.channels_max =		2,
	.buffer_bytes_max =	MAX_BUFFER_SIZE,
	.period_bytes_min =	64,
	.period_bytes_max =	HARMONY_BUF_SIZE,
	.periods_min =		1,
	.periods_max =		MAX_BUFS*4,
	.fifo_size =		0,
};

static int snd_card_harmony_playback_open(snd_pcm_substream_t * substream)
{
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	int err;
	
	/*
	 * harmony is not "real" pci, but we need a pci_dev
	 * to alloc PCI DMA pages
	 */
	substream->dma_private = harmony->fake_pci_dev;
	substream->dma_type = SNDRV_PCM_DMA_TYPE_PCI;
	
	harmony->playback_substream = substream;
	runtime->hw = snd_card_harmony_playback;
	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraint_rates);
	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
		return err;
	return 0;
}

static int snd_card_harmony_capture_open(snd_pcm_substream_t * substream)
{
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	int err;

	harmony->capture_substream = substream;
	runtime->hw = snd_card_harmony_capture;
	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraint_rates);
	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
		return err;
	return 0;

}

static int snd_card_harmony_playback_close(snd_pcm_substream_t * substream)
{
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	
	harmony->playback_substream = NULL;
	return 0;
}

static int snd_card_harmony_capture_close(snd_pcm_substream_t * substream)
{
	snd_card_harmony_t *harmony = snd_pcm_substream_chip(substream);
	
	harmony->capture_substream = NULL;
	return 0;
}

static int snd_card_harmony_hw_params(snd_pcm_substream_t *substream, 
	                   snd_pcm_hw_params_t * hw_params)
{
	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
}

static int snd_card_harmony_hw_free(snd_pcm_substream_t *substream) 
{
	return snd_pcm_lib_free_pages(substream);		
}

static snd_pcm_ops_t snd_card_harmony_playback_ops = {
	.open =			snd_card_harmony_playback_open,
	.close =		snd_card_harmony_playback_close,
	.ioctl =		snd_card_harmony_playback_ioctl,
	.hw_params = 	snd_card_harmony_hw_params,
	.hw_free = 		snd_card_harmony_hw_free,
	.prepare =		snd_card_harmony_playback_prepare,
	.trigger =		snd_card_harmony_playback_trigger,
 	.pointer =		snd_card_harmony_playback_pointer,

};

static snd_pcm_ops_t snd_card_harmony_capture_ops = {
	.open =			snd_card_harmony_capture_open,
	.close =		snd_card_harmony_capture_close,
	.ioctl =		snd_card_harmony_capture_ioctl,
	.hw_params = 	snd_card_harmony_hw_params,
	.hw_free = 		snd_card_harmony_hw_free,
	.prepare =		snd_card_harmony_capture_prepare,
	.trigger =		snd_card_harmony_capture_trigger,
	.pointer =		snd_card_harmony_capture_pointer,
};

static int snd_card_harmony_pcm_init(snd_card_harmony_t *harmony, int device)
{
	snd_pcm_t *pcm;
	int err;

	/* Request that IRQ */
	if (request_irq(harmony->irq, snd_card_harmony_interrupt, 0 ,"harmony", harmony)) {
		printk(KERN_ERR PFX "Error requesting irq %d.\n", harmony->irq);
		return -EFAULT;
	}
	
	snd_harmony_disable_interrupts(harmony);
	
   	if ((err = snd_pcm_new(harmony->card, "Harmony", device, 1, 1, &pcm)) < 0)
		return err;
	
	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_card_harmony_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_card_harmony_capture_ops); 
	
	pcm->private_data = harmony;
	pcm->info_flags = 0;
	strcpy(pcm->name, "Harmony");
	harmony->pcm = pcm;
	
	/* initialize graveyard buffer */
	harmony->graveyard_addr = snd_malloc_pci_pages(harmony->fake_pci_dev, 
			HARMONY_BUF_SIZE*GRAVEYARD_BUFS, &harmony->graveyard_dma);
	harmony->graveyard_count = 0;
	

	harmony->playback_substream = NULL;
	harmony->capture_substream = NULL;
	harmony->graveyard_count = 0;
	harmony->audio_open = 0;
	
	return 0;
}

/*
 * mixer routines
 */

static void snd_harmony_set_new_gain(snd_card_harmony_t *harmony)
{
	DPRINTK(KERN_INFO PFX "Setting new gain %x at %lx\n", harmony->current_gain, harmony->hpa+REG_GAINCTL);
	/* Wait until we're out of control mode */
	while (gsc_readl(harmony->hpa+REG_CNTL) & HARMONY_CNTL_C)
	/* wait */ ;
	
	gsc_writel(harmony->current_gain, harmony->hpa+REG_GAINCTL);
}

#define HARMONY_VOLUME(xname, left_shift, right_shift, mask, invert) \
{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
  .info = snd_harmony_mixercontrol_info, \
  .get = snd_harmony_volume_get, .put = snd_harmony_volume_put, \
  .private_value = left_shift | (right_shift << 8) | (mask << 16) | (invert << 24) }

static int snd_harmony_mixercontrol_info(snd_kcontrol_t * kcontrol, snd_ctl_elem_info_t * uinfo)
{
	int mask = (kcontrol->private_value >> 16) & 0xff;
	int left_shift = (kcontrol->private_value) & 0xff;
	int right_shift = (kcontrol->private_value >> 8) & 0xff;
	
	uinfo->type = (mask == 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER);
	uinfo->count = (left_shift == right_shift) ? 1 : 2;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = mask;
	return 0;
}
 
static int snd_harmony_volume_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
{
	snd_card_harmony_t *harmony = _snd_kcontrol_chip(kcontrol);
	int shift_left = (kcontrol->private_value) & 0xff;
	int shift_right = (kcontrol->private_value >> 8) & 0xff;
	int mask = (kcontrol->private_value >> 16) & 0xff;
	int invert = (kcontrol->private_value >> 24) & 0xff;
	unsigned long flags;
	int left, right;
	
	left = (harmony->current_gain >> shift_left) & mask;
	right = (harmony->current_gain >> shift_right) & mask;

	if (invert) {
		left = mask - left;
		right = mask - right;
	}
	spin_lock_irqsave(&harmony->mixer_lock, flags);
	ucontrol->value.integer.value[0] = left;
	ucontrol->value.integer.value[1] = right;
	spin_unlock_irqrestore(&harmony->mixer_lock, flags);

	return 0;
}                                                                                                                                                                                                                                                       static int snd_harmony_volume_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
{
	snd_card_harmony_t *harmony = _snd_kcontrol_chip(kcontrol);
	int shift_left = (kcontrol->private_value) & 0xff;
	int shift_right = (kcontrol->private_value >> 8) & 0xff;
	int mask = (kcontrol->private_value >> 16) & 0xff;
	int invert = (kcontrol->private_value >> 24) & 0xff;
	unsigned long flags;
	int left, right;
	int old_gain = harmony->current_gain;
	
	left = ucontrol->value.integer.value[0] & mask;
	right = ucontrol->value.integer.value[1] & mask;
	if (invert) {
		left = mask - left;
		right = mask - right;
	}
	
	spin_lock_irqsave(&harmony->mixer_lock, flags);
	harmony->current_gain = harmony->current_gain & ~( (mask << shift_right) | (mask << shift_left));
 	harmony->current_gain = harmony->current_gain | ((left << shift_left) | (right << shift_right) );
	snd_harmony_set_new_gain(harmony);
	spin_unlock_irqrestore(&harmony->mixer_lock, flags);
	return (old_gain - harmony->current_gain);
}                                                                                                                                                                                                                                                                                                            

#define HARMONY_SWITCH(xname, shift, mask) \
{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
  .info = snd_harmony_mixercontrol_info, \
  .get = snd_harmony_switch_get, .put = snd_harmony_switch_put, \
  .private_value = shift | (mask << 16) }

static int snd_harmony_switch_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
{
	snd_card_harmony_t *harmony = _snd_kcontrol_chip(kcontrol);
	unsigned long flags;
	int shift = (kcontrol->private_value) & 0xff;
	int mask = (kcontrol->private_value >> 16) & 0xff;

	spin_lock_irqsave(&harmony->mixer_lock, flags);
	ucontrol->value.integer.value[0] = ((harmony->current_gain >> shift) && mask);
	spin_unlock_irqrestore(&harmony->mixer_lock, flags);
	return 0;
}

static int snd_harmony_switch_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
{
	snd_card_harmony_t *harmony = _snd_kcontrol_chip(kcontrol);
	unsigned long flags;
	int shift = (kcontrol->private_value) & 0xff;
	int mask = (kcontrol->private_value >> 16) & 0xff;
	int value;
	int oldgain = harmony->current_gain;
	
	value = ucontrol->value.integer.value[0] & mask;
	spin_lock_irqsave(&harmony->mixer_lock, flags);
	harmony->current_gain = (harmony->current_gain & (value << shift) );
	snd_harmony_set_new_gain(harmony);
	spin_unlock_irqrestore(&harmony->mixer_lock, flags);
	return (oldgain - harmony->current_gain);
}

#define HARMONY_CONTROLS (sizeof(snd_harmony_controls)/sizeof(snd_kcontrol_new_t))

static snd_kcontrol_new_t snd_harmony_controls[] = {
HARMONY_VOLUME("Input Gain", 12, 16, 0x0f, 1),
HARMONY_VOLUME("Output Attenuation", 6, 0, 0x3f, 0),
HARMONY_VOLUME("Master Volume", 20, 20, 0x0f, 0),
HARMONY_SWITCH("Headphones", 27, 1),
HARMONY_SWITCH("Line output", 26, 1),
HARMONY_SWITCH("Speaker Enable", 25, 1),
HARMONY_SWITCH("Input select", 24, 1)
};

static void snd_harmony_reset_codec(snd_card_harmony_t *harmony)
{
	while (gsc_readl(harmony->hpa+REG_CNTL) & HARMONY_CNTL_C)
		/* Wait */ ;	
	gsc_writel(1, harmony->hpa+REG_RESET);
	mdelay(50);		/* wait 50 ms */
	gsc_writel(0, harmony->hpa+REG_RESET);
}

/*
 * Mute all the output and reset Harmony.
 */

static void __init snd_harmony_mixer_reset(snd_card_harmony_t *harmony)
{
	harmony->current_gain = HARMONY_GAIN_TOTAL_SILENCE;
	snd_harmony_set_new_gain(harmony);
	snd_harmony_reset_codec(harmony);
	harmony->current_gain = HARMONY_GAIN_DEFAULT;
	snd_harmony_set_new_gain(harmony);
}


int __init snd_card_harmony_mixer_init(snd_card_harmony_t *harmony)
{
	snd_card_t *card = harmony->card;
	int idx, err;

	snd_assert(harmony != NULL, return -EINVAL);
	strcpy(card->mixername, "Harmony Gain control interface");

	for (idx = 0; idx < HARMONY_CONTROLS; idx++) {
		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_harmony_controls[idx], harmony))) < 0)
			return err;
	}
	
	snd_harmony_mixer_reset(harmony);

	return 0;
}

static int snd_card_harmony_create(snd_card_t *card, struct parisc_device *pa_dev, snd_card_harmony_t *harmony)
{
	u32	cntl;
	
	harmony->card = card;
	
	/* Set the HPA of harmony */
	harmony->hpa = pa_dev->hpa;
	

	harmony->irq = pa_dev->irq;
	if (!harmony->irq) {
		printk(KERN_ERR PFX "no irq found\n");
		return -ENODEV;
	}

	/* Grab the ID and revision from the device */
	harmony->id = (gsc_readl(harmony->hpa+REG_ID)&0x00ff0000) >> 16;
	if ((harmony->id | 1) != 0x15) {
		printk(KERN_WARNING PFX "wrong harmony id 0x%02x\n", harmony->id);
		return -EBUSY;
	}
	cntl = gsc_readl(harmony->hpa+REG_CNTL);
	harmony->rev = (cntl>>20) & 0xff;

	printk(KERN_INFO "Lasi Harmony Audio driver h/w id %i, rev. %i at 0x%lx, IRQ %i\n",	harmony->id, harmony->rev, pa_dev->hpa, harmony->irq);
	
	/* Make sure the control bit isn't set, although I don't think it 
	   ever is. */
	if (cntl & HARMONY_CNTL_C) {
		printk(KERN_WARNING PFX "CNTL busy\n");
		harmony->hpa = 0;
		return -EBUSY;
	}
	
	/* a fake pci_dev is needed for pci_* functions under ccio */
	harmony->fake_pci_dev = ccio_get_fake(pa_dev);
	return 0;
}
	
static int __init snd_card_harmony_probe(struct parisc_device *pa_dev)
{
	static int dev;
	snd_card_harmony_t *chip;
	snd_card_t *card;
	int err;
	
    if (dev >= SNDRV_CARDS)
		return -ENODEV;
	if (!enable[dev]) {
		dev++;
		return -ENOENT;
	}
	
	snd_harmony_cards[dev] = snd_card_new(index[dev], id[dev], THIS_MODULE,
			    sizeof(snd_card_harmony_t));
	card = snd_harmony_cards[dev];
				
	if (card == NULL)
		return -ENOMEM;
	chip = (struct snd_card_harmony *)card->private_data;
	
	if ((err = snd_card_harmony_create(card, pa_dev, chip)) < 0) {
		printk(KERN_ERR PFX "Creation failed\n");
		snd_card_free(card);
		return err;
	}
	if ((err = snd_card_harmony_pcm_init(chip, dev)) < 0) {
		printk(KERN_ERR PFX "PCM Init failed\n");
		snd_card_free(card);
		return err;
	}
	if ((err = snd_card_harmony_mixer_init(chip)) < 0) {
		printk(KERN_ERR PFX "Mixer init failed\n");
		snd_card_free(card);
		return err;
	}
	
	snd_harmony_proc_init(chip);
	
	strcpy(card->driver, "Harmony");
	strcpy(card->shortname, "ALSA driver for LASI Harmony");
	sprintf(card->longname, "%s at h/w, id %i, rev. %i hpa 0x%lx, IRQ %i\n",card->shortname, chip->id, chip->rev, pa_dev->hpa, chip->irq);

	if ((err = snd_card_register(card)) < 0) {
		snd_card_free(card);
		return err;
	}

	printk(KERN_INFO PFX "Successfully registered harmony pcm backend & mixer %d\n", dev);
	DPRINTK(KERN_INFO PFX "hpa=%lx\n", chip->hpa);
	dev++;
	return 0;
}

static struct parisc_device_id snd_card_harmony_devicetbl[] = {
 { HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x0007A }, /* Bushmaster/Flounder */
 { HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x0007B }, /* 712/715 Audio */
 { HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x0007E }, /* Pace Audio */
 { HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x0007F }, /* Outfield / Coral II */
 { 0, }
};

MODULE_DEVICE_TABLE(parisc, snd_card_harmony_devicetbl);

/*
 * bloc device parisc. c'est une structure qui definit un device
 * que l'on trouve sur parisc. 
 * On y trouve les differents numeros HVERSION correspondant au device
 * en question (ce qui permet a l'inventory de l'identifier) et la fonction
 * d'initialisation du chose 
 */

static struct parisc_driver snd_card_harmony_driver = {
	name:		"Lasi ALSA Harmony",
	id_table:	snd_card_harmony_devicetbl,
	probe:		snd_card_harmony_probe,
};

static int __init alsa_card_harmony_init(void)
{
	int err;
	
	if ((err = register_parisc_driver(&snd_card_harmony_driver)) < 0) {
		printk(KERN_ERR "Harmony soundcard not found or device busy\n");
		return err;
	}

	return 0;
}

static void __exit alsa_card_harmony_exit(void)
{
	int idx;
	snd_card_harmony_t *harmony;
	
	for (idx = 0; idx < SNDRV_CARDS; idx++)
	{
		if (snd_harmony_cards[idx] != NULL)
		{	
			DPRINTK(KERN_INFO PFX "Freeing card %d\n", idx);
			harmony = snd_harmony_cards[idx]->private_data;
			snd_harmony_proc_done(harmony);
			free_irq(harmony->irq, snd_card_harmony_interrupt);
			DPRINTK(KERN_INFO PFX "Card unloaded %d, irq=%d\n", idx, harmony->irq);
			snd_card_free(snd_harmony_cards[idx]);
		}
	}	
}

module_init(alsa_card_harmony_init)
module_exit(alsa_card_harmony_exit)

--Multipart_Fri__6_Dec_2002_20:10:02_+0100_082d3da8--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

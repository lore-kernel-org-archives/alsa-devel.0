From: Konstantin Kletschke <lists@ku-gbr.de>
Subject: Re: Re :  ice1724/Audiotrak Prodigy 7.1 HiFi
Date: Fri, 5 Jan 2007 13:52:11 +0100
Message-ID: <20070105125211.GA19866@anita.doom>
References: <20070102151108.GA10561@synertronixx3>
	<1167850413l.15450l.0l@zerox>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1167850413l.15450l.0l@zerox>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Am 2007-01-03 22:53 +0400 schrieb Elie Morisse:

> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1556


Well, I tryed this approach and things went pretty well. To simplify my
coding approach I put prodigy_hifi among fortissimo4. 
But for now remote hacking was stopped :(

Jan  5 12:44:28 anita ACPI: PCI Interrupt 0000:
01:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
Jan  5 12:44:28 anita ich bins, konsti!!!
Jan  5 12:44:28 anita Unable to handle kernel NULL pointer dereference at 000000000000003a RIP:
Jan  5 12:44:28 anita [<ffffffff88189237>] :snd_ice1724:wm_put+0x28/0x43
Jan  5 12:44:28 anita PGD 71831067 PUD 70f01067 PMD 0
Jan  5 12:44:28 anita Oops: 0002 [1] PREEMPT SMP
Jan  5 12:44:28 anita CPU 1
Jan  5 12:44:28 anita Modules linked in: snd_ice1724 snd_seq_midi snd_seq_midi_event snd_seq snd_hda_intel snd_hda_
codec snd_ens1371 snd_ice17xx_ak4xxx snd_ac97_codec snd_ac97_bus snd_ak4114 snd_pcm snd_timer snd_page_alloc snd_pt
2258 snd_i2c snd_ak4xxx_adda snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rtc evdev usbhid xfs ehci_hcd
 ohci_hcd usbcore forcedeth
Jan  5 12:44:28 anita Pid: 19618, comm: modprobe Not tainted 2.6.19-gentoo-r2 #4
Jan  5 12:44:28 anita RIP: 0010:[<ffffffff88189237>]  [<ffffffff88189237>] :snd_ice1724:wm_put+0x28/0x43
Jan  5 12:44:28 anita RSP: 0018:ffff810076c3fce8  EFLAGS: 00010256
Jan  5 12:44:28 anita RAX: 0000000000000000 RBX: ffff81007c128028 RCX: 0000000000000000
Jan  5 12:44:28 anita RDX: 000000000000002a RSI: 000000000000002a RDI: ffff81007c128288
Jan  5 12:44:28 anita RBP: 0000000000000003 R08: ffff810076c3e000 R09: ffff81007b3a5b38
Jan  5 12:44:28 anita R10: 0000000000000000 R11: ffffffff8022c4d7 R12: 0000000000000015
Jan  5 12:44:28 anita R13: 0000000000000006 R14: 0000000000000000 R15: ffff81007c128428
Jan  5 12:44:28 anita FS:  00002abf06204ae0(0000) GS:ffff81007e20bd40(0000) knlGS:0000000000000000
Jan  5 12:44:28 anita CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jan  5 12:44:28 anita CR2: 000000000000003a CR3: 000000007922c000 CR4: 00000000000006e0
Jan  5 12:44:28 anita Process modprobe (pid: 19618, threadinfo ffff810076c3e000, task ffff81007db41080)
Jan  5 12:44:28 anita Stack:  ffff81007c128028 0000000000000001 0000000038315441 ffffffff88189738
Jan  5 12:44:28 anita ffff81007c128028 0000000000000000 ffff81007c128028 ffffffff88183082
Jan  5 12:44:28 anita 0000000000000001 0000000000000000 ffff81007dbda800 ffff81007c12843c
Jan  5 12:44:28 anita Call Trace:
Jan  5 12:44:28 anita [<ffffffff88189738>] :snd_ice1724:prodigy_hifi_init+0x59/0x95
Jan  5 12:44:28 anita [<ffffffff88183082>] :snd_ice1724:snd_vt1724_probe+0x6ec/0xd80
Jan  5 12:44:28 anita [<ffffffff8027852e>] task_rq_lock+0x3d/0x6f
Jan  5 12:44:28 anita [<ffffffff802799b9>] set_cpus_allowed+0xa5/0xb2
Jan  5 12:44:28 anita [<ffffffff8022a990>] __wake_up+0x38/0x4e
Jan  5 12:44:28 anita [<ffffffff80303dec>] pci_device_probe+0xcd/0x135
Jan  5 12:44:28 anita [<ffffffff8034b02e>] really_probe+0x4c/0xe5
Jan  5 12:44:28 anita [<ffffffff8034b1d8>] __driver_attach+0x0/0x92
Jan  5 12:44:28 anita [<ffffffff8034b232>] __driver_attach+0x5a/0x92
Jan  5 12:44:28 anita [<ffffffff8034a636>] bus_for_each_dev+0x43/0x6e
Jan  5 12:44:28 anita [<ffffffff8034a97e>] bus_add_driver+0x6b/0x18d
Jan  5 12:44:28 anita [<ffffffff80303ffa>] __pci_register_driver+0x8d/0xb3
Jan  5 12:44:28 anita [<ffffffff802908d3>] sys_init_module+0xaf/0x227
Jan  5 12:44:28 anita [<ffffffff80256c3e>] system_call+0x7e/0x83
Jan  5 12:44:28 anita
Jan  5 12:44:28 anita
Jan  5 12:44:28 anita Code: 88 44 0a 10 8d 56 01 48 8b 83 10 02 00 00 48 63 d2 40 88 6c
Jan  5 12:44:28 anita RIP  [<ffffffff88189237>] :snd_ice1724:wm_put+0x28/0x43
Jan  5 12:44:28 anita RSP <ffff810076c3fce8>
Jan  5 12:44:28 anita CR2: 000000000000003a

Could somebody of you experienced alsa coders tell me where it 
possibly crashed?
wm_put() in my new prodigy_hifi.c looks similiar to the one in pontis.c
(also wm_put_nocache()), the latter worked yesterday...

Kind Regards, Konsti


-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

--17pEHd4RhPHOinZp
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="prodigy_hifi.c"

#include <sound/driver.h>
#include <asm/io.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/mutex.h>

#include <sound/core.h>
#include <sound/info.h>
#include <sound/tlv.h>

#include "ice1712.h"
#include "envy24ht.h"
#include "prodigy_hifi.h"

/* I2C addresses */
#define WM_DEV		0x34
// #define CS_DEV		0x20

/* WM8776 registers */
#define WM_HP_ATTEN_L		0x00	/* headphone left attenuation */
#define WM_HP_ATTEN_R		0x01	/* headphone left attenuation */
#define WM_HP_MASTER		0x02	/* headphone master (both channels), override LLR */
#define WM_DAC_ATTEN_L		0x03	/* digital left attenuation */
#define WM_DAC_ATTEN_R		0x04
#define WM_DAC_MASTER		0x05
#define WM_PHASE_SWAP		0x06	/* DAC phase swap */
#define WM_DAC_CTRL1		0x07
#define WM_DAC_MUTE		0x08
#define WM_DAC_CTRL2		0x09
#define WM_DAC_INT		0x0a
#define WM_ADC_INT		0x0b
#define WM_MASTER_CTRL		0x0c
#define WM_POWERDOWN		0x0d
#define WM_ADC_ATTEN_L		0x0e
#define WM_ADC_ATTEN_R		0x0f
#define WM_ALC_CTRL1		0x10
#define WM_ALC_CTRL2		0x11
#define WM_ALC_CTRL3		0x12
#define WM_NOISE_GATE		0x13
#define WM_LIMITER		0x14
#define WM_ADC_MUX		0x15
#define WM_OUT_MUX		0x16
#define WM_RESET		0x17

// Analog Recording Source :- Mic, LineIn, CD/Video,

/* implement capture source select control for WM8776 */

#define WM_AIN1 "Line In"
#define WM_AIN2 "Mic"
#define WM_AIN3 "CD/Video"
#define WM_AIN4 "AIN4"
#define WM_AIN5 "AIN5"

// /*
//  * GPIO
//  */
// #define PONTIS_CS_CS		(1<<4)	/* CS */
// #define PONTIS_CS_CLK		(1<<5)	/* CLK */
// #define PONTIS_CS_RDATA		(1<<6)	/* CS8416 -> VT1720 */
// #define PONTIS_CS_WDATA		(1<<7)	/* VT1720 -> CS8416 */


/*
 * get the current register value of WM codec
 */
static unsigned short wm_get(struct snd_ice1712 *ice, int reg)
{
	reg <<= 1;
	return ((unsigned short)ice->akm[0].images[reg] << 8) |
		ice->akm[0].images[reg + 1];
}

/*
 * set the register value of WM codec and remember it
 */
static void wm_put_nocache(struct snd_ice1712 *ice, int reg, unsigned short val)
{
	unsigned short cval;
	cval = (reg << 9) | val;
	snd_vt1724_write_i2c(ice, WM_DEV, cval >> 8, cval & 0xff);
}

static void wm_put(struct snd_ice1712 *ice, int reg, unsigned short val)
{
	wm_put_nocache(ice, reg, val);
	reg <<= 1;
	ice->akm[0].images[reg] = val >> 8;
	ice->akm[0].images[reg + 1] = val;
}

/*
 * DAC volume attenuation mixer control (-64dB to 0dB)
 */

#define DAC_0dB	0xff
#define DAC_RES	128
#define DAC_MIN	(DAC_0dB - DAC_RES)

static int wm_dac_vol_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
	uinfo->count = 2;
	uinfo->value.integer.min = 0;	/* mute */
	uinfo->value.integer.max = DAC_RES;	/* 0dB, 0.5dB step */
	return 0;
}

static int wm_dac_vol_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	unsigned short val;
	int i;

	mutex_lock(&ice->gpio_mutex);
	for (i = 0; i < 2; i++) {
		val = wm_get(ice, WM_DAC_ATTEN_L + i) & 0xff;
		val = val > DAC_MIN ? (val - DAC_MIN) : 0;
		ucontrol->value.integer.value[i] = val;
	}
	mutex_unlock(&ice->gpio_mutex);
	return 0;
}

static int wm_dac_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	unsigned short oval, nval;
	int i, idx, change = 0;

	mutex_lock(&ice->gpio_mutex);
	for (i = 0; i < 2; i++) {
		nval = ucontrol->value.integer.value[i];
		nval = (nval ? (nval + DAC_MIN) : 0) & 0xff;
		idx = WM_DAC_ATTEN_L + i;
		oval = wm_get(ice, idx) & 0xff;
		if (oval != nval) {
			wm_put(ice, idx, nval);
			wm_put_nocache(ice, idx, nval | 0x100);
			change = 1;
		}
	}
	mutex_unlock(&ice->gpio_mutex);
	return change;
}

/* KONSTI */

static int wm_adc_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
{
	static char* texts[32] = {"NULL", WM_AIN1, WM_AIN2, WM_AIN1 "+" WM_AIN2,
				  WM_AIN3, WM_AIN1 "+" WM_AIN3, WM_AIN2 "+" WM_AIN3,
				  WM_AIN1 "+" WM_AIN2 "+" WM_AIN3,
				  WM_AIN4, WM_AIN1 "+" WM_AIN4, WM_AIN2 "+" WM_AIN4,
				  WM_AIN1 "+" WM_AIN2 "+" WM_AIN4,
				  WM_AIN3 "+" WM_AIN4, WM_AIN1 "+" WM_AIN3 "+" WM_AIN4,
				  WM_AIN2 "+" WM_AIN3 "+" WM_AIN4,
				  WM_AIN1 "+" WM_AIN2 "+" WM_AIN3 "+" WM_AIN4,
				  WM_AIN5, WM_AIN1 "+" WM_AIN5, WM_AIN2 "+" WM_AIN5,
				  WM_AIN1 "+" WM_AIN2 "+" WM_AIN5,
				  WM_AIN3 "+" WM_AIN5, WM_AIN1 "+" WM_AIN3 "+" WM_AIN5,
				  WM_AIN2 "+" WM_AIN3 "+" WM_AIN5,
				  WM_AIN1 "+" WM_AIN2 "+" WM_AIN3 "+" WM_AIN5,
				  WM_AIN4 "+" WM_AIN5, WM_AIN1 "+" WM_AIN4 "+" WM_AIN5,
				  WM_AIN2 "+" WM_AIN4 "+" WM_AIN5,
				  WM_AIN1 "+" WM_AIN2 "+" WM_AIN4 "+" WM_AIN5,
				  WM_AIN3 "+" WM_AIN4 "+" WM_AIN5,
				  WM_AIN1 "+" WM_AIN3 "+" WM_AIN4 "+" WM_AIN5,
				  WM_AIN2 "+" WM_AIN3 "+" WM_AIN4 "+" WM_AIN5,
				  WM_AIN1 "+" WM_AIN2 "+" WM_AIN3 "+" WM_AIN4 "+" WM_AIN5};

	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
	uinfo->count = 1;
	uinfo->value.enumerated.items = 32;
	if (uinfo->value.enumerated.item > 31)
		uinfo->value.enumerated.item = 31;
	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
	return 0;
}

static int wm_adc_mux_enum_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);

	mutex_lock(&ice->gpio_mutex);
	ucontrol->value.integer.value[0]=wm_get(ice, WM_ADC_MUX) & 0x1f;
	mutex_unlock(&ice->gpio_mutex);
	return 0;
}

static int wm_adc_mux_enum_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	unsigned short oval, nval;

	mutex_lock(&ice->gpio_mutex);
	oval = wm_get(ice, WM_ADC_MUX);
        nval = ( oval & 0xe0 ) | ucontrol->value.integer.value[0] ;
	if ( nval != oval ) {
		wm_put(ice, WM_ADC_MUX, nval);
	}
	mutex_unlock(&ice->gpio_mutex);
	return 0;
}

/* KONSTI */

/*
 * ADC gain mixer control (-64dB to 0dB)
 */

#define ADC_0dB	0xcf
#define ADC_RES	128
#define ADC_MIN	(ADC_0dB - ADC_RES)

static int wm_adc_vol_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
	uinfo->count = 2;
	uinfo->value.integer.min = 0;	/* mute (-64dB) */
	uinfo->value.integer.max = ADC_RES;	/* 0dB, 0.5dB step */
	return 0;
}

static int wm_adc_vol_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	unsigned short val;
	int i;

	mutex_lock(&ice->gpio_mutex);
	for (i = 0; i < 2; i++) {
		val = wm_get(ice, WM_ADC_ATTEN_L + i) & 0xff;
		val = val > ADC_MIN ? (val - ADC_MIN) : 0;
		ucontrol->value.integer.value[i] = val;
	}
	mutex_unlock(&ice->gpio_mutex);
	return 0;
}

static int wm_adc_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	unsigned short ovol, nvol;
	int i, idx, change = 0;

	mutex_lock(&ice->gpio_mutex);
	for (i = 0; i < 2; i++) {
		nvol = ucontrol->value.integer.value[i];
		nvol = nvol ? (nvol + ADC_MIN) : 0;
		idx  = WM_ADC_ATTEN_L + i;
		ovol = wm_get(ice, idx) & 0xff;
		if (ovol != nvol) {
			wm_put(ice, idx, nvol);
			change = 1;
		}
	}
	mutex_unlock(&ice->gpio_mutex);
	return change;
}

/*
 * ADC input mux mixer control
 */
static int wm_adc_mux_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
	uinfo->count = 1;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = 1;
	return 0;
}

static int wm_adc_mux_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	int bit = kcontrol->private_value;

	mutex_lock(&ice->gpio_mutex);
	ucontrol->value.integer.value[0] = (wm_get(ice, WM_ADC_MUX) & (1 << bit)) ? 1 : 0;
	mutex_unlock(&ice->gpio_mutex);
	return 0;
}

static int wm_adc_mux_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	int bit = kcontrol->private_value;
	unsigned short oval, nval;
	int change;

	mutex_lock(&ice->gpio_mutex);
	nval = oval = wm_get(ice, WM_ADC_MUX);
	if (ucontrol->value.integer.value[0])
		nval |= (1 << bit);
	else
		nval &= ~(1 << bit);
	change = nval != oval;
	if (change) {
		wm_put(ice, WM_ADC_MUX, nval);
	}
	mutex_unlock(&ice->gpio_mutex);
	return 0;
}

/*
 * Analog bypass (In -> Out)
 */
static int wm_bypass_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
	uinfo->count = 1;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = 1;
	return 0;
}

static int wm_bypass_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);

	mutex_lock(&ice->gpio_mutex);
	ucontrol->value.integer.value[0] = (wm_get(ice, WM_OUT_MUX) & 0x04) ? 1 : 0;
	mutex_unlock(&ice->gpio_mutex);
	return 0;
}

static int wm_bypass_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	unsigned short val, oval;
	int change = 0;

	mutex_lock(&ice->gpio_mutex);
	val = oval = wm_get(ice, WM_OUT_MUX);
	if (ucontrol->value.integer.value[0])
		val |= 0x04;
	else
		val &= ~0x04;
	if (val != oval) {
		wm_put(ice, WM_OUT_MUX, val);
		change = 1;
	}
	mutex_unlock(&ice->gpio_mutex);
	return change;
}

/*
 * Left/Right swap
 */
static int wm_chswap_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
	uinfo->count = 1;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = 1;
	return 0;
}

static int wm_chswap_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);

	mutex_lock(&ice->gpio_mutex);
	ucontrol->value.integer.value[0] = (wm_get(ice, WM_DAC_CTRL1) & 0xf0) != 0x90;
	mutex_unlock(&ice->gpio_mutex);
	return 0;
}

static int wm_chswap_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
{
	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
	unsigned short val, oval;
	int change = 0;

	mutex_lock(&ice->gpio_mutex);
	oval = wm_get(ice, WM_DAC_CTRL1);
	val = oval & 0x0f;
	if (ucontrol->value.integer.value[0])
		val |= 0x60;
	else
		val |= 0x90;
	if (val != oval) {
		wm_put(ice, WM_DAC_CTRL1, val);
		wm_put_nocache(ice, WM_DAC_CTRL1, val);
		change = 1;
	}
	mutex_unlock(&ice->gpio_mutex);
	return change;
}

static DECLARE_TLV_DB_SCALE(db_scale_volume, -6400, 50, 1);

/*
 * mixers
 */

static struct snd_kcontrol_new prodigy_hifi_controls[] __devinitdata = {
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
		.name = "PCM Playback Volume",
		.info = wm_dac_vol_info,
		.get = wm_dac_vol_get,
		.put = wm_dac_vol_put,
		.tlv = { .p = db_scale_volume },
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
		.name = "Capture Volume",
		.info = wm_adc_vol_info,
		.get = wm_adc_vol_get,
		.put = wm_adc_vol_put,
		.tlv = { .p = db_scale_volume },
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "CD Capture Switch",
		.info = wm_adc_mux_info,
		.get = wm_adc_mux_get,
		.put = wm_adc_mux_put,
		.private_value = 0,
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Line Capture Switch",
		.info = wm_adc_mux_info,
		.get = wm_adc_mux_get,
		.put = wm_adc_mux_put,
		.private_value = 1,
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Analog Bypass Switch",
		.info = wm_bypass_info,
		.get = wm_bypass_get,
		.put = wm_bypass_put,
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Swap Output Channels",
		.info = wm_chswap_info,
		.get = wm_chswap_get,
		.put = wm_chswap_put,
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Analog Capture Source",
		.info = wm_adc_mux_enum_info,
		.get = wm_adc_mux_enum_get,
		.put = wm_adc_mux_enum_put,
	},
};

/*
 * WM codec registers
 */
static void wm_proc_regs_write(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
{
	struct snd_ice1712 *ice = (struct snd_ice1712 *)entry->private_data;
	char line[64];
	unsigned int reg, val;
	mutex_lock(&ice->gpio_mutex);
	while (!snd_info_get_line(buffer, line, sizeof(line))) {
		if (sscanf(line, "%x %x", &reg, &val) != 2)
			continue;
		if (reg <= 0x17 && val <= 0xffff)
			wm_put(ice, reg, val);
	}
	mutex_unlock(&ice->gpio_mutex);
}

static void wm_proc_regs_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
{
	struct snd_ice1712 *ice = (struct snd_ice1712 *)entry->private_data;
	int reg, val;

	mutex_lock(&ice->gpio_mutex);
	for (reg = 0; reg <= 0x17; reg++) {
		val = wm_get(ice, reg);
		snd_iprintf(buffer, "%02x = %04x\n", reg, val);
	}
	mutex_unlock(&ice->gpio_mutex);
}

static void wm_proc_init(struct snd_ice1712 *ice)
{
	struct snd_info_entry *entry;
	if (! snd_card_proc_new(ice->card, "wm_codec", &entry)) {
		snd_info_set_text_ops(entry, ice, wm_proc_regs_read);
		entry->mode |= S_IWUSR;
		entry->c.text.write = wm_proc_regs_write;
	}
}

static int __devinit prodigy_hifi_add_controls(struct snd_ice1712 *ice)
{
	unsigned int i;
	int err;

	for (i = 0; i < ARRAY_SIZE(prodigy_hifi_controls); i++) {
		err = snd_ctl_add(ice->card, snd_ctl_new1(&prodigy_hifi_controls[i], ice));
		if (err < 0)
			return err;
	}

	wm_proc_init(ice);
// 	cs_proc_init(ice);

	return 0;
}


/*
 * initialize the chip
 */
static int __devinit prodigy_hifi_init(struct snd_ice1712 *ice)
{
	static unsigned short wm_inits[] = {
		/* These come first to reduce init pop noise */
		WM_ADC_MUX,	0x0003,	/* ADC mute */
		/* 0x00c0 replaced by 0x0003 */
		
		WM_DAC_MUTE,	0x0001,	/* DAC softmute */
		WM_DAC_CTRL1,	0x0000,	/* DAC mute */

		WM_POWERDOWN,	0x0008,	/* All power-up except HP */
		WM_RESET,	0x0000,	/* reset */
	};
	static unsigned short wm_inits2[] = {
		WM_MASTER_CTRL,	0x0022,	/* 256fs, slave mode */
		WM_DAC_INT,	0x0022,	/* I2S, normal polarity, 24bit */
		WM_ADC_INT,	0x0022,	/* I2S, normal polarity, 24bit */
		WM_DAC_CTRL1,	0x0090,	/* DAC L/R */
		WM_OUT_MUX,	0x0001,	/* OUT DAC */
		WM_HP_ATTEN_L,	0x0179,	/* HP 0dB */
		WM_HP_ATTEN_R,	0x0179,	/* HP 0dB */
		WM_DAC_ATTEN_L,	0x0000,	/* DAC 0dB */
		WM_DAC_ATTEN_L,	0x0100,	/* DAC 0dB */
		WM_DAC_ATTEN_R,	0x0000,	/* DAC 0dB */
		WM_DAC_ATTEN_R,	0x0100,	/* DAC 0dB */
		// WM_DAC_MASTER,	0x0100,	/* DAC master muted */
		WM_PHASE_SWAP,	0x0000,	/* phase normal */
		WM_DAC_CTRL2,	0x0000,	/* no deemphasis, no ZFLG */
		WM_ADC_ATTEN_L,	0x0000,	/* ADC muted */
		WM_ADC_ATTEN_R,	0x0000,	/* ADC muted */
#if 0
		WM_ALC_CTRL1,	0x007b,	/* */
		WM_ALC_CTRL2,	0x0000,	/* */
		WM_ALC_CTRL3,	0x0000,	/* */
		WM_NOISE_GATE,	0x0000,	/* */
#endif
		WM_DAC_MUTE,	0x0000,	/* DAC unmute */
		WM_ADC_MUX,	0x0003,	/* ADC unmute, both CD/Line On */
	};

	unsigned int i;

	ice->vt1724 = 1;
	ice->num_total_dacs = 1;
	ice->num_total_adcs = 1;
	printk("ich bins, konsti!!!\n");

	/* HACK - use this as the SPDIF source.
	 * don't call snd_ice1712_gpio_get/put(), otherwise it's overwritten
	 */
	ice->gpio.saved[0] = 0;

	/* initialize WM8776 codec */
	for (i = 0; i < ARRAY_SIZE(wm_inits); i += 2)
		wm_put(ice, wm_inits[i], wm_inits[i+1]);
	schedule_timeout_uninterruptible(1);
	for (i = 0; i < ARRAY_SIZE(wm_inits2); i += 2)
		wm_put(ice, wm_inits2[i], wm_inits2[i+1]);


	return 0;
}
static unsigned char prodigy_hifi_eeprom[] __devinitdata = {
        0x08,   /* SYSCONF: clock 256, mpu401, spdif-in/ADC, 1DAC */
        0x80,   /* ACLINK: I2S */
        0xf8,   /* I2S: vol, 96k, 24bit, 192k */
        0xc3,   /* SPDIF: out-en, out-int, spdif-in */
        0x07,   /* GPIO_DIR */
        0x00,   /* GPIO_DIR1 */
        0x00,   /* GPIO_DIR2 (ignored) */
        0x0f,   /* GPIO_MASK (4-7 reserved for CS8416) */
        0xff,   /* GPIO_MASK1 */
        0x00,   /* GPIO_MASK2 (ignored) */
        0x06,   /* GPIO_STATE (0-low, 1-high, 2-high) */
        0x00,   /* GPIO_STATE1 */
        0x00,   /* GPIO_STATE2 (ignored) */                                                                                                         
};
          
/* entry point */
struct snd_ice1712_card_info snd_vt1724_prodigy_hifi_cards[] __devinitdata = {
	{
		.subvendor = VT1724_SUBDEVICE_PRODIGY_HIFI,
		.name = "Audiotrak Prodigy 7.1 HiFi",
		.model = "prodigy71hifi",
		.chip_init = prodigy_hifi_init,
		.build_controls = prodigy_hifi_add_controls,
                .eeprom_size = sizeof(prodigy_hifi_eeprom),                                                                   
                .eeprom_data = prodigy_hifi_eeprom,                             
/*
		.eeprom_size = 0,
		.eeprom_data = NULL,
*/
	},
	{ } /* terminator */
};


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--17pEHd4RhPHOinZp--

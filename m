From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 1/8] emu10k1 multichannel support
Date: Tue, 15 Feb 2005 19:42:02 -0500
Message-ID: <1108514522.3772.24.camel@krustophenia.net>
References: <1108514291.3772.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-F4YX550+t9LW2rhnOE2E"
In-Reply-To: <1108514291.3772.19.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-F4YX550+t9LW2rhnOE2E
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:38 -0500, Lee Revell wrote:
> This series of patches adds a 16 channel non interleaved PCM playback
> device, hw:x,3, to the emu10k1 driver.

Update header file for multichannel support.  Add some new register
info.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>


--=-F4YX550+t9LW2rhnOE2E
Content-Disposition: attachment; filename=emu10k1.h.patch
Content-Type: text/x-patch; name=emu10k1.h.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-v012/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.55
diff -u -r1.55 emu10k1.h
--- alsa-v012/alsa-kernel/include/emu10k1.h	10 Feb 2005 11:52:50 -0000	1.55
+++ alsa-v012/alsa-kernel/include/emu10k1.h	16 Feb 2005 00:06:03 -0000
@@ -51,7 +81,9 @@
 #define NUM_MIDI        16
 #define NUM_G           64              /* use all channels */
 #define NUM_FXSENDS     4
+#define NUM_EFX_PLAYBACK    16
 
+/* FIXME? - according to the OSS driver the EMU10K1 needs a 29 bit DMA mask */
 #define EMU10K1_DMA_MASK	0x7fffffffUL	/* 31bit */
 #define AUDIGY_DMA_MASK		0xffffffffUL	/* 32bit */
 
@@ -82,10 +114,16 @@
 						/* Clear pending interrupts by writing a 1 to	*/
 						/* the relevant bits and zero to the other bits	*/
 
+#define IPR_GPIOMSG		0x20000000	/* GPIO message interrupt (RE'd, still not sure 
+						   which INTE bits enable it)			*/
+
 /* The next two interrupts are for the midi port on the Audigy Drive (A_MPU1)			*/
 #define IPR_A_MIDITRANSBUFEMPTY2 0x10000000	/* MIDI UART transmit buffer empty		*/
 #define IPR_A_MIDIRECVBUFEMPTY2	0x08000000	/* MIDI UART receive buffer empty		*/
 
+#define IPR_SPDIFBUFFULL	0x04000000	/* SPDIF capture related, 10k2 only? (RE)	*/
+#define IPR_SPDIFBUFHALFFULL	0x02000000	/* SPDIF capture related? (RE)			*/
+
 #define IPR_SAMPLERATETRACKER	0x01000000	/* Sample rate tracker lock status change	*/
 #define IPR_FXDSP		0x00800000	/* Enable FX DSP interrupts			*/
 #define IPR_FORCEINT		0x00400000	/* Force Sound Blaster interrupt		*/
@@ -104,12 +142,12 @@
 #define IPR_INTERVALTIMER	0x00000200	/* Interval timer terminal count		*/
 #define IPR_MIDITRANSBUFEMPTY	0x00000100	/* MIDI UART transmit buffer empty		*/
 #define IPR_MIDIRECVBUFEMPTY	0x00000080	/* MIDI UART receive buffer empty		*/
-#define IPR_CHANNELLOOP		0x00000040	/* One or more channel loop interrupts pending	*/
+#define IPR_CHANNELLOOP		0x00000040	/* Channel (half) loop interrupt(s) pending	*/
 #define IPR_CHANNELNUMBERMASK	0x0000003f	/* When IPR_CHANNELLOOP is set, indicates the	*/
-						/* Highest set channel in CLIPL or CLIPH.  When	*/
-						/* IP is written with CL set, the bit in CLIPL	*/
-						/* or CLIPH corresponding to the CIN value 	*/
-						/* written will be cleared.			*/
+						/* highest set channel in CLIPL, CLIPH, HLIPL,  */
+						/* or HLIPH.  When IP is written with CL set,	*/
+						/* the bit in H/CLIPL or H/CLIPH corresponding	*/
+						/* to the CIN value written will be cleared.	*/
 
 #define INTE			0x0c		/* Interrupt enable register			*/
 #define INTE_VIRTUALSB_MASK	0xc0000000	/* Virtual Soundblaster I/O port capture	*/
@@ -236,9 +274,27 @@
 #define A_IOCFG			0x18		/* GPIO on Audigy card (16bits)			*/
 #define A_GPINPUT_MASK		0xff00
 #define A_GPOUTPUT_MASK		0x00ff
-#define A_IOCFG_GPOUT0		0x0044		/* analog/digital? */
-#define A_IOCFG_GPOUT1		0x0002		/* IR */
+
+// Audigy output/GPIO stuff taken from the kX drivers
+#define A_IOCFG_GPOUT0		0x0044		/* analog/digital				*/
+#define A_IOCFG_DISABLE_ANALOG	0x0040		/* = 'enable' for Audigy2 (chiprev=4)		*/
+#define A_IOCFG_ENABLE_DIGITAL	0x0004
+#define A_IOCFG_UNKNOWN_20      0x0020
+#define A_IOCFG_DISABLE_AC97_FRONT      0x0080  /* turn off ac97 front -> front (10k2.1)	*/
+#define A_IOCFG_GPOUT1		0x0002		/* IR? drive's internal bypass (?)		*/
 #define A_IOCFG_GPOUT2		0x0001		/* IR */
+#define A_IOCFG_MULTIPURPOSE_JACK	0x2000  /* center+lfe+rear_center (a2/a2ex)		*/
+                                                /* + digital for generic 10k2			*/
+#define A_IOCFG_DIGITAL_JACK    0x1000          /* digital for a2 platinum			*/
+#define A_IOCFG_FRONT_JACK      0x4000
+#define A_IOCFG_REAR_JACK       0x8000
+#define A_IOCFG_PHONES_JACK     0x0100          /* LiveDrive					*/
+
+/* outputs:
+ *	for audigy2 platinum:	0xa00
+ *	for a2 platinum ex:	0x1c00
+ *	for a1 platinum:	0x0
+ */
 
 #define TIMER			0x1a		/* Timer terminal count register		*/
 						/* NOTE: After the rate is changed, a maximum	*/
@@ -464,6 +520,8 @@
 						/* NOTE: All channels contain internal variables; do	*/
 						/* not write to these locations.			*/
 
+/* 1f something */
+
 #define CD0			0x20		/* Cache data 0 register				*/
 #define CD1			0x21		/* Cache data 1 register				*/
 #define CD2			0x22		/* Cache data 2 register				*/
@@ -481,6 +539,8 @@
 #define CDE			0x2e		/* Cache data E register				*/
 #define CDF			0x2f		/* Cache data F register				*/
 
+/* 0x30-3f seem to be the same as 0x20-2f */
+
 #define PTB			0x40		/* Page table base register				*/
 #define PTB_MASK		0xfffff000	/* Physical address of the page table in host memory	*/
 
@@ -511,7 +571,11 @@
 
 #define FXWC			0x43		/* FX output write channels register			*/
 						/* When set, each bit enables the writing of the	*/
-						/* corresponding FX output channel into host memory	*/
+						/* corresponding FX output channel (internal registers  */
+						/* 0x20-0x3f) to host memory.  This mode of recording   */
+						/* is 16bit, 48KHz only. All 32 channels can be enabled */
+						/* simultaneously.					*/
+
 #define FXWC_DEFAULTROUTE_C     (1<<0)		/* left emu out? */
 #define FXWC_DEFAULTROUTE_B     (1<<1)		/* right emu out? */
 #define FXWC_DEFAULTROUTE_A     (1<<12)
@@ -546,12 +610,16 @@
 #define FXBA			0x47		/* FX Buffer Address */
 #define FXBA_MASK		0xfffff000	/* 20 bit base address					*/
 
+/* 0x48 something - word access, defaults to 3f */
+
 #define MICBS			0x49		/* Microphone buffer size register			*/
 
 #define ADCBS			0x4a		/* ADC buffer size register				*/
 
 #define FXBS			0x4b		/* FX buffer size register				*/
 
+/* register: 0x4c..4f: ffff-ffff current amounts, per-channel */
+
 /* The following mask values define the size of the ADC, MIX and FX buffers in bytes */
 #define ADCBS_BUFSIZE_NONE	0x00000000
 #define ADCBS_BUFSIZE_384	0x00000001
@@ -602,6 +670,7 @@
 #define A_DBG_SATURATION_OCCURED 0x20000000
 #define A_DBG_SATURATION_ADDR	 0x0ffc0000
 
+// NOTE: 0x54,55,56: 64-bit
 #define SPCS0			0x54		/* SPDIF output Channel Status 0 register	*/
 
 #define SPCS1			0x55		/* SPDIF output Channel Status 1 register	*/
@@ -657,6 +726,7 @@
 #define AC97SLOT_CNTR		0x10            /* Center enable */
 #define AC97SLOT_LFE		0x20            /* LFE enable */
 
+// NOTE: 0x60,61,62: 64-bit
 #define CDSRCS			0x60		/* CD-ROM Sample Rate Converter status register	*/
 
 #define GPSRCS			0x61		/* General Purpose SPDIF sample rate cvt status */
@@ -693,6 +763,19 @@
 #define FXIDX_MASK		0x0000ffff	/* 16-bit value					*/
 #define FXIDX_IDX		0x10000065
 
+/* The 32-bit HLIx and HLIPx registers all have one bit per channel control/status      		*/
+#define HLIEL			0x66		/* Channel half loop interrupt enable low register	*/
+
+#define HLIEH			0x67		/* Channel half loop interrupt enable high register	*/
+
+#define HLIPL			0x68		/* Channel half loop interrupt pending low register	*/
+
+#define HLIPH			0x69		/* Channel half loop interrupt pending high register	*/
+
+// 0x6a,6b,6c used for some recording
+// 0x6d unused
+// 0x6e,6f - tanktable base / offset
+
 /* This is the MPU port on the card (via the game port)						*/
 #define A_MUDATA1		0x70
 #define A_MUCMD1		0x71
@@ -715,6 +798,9 @@
 #define A_SPDIF_44100		0x00000040
 #define A_SPDIF_96000		0x00000080
 
+/* 0x77,0x78,0x79 "something i2s-related" - default to 0x01080000 on my audigy 2 ZS --rlrevell	*/
+/* 0x7a, 0x7b - lookup tables */
+
 #define A_FXRT2			0x7c
 #define A_FXRT_CHANNELE		0x0000003f	/* Effects send bus number for channel's effects send E	*/
 #define A_FXRT_CHANNELF		0x00003f00	/* Effects send bus number for channel's effects send F	*/
@@ -726,7 +812,8 @@
 #define A_FXSENDAMOUNT_F_MASK	0x00FF0000
 #define A_FXSENDAMOUNT_G_MASK	0x0000FF00
 #define A_FXSENDAMOUNT_H_MASK	0x000000FF
-
+/* 0x7c, 0x7e "high bit is used for filtering" */
+ 
 /* The send amounts for this one are the same as used with the emu10k1 */
 #define A_FXRT1			0x7e
 #define A_FXRT_CHANNELA		0x0000003f
@@ -783,6 +870,7 @@
 typedef struct _snd_emu10k1_pcm emu10k1_pcm_t;
 
 typedef enum {
+	EMU10K1_EFX,
 	EMU10K1_PCM,
 	EMU10K1_SYNTH,
 	EMU10K1_MIDI
@@ -793,6 +881,7 @@
 	int number;
 	int use: 1,
 	    pcm: 1,
+	    efx: 1,
 	    synth: 1,
 	    midi: 1;
 	void (*interrupt)(emu10k1_t *emu, emu10k1_voice_t *pvoice);
@@ -802,6 +891,7 @@
 
 typedef enum {
 	PLAYBACK_EMUVOICE,
+	PLAYBACK_EFX,
 	CAPTURE_AC97ADC,
 	CAPTURE_AC97MIC,
 	CAPTURE_EFX
@@ -811,7 +901,7 @@
 	emu10k1_t *emu;
 	snd_emu10k1_pcm_type_t type;
 	snd_pcm_substream_t *substream;
-	emu10k1_voice_t *voices[2];
+	emu10k1_voice_t *voices[NUM_EFX_PLAYBACK];
 	emu10k1_voice_t *extra;
 	unsigned short running;
 	unsigned short first_ptr;
@@ -985,23 +1075,27 @@
 	spinlock_t voice_lock;
 	struct semaphore ptb_lock;
 
-	emu10k1_voice_t voices[64];
+	emu10k1_voice_t voices[NUM_G];
 	emu10k1_pcm_mixer_t pcm_mixer[32];
+	emu10k1_pcm_mixer_t efx_pcm_mixer[NUM_EFX_PLAYBACK];
 	snd_kcontrol_t *ctl_send_routing;
 	snd_kcontrol_t *ctl_send_volume;
 	snd_kcontrol_t *ctl_attn;
+	snd_kcontrol_t *ctl_efx_send_routing;
+	snd_kcontrol_t *ctl_efx_send_volume;
+	snd_kcontrol_t *ctl_efx_attn;
 
 	void (*hwvol_interrupt)(emu10k1_t *emu, unsigned int status);
 	void (*capture_interrupt)(emu10k1_t *emu, unsigned int status);
 	void (*capture_mic_interrupt)(emu10k1_t *emu, unsigned int status);
 	void (*capture_efx_interrupt)(emu10k1_t *emu, unsigned int status);
-	void (*timer_interrupt)(emu10k1_t *emu);
 	void (*spdif_interrupt)(emu10k1_t *emu, unsigned int status);
 	void (*dsp_interrupt)(emu10k1_t *emu);
 
 	snd_pcm_substream_t *pcm_capture_substream;
 	snd_pcm_substream_t *pcm_capture_mic_substream;
 	snd_pcm_substream_t *pcm_capture_efx_substream;
+	snd_pcm_substream_t *pcm_playback_efx_substream;
 
 	snd_timer_t *timer;
 
@@ -1009,6 +1103,7 @@
 	emu10k1_midi_t midi2; /* for audigy */
 
 	unsigned int efx_voices_mask[2];
+	unsigned int next_free_voice;
 };
 
 int snd_emu10k1_create(snd_card_t * card,
@@ -1022,6 +1117,7 @@
 int snd_emu10k1_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_pcm_mic(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_pcm_efx(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
+int snd_emu10k1_pcm_multi(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_fx8010_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_mixer(emu10k1_t * emu);
 int snd_emu10k1_timer(emu10k1_t * emu, int device);
@@ -1044,6 +1140,9 @@
 void snd_emu10k1_voice_intr_enable(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_voice_intr_disable(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_voice_intr_ack(emu10k1_t *emu, unsigned int voicenum);
+void snd_emu10k1_voice_half_loop_intr_enable(emu10k1_t *emu, unsigned int voicenum);
+void snd_emu10k1_voice_half_loop_intr_disable(emu10k1_t *emu, unsigned int voicenum);
+void snd_emu10k1_voice_half_loop_intr_ack(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_voice_set_loop_stop(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_voice_clear_loop_stop(emu10k1_t *emu, unsigned int voicenum);
 void snd_emu10k1_wait(emu10k1_t *emu, unsigned int wait);

--=-F4YX550+t9LW2rhnOE2E--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: au88x0 modem
Date: Tue, 13 Sep 2005 21:40:55 +0300
Message-ID: <20050913184055.GE31269@sashak.softier1.local>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <431D554E.8050500@netvigator.com>
 <20050906142917.GA30523@sashak.softier1.local>
 <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de>
 <4321B5A4.5090803@netvigator.com> <20050911124530.GA16795@titan.lahn.de>
 <4325AEA3.1090602@netvigator.com> <20050913000909.GB19713@tecr>
 <43269818.4010603@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43269818.4010603@netvigator.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net, pmhahn@titan.lahn.de, openvortex-dev@nongnu.org, Manuel Jander <manuel.jander@gmail.com>, pontus.fuchs@tactel.se
List-Id: alsa-devel@alsa-project.org

On 17:12 Tue 13 Sep     , Raymond wrote:
> >On 00:36 Tue 13 Sep     , Raymond wrote:
> >
> >>>>cat /proc/asound/au8810/codec97#0/ac97#0-0+regs
> >>>
> >>>0:7c = 8384
> >>>0:7e = 7605
> >
> >
> >>Is it STAC9705 ?
> >>
> >>18-bit full-duplex audio codec with intergrated modem analog front end.
> >>
> >>http://www6.tomshardware.com/mobile/20010126/notebooks-06.html
> >>
> >>What is the usage of MOT6269353 if it already connected to STAC9705 ?
> >
> >
> >It is likely secondary modem-only codec (Motorola/SiLabs).
> >
> >Philipp,
> 
> MOT6269353 and MOT6269352 is an AC-Link SM56 Building block.
> 
> http://www.motorola.com/softmodem/driver.htm
> 
> Is it normal to have a primary audio/modem codec STAC9705 and a 
> secondary codec (AC-link SM56) ?

This codec (don't know STAC9705, STAC9704 or whatever) is audio only
codec, all modem related registers are zeroed. So yes, it is normal.

> I guess DAA Si3014 is similar to MOT6269352

Just same I guess.

> 
> >
> >Could you try the patch below? And then look again at '/proc/asond/au8810'?
> >
> >This is against CVS, untested and may be dangerous because I know nothing
> >about au8810 (somebody knows, please comment).
> >
> >Sasha.
> >
> 
> At a first glance, it's rather DANGER to try your patch.
> 
> The LAN card and MDC share the RJ11 jack on l8400b
> 
> Does it need to disable the LAN in BIOS before you make any test on the
> MDC ?

No.

> 
> Please cc your reply to openvortex-dev@nongnu.org
> 
> >Index: alsa-kernel/pci/au88x0/au8830.h
> >===================================================================
> >RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8830.h,v
> >retrieving revision 1.3
> >diff -u -p -r1.3 au8830.h
> >--- alsa-kernel/pci/au88x0/au8830.h	13 Apr 2004 15:26:27 -0000	1.3
> >+++ alsa-kernel/pci/au88x0/au8830.h	12 Sep 2005 23:35:27 -0000
> >@@ -203,12 +203,12 @@
> > #define VORTEX_CODEC_SPORTCTRL 0x2918c
> >
> > #define VORTEX_CODEC_EN 0x29190
> >-#define		EN_AUDIO0		0x00000300
> >+#define		EN_CODEC0		0x00000300
> > #define		EN_MODEM		0x00000c00
> >-#define		EN_AUDIO1		0x00003000
> >+#define		EN_CODEC1		0x00003000
> > #define		EN_SPORT		0x00030000
> > #define		EN_SPDIF		0x000c0000
> >-#define		EN_CODEC		(EN_AUDIO1 | EN_AUDIO0)
> >+#define		EN_CODEC	 (EN_CODEC0|EN_MODEM|EN_CODEC1)
> >
> > #define VORTEX_SPDIF_SMPRATE	0x29194
> 
> AFAIK, EN_AUDIO0 is for the front channels and EN_AUDIO1 is the rear
> channels of the AC97 link
> 
> #define		EN_AUDIO0		0x00000300
> #define		EN_AUDIO1		0x00003000

Yes, this CODEC_STRL/CODEC_EN stuff is very unclear for me, so I
used "full set" (CODEC0|CODEC1|MODEM) for begging. Should be clarified
in experimental way.


mainly I'm not about cleanups now. The goal is to hack modem. It looks
for me that right sequence is:

1. Find and initialize modem codec (secondary).
2. Find and hack appropriate DMA channels, initialize modem PCM.
3. Find valid way to access GPIO (for DAA controls like Hook-Off)
4. Chipset detailed cleanups.

Currently we are in (1).

Sasha.



> 
> 
> Photo of Aureal sound cards can be found in
> 
> http://www.dearhoney.idv.tw/MUSEUM/soundcard-07.php
> 
> Turtle Beach Montego II (STAC9721) is supported but the rear speakers of
> Quadzilla and the rear speakers and SPDIF IN/OUT of Home Studio Daugther
> card are not yet supported.
> 
> 
> JP1 of SQ2500 is connect to the WaveBlaster daugther card.
> 
> http://www.dayc.vispa.com/faq/vtximg.htm
> 
> JP2 and JP3 of SQ2500 are connected to SQ3500 daugther card with
> Motorola DSP56362.
> 
> The usage of the 20-pins connectors at the top of SuperQuad is unknown.
> 
> 
> >Index: alsa-kernel/pci/au88x0/au8820.h
> >===================================================================
> >RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8820.h,v
> >retrieving revision 1.3
> >diff -u -p -r1.3 au8820.h
> >--- alsa-kernel/pci/au88x0/au8820.h	13 Apr 2004 15:26:27 -0000	1.3
> >+++ alsa-kernel/pci/au88x0/au8820.h	12 Sep 2005 23:35:26 -0000
> >@@ -158,7 +158,10 @@
> > /* CODEC */
> > #define VORTEX_CODEC_CTRL 0x11984
> > #define VORTEX_CODEC_EN 0x11990
> >-#define		EN_CODEC	0x00000300
> >+#define		EN_CODEC0	0x00000300
> >+#define		EN_MODEM	0x00000c00
> >+#define		EN_CODEC1	0x00003000
> >+#define		EN_CODEC	(EN_CODEC0|EN_MODEM|EN_CODEC1)
> > #define		EN_SPORT	0x00030000
> > #define		EN_SPDIF	0x000c0000
> > #define VORTEX_CODEC_CHN 0x11880
> 
> 
> -#define		EN_CODEC	0x00000300
> +#define		EN_AUDIO0	0x00000300
> 
> 
> It seem all Vortex cards (e.g. Turtle Beach Montego, Diamond S90,... )
> have only one stereo codec and do not support soft modem.
> 
> 
> >
> >Index: alsa-kernel/pci/au88x0/au8810.h
> >===================================================================
> >RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au8810.h,v
> >retrieving revision 1.3
> >diff -u -p -r1.3 au8810.h
> >--- alsa-kernel/pci/au88x0/au8810.h	13 Apr 2004 15:26:27 -0000	1.3
> >+++ alsa-kernel/pci/au88x0/au8810.h	12 Sep 2005 23:35:26 -0000
> >@@ -171,9 +171,9 @@
> > #define VORTEX_CODEC_CTRL	0x29184
> > #define VORTEX_CODEC_EN		0x29190
> > #define		EN_CODEC0	0x00000300
> >-#define 	EN_AC98		0x00000c00 /* Modem AC98 slots. */
> >+#define 	EN_MODEM	0x00000c00 /* Modem AC98 slots. */
> > #define		EN_CODEC1	0x00003000
> >-#define		EN_CODEC	(EN_CODEC0 | EN_CODEC1)
> >+#define		EN_CODEC	(EN_CODEC0 | EN_MODEM | EN_CODEC1)
> > #define		EN_SPORT	0x00030000
> > #define		EN_SPDIF	0x000c0000
> >
> 
> +#define  VORTEX_PCI_SUBSYSTEM_ID   0x2A804
> 
> 
> -#define		EN_CODEC0	0x00000300
> +#define                EN_AUDIO0       0x00000300
> -#define 	EN_AC98		0x00000c00 /* Modem AC98 slots. */
> +#define 	EN_MODEM	0x00000c00 /* Modem AC98 slots. */
> -#define		EN_CODEC1	0x00003000
> +#define                EN_AUDIO1       0x00003000
> 
> 
> SQ1500, Aureal Advantage and most of the au8810 sound cards do not
> has any seconday modem codec.
> 
> SoundCom PCI Audio/Modem Combo card and some motherboard with
> onboard au8810 (e.g. ASUS l8400b, MS-6178E) have aureal soft modem
> 
> 
> 
> 
> http://pci-ids.ucw.cz/iii/?i=12eb8803
> 
> I suspect Aureal VCOM PCI Modem Card has different PCI vendor/device id
> 12eb:8803
> 
> 
> I suspect SQ1500 is the only au8810 has a quad codec (need confirmation
> from SQ1500 user).
> 
> > 
> >Index: alsa-kernel/pci/au88x0/au88x0.h
> >===================================================================
> >RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0.h,v
> >retrieving revision 1.11
> >diff -u -p -r1.11 au88x0.h
> >--- alsa-kernel/pci/au88x0/au88x0.h	22 Mar 2005 08:50:55 -0000	1.11
> >+++ alsa-kernel/pci/au88x0/au88x0.h	12 Sep 2005 23:35:27 -0000
> >@@ -135,7 +135,8 @@ struct snd_vortex {
> > 	snd_pcm_t *pcm[VORTEX_PCM_LAST];
> > 
> > 	snd_rawmidi_t *rmidi;	/* Legacy Midi interface. */
> >-	ac97_t *codec;
> >+	unsigned int num_of_codecs;
> >+	ac97_t *codecs[2];
> > 
> > 	/* Stream structs. */
> > 	stream_t dma_adb[NR_ADB];
> >Index: alsa-kernel/pci/au88x0/au88x0_core.c
> >===================================================================
> >RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_core.c,v
> >retrieving revision 1.11
> >diff -u -p -r1.11 au88x0_core.c
> >--- alsa-kernel/pci/au88x0/au88x0_core.c	23 Feb 2005 11:00:31 -0000 
> >1.11
> >+++ alsa-kernel/pci/au88x0/au88x0_core.c	12 Sep 2005 23:35:33 -0000
> >@@ -2511,6 +2511,11 @@ static void vortex_codec_init(vortex_t *
> > 	/* Enable codec channels 0 and 1. */
> > 	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
> > 		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC);
> >+	vortex->num_of_codecs = 1;
> >+	/* nothing know about that */
> >+	msleep(2);
> >+	if (hwread(vortex->mmio, VORTEX_CODEC_EN)&(EN_CODEC1|EN_MODEM))
> >+		vortex->num_of_codecs = 2;
> > }
> > 
> > static void
> 
> au88x0.h
> 
> 	ac97_t *codec;
> +#ifdef AU8810_CHIP
> +	ac97_t *modem_codec;
> +#endif
> +       u32 pci_subsystem_id;
> 
> 
> au88x0_core.c
> 
>   	/* Enable codec channels 0 and 1. */
>   	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
> -  		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC);
> +  		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_AUDIO0);
> 
> 
> au88x0_mixer.c
> 
> -	vortex->isquad = ((vortex->codec == NULL) ?  0 :
> (vortex->codec->ext_id&0x80));
> +	vortex->isquad = ((vortex->codec == NULL) ?  0 :
> (vortex->codec->ext_id & AC97_EI_SDAC));
> +        if  ( VORTEX_IS_QUAD(vortex) ) {
> +  		/* Enable codec rear channels . */
> +	  	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
> + 		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_AUDIO1 );
> +
> +	 };
> +#ifdef AU8810_CHIP
> +        /* Enable modem codec for ASUS L8400B
> +	switch ( vortex->pci_subsystem_id ) {
> +	case 0x10431043:
> +	  	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
> + 			hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_MODEM); 
> +               break;
> +	};
> +#endif
> +
> 
> 
> 
> >Index: alsa-kernel/pci/au88x0/au88x0_mixer.c
> >===================================================================
> >RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_mixer.c,v
> >retrieving revision 1.5
> >diff -u -p -r1.5 au88x0_mixer.c
> >--- alsa-kernel/pci/au88x0/au88x0_mixer.c	23 Mar 2005 17:04:16 -0000 
> >1.5
> >+++ alsa-kernel/pci/au88x0/au88x0_mixer.c	12 Sep 2005 23:35:33 -0000
> >@@ -15,7 +15,7 @@ static int __devinit snd_vortex_mixer(vo
> > {
> > 	ac97_bus_t *pbus;
> > 	ac97_template_t ac97;
> >-	int err;
> >+	int i, err;
> > 	static ac97_bus_ops_t ops = {
> > 		.write = vortex_codec_write,
> > 		.read = vortex_codec_read,
> >@@ -27,7 +27,10 @@ static int __devinit snd_vortex_mixer(vo
> > 	// Intialize AC97 codec stuff.
> > 	ac97.private_data = vortex;
> > 	ac97.scaps = AC97_SCAP_NO_SPDIF;
> >-	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
> >-	vortex->isquad = ((vortex->codec == NULL) ?  0 : 
> >(vortex->codec->ext_id&0x80));
> >+	for (i = 0 ; i < vortex->num_of_codecs ; i++) {
> >+		ac97.num = i;
> >+		err = snd_ac97_mixer(pbus, &ac97, &vortex->codecs[i]);
> >+	}
> >+	vortex->isquad = ((vortex->codecs[0] == NULL) ?  0 : 
> >(vortex->codecs[0]->ext_id&0x80));
> > 	return err;
> > }
> >
> >
> 
> 
> au88x0.c
> +        chip->pci_subsystem_id = pci_read_config_byte(pci,0x2c);
> 
> 	// snd_ac97_mixer and Vortex mixer.
> 	if ((err = snd_vortex_mixer(chip)) < 0) {
> 		snd_card_free(card);
> 		return err;
> 	}
> +#ifdef AU8810_CHIP
> +        /* ASUS l8400b , MS-6178E,  SoundCom  */
> +	switch ( chip->pci_subsystem_id ) {
> +	case 0x10431043:
> +             err = snd_vortex_modem_mixer(chip);	  	
> +             break;
> +	};
> +#endif
> 
> 
> 
> /* for VCOM PCI Modem card */
> 
> au8810_modem.c
> 
> #define PCI_DEVICE_ID_AUREAL_MODEM          0x8803
> #include "au8810.h"
> #include "au88x0.h"
> static struct pci_device_id snd_vortex_ids[] = {
> 	{PCI_VENDOR_ID_AUREAL, PCI_DEVICE_ID_AUREAL_MODEM,
> 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1,},
> 	{0,}
> };
> #include "au88x0_modem.c"
> #include "au88x0_core.c"
> #include "au88x0_pcm.c"
> #include "au88x0.c"
> 
> 
> 
> au88x0_modem.c
> 
> /* modem routine for audio/modem combo or modem card */
> 
> 
> static int __devinit snd_vortex_modem_mixer(vortex_t *vortex)
> {
>   	ac97_bus_t *pbus;
>   	ac97_template_t ac97;
> 	int err;
>   	static ac97_bus_ops_t ops = {
>   		.write = vortex_modem_codec_write,
>   		.read = vortex_modem_codec_read,
> 	};
> 	if ((err = snd_ac97_bus(vortex->card, 0, &ops, NULL, &pbus)) < 0)
> 		return err;
> 	memset(&ac97, 0, sizeof(ac97));
> 	// Intialize AC97 codec stuff.
>   	ac97.private_data = vortex;
>   	ac97.scaps = AC97_SCAP_NO_SPDIF;	
> 	if ( vortex->device == PCI_DEVICE_ID_AUREAL_MODEM )
> 		ac97.num = 0 ;
> 	else
> 		ac97.num = 1 ;
> 	err = snd_ac97_mixer(pbus, &ac97, &vortex->modem_codec);
>   	return err;
> 
> }
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

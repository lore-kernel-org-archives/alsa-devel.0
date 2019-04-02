From: Kailang <kailang@realtek.com>
Subject: RE: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with ALC233
Date: Tue, 2 Apr 2019 06:45:32 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBAFCA@RTITMBSVM07.realtek.com.tw>
References: <20190401032503.2821-1-jian-hong@endlessm.com>
        <s5hmul9lkke.wl-tiwai@suse.de>
        <6FAB7C47BCF00940BB0999A99BE3547A18DBAFAD@RTITMBSVM07.realtek.com.tw>
 <s5h7ecclxft.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7ecclxft.wl-tiwai@suse.de>
Content-Language: zh-TW
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Drake <drake@endlessm.com>, "linux@endlessm.com" <linux@endlessm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


Reviewed-by: Kailang Yang <kailang@realtek.com>

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Tuesday, April 2, 2019 2:43 PM
To: Kailang <kailang@realtek.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>; alsa-devel@alsa-project.org; Daniel Drake <drake@endlessm.com>; linux@endlessm.com; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with ALC233

On Tue, 02 Apr 2019 08:38:32 +0200,
Kailang wrote:
> 
> Hi Takashi,
> 
> This COEF value was modified by me.

OK, then could you give your Acked-by or Reviewed-by tag?


thanks,

Takashi

> 
> BR,
> Kailang
> 
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, April 2, 2019 1:09 AM
> To: Jian-Hong Pan <jian-hong@endlessm.com>
> Cc: alsa-devel@alsa-project.org; Daniel Drake <drake@endlessm.com>; 
> linux@endlessm.com; Kailang <kailang@realtek.com>; 
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer 
> TravelMate B114-21 with ALC233
> 
> On Mon, 01 Apr 2019 05:25:05 +0200,
> Jian-Hong Pan wrote:
> > 
> > The Acer TravelMate B114-21 laptop cannot detect and record sound 
> > from headset MIC.  This patch adds the ALC233_FIXUP_ACER_HEADSET_MIC 
> > HDA verb quirk chained with ALC233_FIXUP_ASUS_MIC_NO_PRESENCE pin 
> > quirk to fix this issue.
> > 
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > Signed-off-by: Daniel Drake <drake@endlessm.com>
> > ---
> >  sound/pci/hda/patch_realtek.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c 
> > b/sound/pci/hda/patch_realtek.c index a3fb3d4c5730..bdb2227be4eb
> > 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -5690,6 +5690,7 @@ enum {
> >  	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
> >  	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
> >  	ALC299_FIXUP_PREDATOR_SPK,
> > +	ALC233_FIXUP_ACER_HEADSET_MIC,
> >  };
> >  
> >  static const struct hda_fixup alc269_fixups[] = { @@ -6713,6 
> > +6714,15 @@ static const struct hda_fixup alc269_fixups[] = {
> >  			{ 0x21, 0x90170150 }, /* use as headset mic, without its own jack detect */
> >  			{ }
> >  		}
> > +	[ALC233_FIXUP_ACER_HEADSET_MIC] = {
> > +		.type = HDA_FIXUP_VERBS,
> > +		.v.verbs = (const struct hda_verb[]) {
> > +			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
> > +			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
> > +			{ }
> 
> For the additional COEF application, I'd like to hear ack from Kailang.  It's still a black magic from Realtek, so need some confirmation.
> 
> 
> thanks,
> 
> Takashi
> 
> > +		},
> > +		.chained = true,
> > +		.chain_id = ALC233_FIXUP_ASUS_MIC_NO_PRESENCE
> >  	},
> >  };
> >  
> > @@ -6737,6 +6747,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >  	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", 
> > ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> > +	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", 
> > +ALC233_FIXUP_ACER_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
> >  	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", 
> > ALC275_FIXUP_DELL_XPS),
> > --
> > 2.20.1
> > 
> > 
> 
> ------Please consider the environment before printing this e-mail.
> 

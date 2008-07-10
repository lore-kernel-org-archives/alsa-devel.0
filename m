From: Marek Lotke <lollul@wp.pl>
Subject: Re:
 =?iso-8859-1?q?hda-codec_conexant_-_no_external_mic_?=
 =?iso-8859-1?q?on_FSC_V5505_=28with_patch=29?=
Date: Thu, 10 Jul 2008 21:56:49 +0200
Message-ID: <200807102156.49466.lollul@wp.pl>
References: <200807091822.40851.lollul@wp.pl> <s5hmykpk0xt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id BA1941037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 21:56:57 +0200 (CEST)
Received: from 171.214-247-81.adsl-dyn.isp.belgacom.be (HELO r2d2.localnet)
	(lollul@[81.247.214.171]) (envelope-sender <lollul@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
	for <alsa-devel@alsa-project.org>; 10 Jul 2008 21:56:45 +0200
In-Reply-To: <s5hmykpk0xt.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 10 July 2008, Takashi Iwai wrote:
> At Wed, 9 Jul 2008 18:22:40 +0200,
>
> Marek Lotke wrote:
> > Hi,
> > I've tried all conextant models for my new laptop... External mic would
> > work only with benq but then the external headphones don't work.
> >
> > I managed to get the external mic working with this little patch:
> > --- a/sound/pci/hda/patch_conexant.c
> > +++ b/sound/pci/hda/patch_conexant.c
> > @@ -686,7 +686,7 @@ static struct snd_kcontrol_new cxt5045_mixers_hp530[]
> > = {
> >
> >  static struct hda_verb cxt5045_init_verbs[] = {
> >         /* Line in, Mic */
> > -       {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
> > +       {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80
> > }, {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 }, /*
> > HP, Amp  */
> >         {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> >
> > Now I can switch between the mics with mixer. Still no mic auto sensing
> > though but maybe there is none in hardware.
> > Attached are the outputs of alsa-info.sh: default, with model benq and
> > with default model with my patch with mixer set to external.
> >
> > I'll be glad to provide any info or try any patch...
>
> How about the patch below?  Your device is already listed in the
> config, so basically it has to work without specifying the model
> option.
>
>
> Takashi
>

Works nicely! Thanks!

Marek
> ---
> diff --git a/sound/pci/hda/patch_conexant.c
> b/sound/pci/hda/patch_conexant.c index 95e3367..7c1eb23 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -686,7 +686,7 @@ static struct snd_kcontrol_new cxt5045_mixers_hp530[] =
> {
>
>  static struct hda_verb cxt5045_init_verbs[] = {
>  	/* Line in, Mic */
> -	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
> +	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
>  	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
>  	/* HP, Amp  */
>  	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> @@ -910,7 +910,8 @@ static struct snd_pci_quirk cxt5045_cfg_tbl[] = {
>  	SND_PCI_QUIRK(0x152d, 0x0753, "Benq R55E", CXT5045_BENQ),
>  	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_LAPTOP_MICSENSE),
>  	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515",
> CXT5045_LAPTOP_HPMICSENSE), -	SND_PCI_QUIRK(0x1734, 0x110e, "Fujitsu
> V5505", CXT5045_LAPTOP_HPSENSE), +	SND_PCI_QUIRK(0x1734, 0x110e, "Fujitsu
> V5505",
> +		      CXT5045_LAPTOP_HPMICSENSE),
>  	SND_PCI_QUIRK(0x1509, 0x1e40, "FIC", CXT5045_LAPTOP_HPMICSENSE),
>  	SND_PCI_QUIRK(0x1509, 0x2f05, "FIC", CXT5045_LAPTOP_HPMICSENSE),
>  	SND_PCI_QUIRK(0x1509, 0x2f06, "FIC", CXT5045_LAPTOP_HPMICSENSE),
> @@ -962,6 +963,7 @@ static int patch_cxt5045(struct hda_codec *codec)
>  		codec->patch_ops.init = cxt5045_init;
>  		break;
>  	case CXT5045_LAPTOP_MICSENSE:
> +		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
>  		spec->input_mux = &cxt5045_capture_source;
>  		spec->num_init_verbs = 2;
>  		spec->init_verbs[1] = cxt5045_mic_sense_init_verbs;
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

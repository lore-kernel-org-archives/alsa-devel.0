From: =?ISO-8859-1?Q?Andr=E9e_=27Glaucous=27?= <glakke1@gmail.com>
Subject: Re: HDMI LPCM (7.1) with AMD/FGLRX
Date: Mon, 8 Aug 2011 19:15:35 +0200
Message-ID: <CAD=fge+v1C9mNU8Bq06HTsY-qmXB76UZkXP3kPyvefrzXEQp8g@mail.gmail.com>
References: <CAD=fgeJpR6xJbHxmp3EfWa1SOn_dx6ibQ4ffBTdf492UYrR06w@mail.gmail.com>
	<s5haabk9xud.wl%tiwai@suse.de>
	<CAD=fgeLDRisd8V88NL7L8Vfty95kCqaWUDM6onxSPNbd2udwRw@mail.gmail.com>
	<s5hk4aogrhu.wl%tiwai@suse.de>
	<CAD=fgeJrbWs9faGKf_wah7qOLV3juDHSDNtTnhy3XQ2u2WzM4w@mail.gmail.com>
	<s5hmxfkf505.wl%tiwai@suse.de>
	<CAD=fge+x+wPPROTsnOSkwUM+PXKLajYxLczZFhmRqksd25oKJA@mail.gmail.com>
	<s5h39hceyqw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D87AD24590
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 19:15:36 +0200 (CEST)
Received: by vxh2 with SMTP id 2so3383354vxh.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2011 10:15:35 -0700 (PDT)
In-Reply-To: <s5h39hceyqw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm not quite sure which version (of patch_hdmi.c) you are using, since the
patch fails on kernel 3.0-stable.

--
patching file sound/pci/hda/patch_hdmi.c
Hunk #1 FAILED at 923.
Hunk #2 FAILED at 996.
2 out of 2 hunks FAILED -- saving rejects to file
sound/pci/hda/patch_hdmi.c.rej


On 8 August 2011 16:58, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 8 Aug 2011 16:43:31 +0200,
> Andr=E9e 'Glaucous' wrote:
> >
> > Thanks.
> >
> > # hda-verb /dev/snd/hwC2D0 0x03 GET_PIN_SENSE 0
> > nid =3D 0x3, verb =3D 0xf09, param =3D 0x0
> > value =3D 0xffffffff
>
> This looks pretty invalid.
>
> > With monitor connected and outputting.
>
> So, either codec or the a driver is too lazy to give the info.
>
> Also, looking at your codec proc file, the codec doesn't give the
> right channel count, too.
>
> What happens with the patch below?
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 19cb72d..4da81b3 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -923,6 +923,7 @@ static void hdmi_present_sense(struct hda_codec *code=
c,
> hda_nid_t pin_nid,
>
>        memset(eld, 0, sizeof(*eld));
>
> +       printk(KERN_INFO "XXX HDMI pin_sense =3D 0x%x\n", present);
>        eld->monitor_present    =3D !!(present & AC_PINSENSE_PRESENCE);
>        if (eld->monitor_present)
>                eld->eld_valid  =3D !!(present & AC_PINSENSE_ELDV);
> @@ -996,6 +997,7 @@ static int hdmi_add_cvt(struct hda_codec *codec,
> hda_nid_t cvt_nid)
>
>        chans =3D get_wcaps(codec, cvt_nid);
>        chans =3D get_wcaps_channels(chans);
> +       chans =3D 8; /* XXX */
>
>        cvt_idx =3D spec->num_cvts;
>        per_cvt =3D &spec->cvts[cvt_idx];
>

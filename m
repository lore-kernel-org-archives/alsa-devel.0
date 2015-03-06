From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Fri, 6 Mar 2015 09:49:40 +0800
Message-ID: <CAN8cciZkEO+tTZ-DjyU7iB0tfX3JW2q7MpNd=yxy=QVKLVpC3w@mail.gmail.com>
References: <CAN8cciZ4=UXVLFgykv2V67e9+K5OwnYo3tq-cDUDJd2xgqszBw@mail.gmail.com>
 <54f889c7.33f7fe8f.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 7794A26599E
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 02:49:41 +0100 (CET)
Received: by obcuy5 with SMTP id uy5so10838999obc.11
 for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2015 17:49:40 -0800 (PST)
In-Reply-To: <54f889c7.33f7fe8f.bm001@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?SW5nbyBCcsO8Y2ts?= <ib@wupperonline.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

>
> > Try [...] to change node 0x15 Speaker as not connected
>
> This is exactly what I did now:
>
> diff -Nur a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> --- a/sound/pci/hda/patch_realtek.c     2015-02-27 02:49:36.000000000
+0100
> +++ b/sound/pci/hda/patch_realtek.c     2015-03-05 17:09:15.305016021
+0100
> @@ -5665,9 +5665,10 @@
>
>  static int alc662_parse_auto_config(struct hda_codec *codec)
>  {
> -       static const hda_nid_t alc662_ignore[] = { 0x1d, 0 };
> +       /* ignore internal speaker (0x15) in order to get a multi-io
config */
> +       static const hda_nid_t alc662_ignore[] = { 0x15, 0x1d, 0 };
>         static const hda_nid_t alc663_ssids[] = { 0x15, 0x1b, 0x14, 0x21
};
> -       static const hda_nid_t alc662_ssids[] = { 0x15, 0x1b, 0x14, 0 };
> +       static const hda_nid_t alc662_ssids[] = { 0x1b, 0x14, 0 };
>         const hda_nid_t *ssids;
>
>         if (codec->vendor_id == 0x10ec0272 || codec->vendor_id ==
0x10ec0663 ||
>
> It gives me the multi-io config without side effects and without the
> hp_lo_shared and spk_lo_shared issue in get_line_out_pfx().
>
> I'd like to make this configurable for people suffering from the same
problem
> with their ALC662, but I don't know how to identify when it would occur.
>

you need pin fixup by removing internal speaker and snd_pci_quirk of your
pci sbsystem id

In theory, user can get back the internal speaker by specify model=nofixup

+ [ALC662_FIXUP_NO_SPEAKER] = {
+ .type = ALC_FIXUP_PINS,
+ .v.pins = (const struct alc_pincfg[]) {
+ { 0x15, 0x4000000 }, /* remove internal speaker */
+ { }
+ }
+ },

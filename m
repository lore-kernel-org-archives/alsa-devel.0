From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: S/PDIF on AD1980 patch
Date: Fri, 14 Feb 2003 15:32:18 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045265537.3e4d7c8203055@webmail2.namezero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Here's the patch I promised. I had some trouble compiling the CVS version
(not the drivers but libs, still don't know why), but I supplemented with
libs compiled from the tarball (rc7) and it worked. Anyway - I created two
controls - a simple switch ( the "Link" ) and an enum ("Source") first
was simple yet fully functional and had the adventage of being modifiable
via alsamixer, which an enum isn't. The second control is more elegant
(based on a similar control for the YMF753), but needs much more code
and cannot be used in alsamixer (or I don't know how to do it). Works
fine via amixer controls though. Anyway, it doesn't make sense to add
both (although they do work simultanously), so I leave it up to alsa
vetrans maintaining the CVS tree to decide which solution is better.

According to Analog Devices specs this patch should work for all 1980
series chips, namely 41445370 (ad1980-that's the one I test for),
41445371 (ad1980A) and 41445374 (ad1980B). But since I can't test the
other ones - I left it at that.


Index: ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.63
diff -r1.63 ac97_codec.c
1022a1023,1071
> static const snd_kcontrol_new_t snd_ac97_ad1980_spdif_link =
>     AC97_SINGLE(SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Link",
AC97_AD_SERIAL_CFG, 2, 1, 0);
>
> static int snd_ac97_ad1980_spdif_source_info(snd_kcontrol_t *kcontrol,
snd_ctl_elem_info_t * uinfo)
> {
>       static char *texts[2] = { "AC-Link", "A/D Converter" };
>
>       uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
>       uinfo->count = 1;
>       uinfo->value.enumerated.items = 2;
>       if (uinfo->value.enumerated.item > 1)
>               uinfo->value.enumerated.item = 1;
>       strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
>       return 0;
> }
>
> static int snd_ac97_ad1980_spdif_source_get(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
> {
>       ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
>       unsigned short val;
>
>       val = ac97->regs[AC97_AD_SERIAL_CFG];
>       ucontrol->value.enumerated.item[0] = (val >> 2) & 1;
>       return 0;
> }
>
> static int snd_ac97_ad1980_spdif_source_put(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
> {
>       ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
>       unsigned short val;
>
>       if (ucontrol->value.enumerated.item[0] > 1)
>               return -EINVAL;
>       val = ucontrol->value.enumerated.item[0] << 2;
>       return snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG, 0x0004, val);
> }
>
> static const snd_kcontrol_new_t snd_ac97_ad1980_spdif_source =
>       {
>               iface: SNDRV_CTL_ELEM_IFACE_MIXER,
>               name: SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
>               info: snd_ac97_ad1980_spdif_source_info,
>               get: snd_ac97_ad1980_spdif_source_get,
>               put: snd_ac97_ad1980_spdif_source_put,
>       };
>
>
>
>
1675a1725,1730
>                                               return err;
>                       }
>                       if (ac97->id == AC97_ID_AD1980) {
>                                       if ((err = snd_ctl_add(card,
snd_ac97_cnew(&snd_ac97_ad1980_spdif_link, ac                         97))) < 0)
>                                               return err;
>                                       if ((err = snd_ctl_add(card,
snd_ac97_cnew(&snd_ac97_ad1980_spdif_source,                          ac97))) < 0)
Index: ac97_id.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_id.h,v
retrieving revision 1.6
diff -r1.6 ac97_id.h
33a34
> #define AC97_ID_AD1980                0x41445370


--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en

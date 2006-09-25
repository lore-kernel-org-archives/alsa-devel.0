From: "Marvin Stodolsky" <marvin.stodolsky@gmail.com>
Subject: Re: [PATCH] hda/patch_si3054: new codec vendor IDs
Date: Mon, 25 Sep 2006 07:29:25 -0400
Message-ID: <c27106ee0609250429u1a0d2513s2ce871691e451a32@mail.gmail.com>
References: <20060925080101.GA7996@sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060925080101.GA7996@sk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Several  tarballs of /proc/asound have been accumulated,
corresponding to the new softmodems on HDA card cases encountered
through the List discuss@linmodems.org.  When encountering  a novel
HDA modem Vendor ID,  my scanModem script does:
    cp -a /proc/asound  $VendorID
    tar cfz $VendorID.tgz  $VendorID/
   echo "  Please send $VendorID.tgz to marvin.stodolsky@gamil.com"
where Vendor ID  is novel such as in:

>  PCI ID     Subsystem  Name
>  ---------- ---------  -----------------
>  10de:026c  107b:0317  0403: nVidia Corporation MCP51 High Definition Audio
>
>     /proc/asound/card0/codec#1
> -------------------------------
> Codec: Generic 11c1 ID 1040
> Address: 1
> Vendor Id: 0x11c11040
> Subsystem Id: 0x11c10001
> Revision Id: 0x100200
> -------------------------------

Should it be usefull to any of you to have these cases, please left me know.
The internal archive within
http://linmodems.technion.ac.il/packages/scanModem.gz
currently has the HDA modem cases below.

MarvS
-----------
      cat<<END>/dev/null
In the Archive below, the first field is the modem chipset
manufacturer  ID for HDA cards
OR the mc97 codec for cards with a AC'97/MC97 compatible register,
orginally read from the 0:7c and 0:7e fields and then translated.
           Following is the SubSystem PCI IDs of cards with that codec,
which is grep filtered on. This field accepts comments diverse.
The HDA cards are first listed. In newer cases there are:   $SUBSYS_$VendorID
END

      if test "$PCIDEV" = 8086:2668 ; then
      HDA=1
# Class 0403: 8086:2668   Class 0403: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller
     cat<<END | grep $SUBSYS | cut -d' ' -f1 >$TMPM.2
14f1  1025:008f 1028:01c9 1028:01cb
11c1  1179:ff00 1025:0070
163c  1558:0900
END
      elif test "$PCIDEV" = 8086:27d8 ; then
      HDA=1
        # Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller
     cat<<END | grep $SUBSYS | cut -d' ' -f1 >$TMPM.2
14f1  1028:01cd_14f12bfa 1043:81d8  17aa:2010 1028:01bd 1025:0090
11c1  1179:ff00_11c13026 ; 103c:30aa
1057  1558:5405_10573055
END
      elif test "$PCIDEV" = 1002:437b ; then
        HDA=1
      # Audio device: ATI Technologies Inc SB450 HDA Audio (rev 01)
      cat<<END | grep $SUBSYS | cut -d' ' -f1 >$TMPM.2
11c1  1462:0369 , 10cf:1326
END
      elif test "$PCIDEV" = 10de:026c ; then
        HDA=1
      # nVidia Corporation MCP51 High Definition Audio
      cat<<END | grep $SUBSYS | cut -d' ' -f1 >$TMPM.2
14f1   103c:30b7
11c1   107b:0317_11c11040 ;
END




On 9/25/06, Sasha Khapyorsky <sashakh@gmail.com> wrote:
> Hi Takashi,
>
> There are new IDs for Si3054 based HDA modems.
>
> Sasha
>
> ---
> There are additional IDs for Si3054 codec based HDA modems. Most of
> them were discovered on discuss@linmodems.org list - Thanks to MarvS
> and all linmodems.org folks.
>
> Signed-off-by: Sasha Khapyorsky <sashak@alsa-project.org>
>
> ---
> diff -r 63e58b008259 pci/hda/patch_si3054.c
> --- a/pci/hda/patch_si3054.c    Mon Sep 04 13:03:51 2006 +0200
> +++ b/pci/hda/patch_si3054.c    Sun Sep 24 03:20:25 2006 +0300
> @@ -297,7 +297,12 @@ struct hda_codec_preset snd_hda_preset_s
>  struct hda_codec_preset snd_hda_preset_si3054[] = {
>         { .id = 0x163c3055, .name = "Si3054", .patch = patch_si3054 },
>         { .id = 0x163c3155, .name = "Si3054", .patch = patch_si3054 },
> +       { .id = 0x11c11040, .name = "Si3054", .patch = patch_si3054 },
>         { .id = 0x11c13026, .name = "Si3054", .patch = patch_si3054 },
> +       { .id = 0x11c13055, .name = "Si3054", .patch = patch_si3054 },
> +       { .id = 0x11c13155, .name = "Si3054", .patch = patch_si3054 },
> +       { .id = 0x10573055, .name = "Si3054", .patch = patch_si3054 },
> +       { .id = 0x10573155, .name = "Si3054", .patch = patch_si3054 },
>         {}
>  };
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

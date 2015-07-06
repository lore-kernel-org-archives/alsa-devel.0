From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - add codec ID for Broxton
	display audio codec
Date: Mon, 6 Jul 2015 08:40:40 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1968146D@SHSMSX103.ccr.corp.intel.com>
References: <1436150666-106766-1-git-send-email-libin.yang@intel.com>
 <s5hio9x8yw0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C94F260502
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 10:40:45 +0200 (CEST)
In-Reply-To: <s5hio9x8yw0.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, July 06, 2015 4:38 PM
> To: Yang, Libin
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH] ALSA: hda - add codec ID for Broxton display
> audio codec
> 
> At Mon,  6 Jul 2015 10:44:26 +0800,
> libin.yang@intel.com wrote:
> >
> > From: Libin Yang <libin.yang@intel.com>
> >
> > This patch adds codec ID (0x8086280a) and module alias for Broxton
> > display codec.
> >
> > Signed-off-by: Libin Yang <libin.yang@intel.com>
> 
> I applied this now, but don't you need the workaround for haswell+?

Yes, I believe we need the workaround. As we currently don't have
a platform to test, I do not make the workaround patch.

I will make the patch when I get a platform to test.

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/patch_hdmi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_hdmi.c
> b/sound/pci/hda/patch_hdmi.c
> > index 2f24338..9515891 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -3527,6 +3527,7 @@ static const struct hda_codec_preset
> snd_hda_preset_hdmi[] = {
> >  { .id = 0x80862807, .name = "Haswell HDMI",	.patch =
> patch_generic_hdmi },
> >  { .id = 0x80862808, .name = "Broadwell HDMI",	.patch =
> patch_generic_hdmi },
> >  { .id = 0x80862809, .name = "Skylake HDMI",	.patch =
> patch_generic_hdmi },
> > +{ .id = 0x8086280a, .name = "Broxton HDMI",	.patch =
> patch_generic_hdmi },
> >  { .id = 0x80862880, .name = "CedarTrail HDMI",	.patch =
> patch_generic_hdmi },
> >  { .id = 0x80862882, .name = "Valleyview2 HDMI",	.patch =
> patch_generic_hdmi },
> >  { .id = 0x80862883, .name = "Braswell HDMI",	.patch =
> patch_generic_hdmi },
> > @@ -3591,6 +3592,7 @@ MODULE_ALIAS("snd-hda-codec-
> id:80862806");
> >  MODULE_ALIAS("snd-hda-codec-id:80862807");
> >  MODULE_ALIAS("snd-hda-codec-id:80862808");
> >  MODULE_ALIAS("snd-hda-codec-id:80862809");
> > +MODULE_ALIAS("snd-hda-codec-id:8086280a");
> >  MODULE_ALIAS("snd-hda-codec-id:80862880");
> >  MODULE_ALIAS("snd-hda-codec-id:80862882");
> >  MODULE_ALIAS("snd-hda-codec-id:80862883");
> > --
> > 1.9.1
> >

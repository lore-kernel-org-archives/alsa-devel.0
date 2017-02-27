From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda: Add Geminilake HDMI codec ID
Date: Mon, 27 Feb 2017 21:45:55 +0530
Message-ID: <20170227161555.GG2843@localhost>
References: <1488210584-32458-1-git-send-email-vinod.koul@intel.com>
 <s5hd1e3397n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B8FCE266CCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 17:15:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd1e3397n.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 27, 2017 at 05:11:08PM +0100, Takashi Iwai wrote:
> On Mon, 27 Feb 2017 16:49:44 +0100,
> Vinod Koul wrote:
> > 
> > Geminilake HDMI codec 0x280d is similar to previous platforms, so add it with
> > similar ops as previous.
> > 
> > Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index 3fc201c3b95a..6254c3ba4473 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -3658,6 +3658,7 @@ static int patch_via_hdmi(struct hda_codec *codec)
> >  HDA_CODEC_ENTRY(0x80862808, "Broadwell HDMI",	patch_i915_hsw_hdmi),
> >  HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_i915_hsw_hdmi),
> >  HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
> > +HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_hsw_hdmi),
> >  HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
> >  HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
> >  HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
> 
> The list is sorted in the codec ID order, so I put it in the right
> place manually.

Ah okay, sorry missed that, I was assuming that we will be platform order
like PCI ones..

-- 
~Vinod

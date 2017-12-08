From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH] ALSA: hda - Add vendor id for Cannonlake
	HDMI codec
Date: Fri, 8 Dec 2017 09:06:34 +0530
Message-ID: <20171208033629.GA31207@subhransu-desktop>
References: <20171207123620.25640-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C304C266D7D
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 04:50:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171207123620.25640-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 07, 2017 at 06:06:20PM +0530, Guneshwor Singh wrote:
> Cannonlake HDMI codec has the same nid as Geminilake. This adds the
> codec entry for it.

CNL and GLK share the same vendor nid not the vendor id. 
You may update the subject and commit message.

Regards,
Subhransu

> 
> Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
> ---
>  sound/pci/hda/patch_hdmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index c19c81d230bd..b4f1b6e88305 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -55,10 +55,11 @@ MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
>  #define is_kabylake(codec) ((codec)->core.vendor_id == 0x8086280b)
>  #define is_geminilake(codec) (((codec)->core.vendor_id == 0x8086280d) || \
>  				((codec)->core.vendor_id == 0x80862800))
> +#define is_cannonlake(codec) ((codec)->core.vendor_id == 0x8086280c)
>  #define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
>  				|| is_skylake(codec) || is_broxton(codec) \
> -				|| is_kabylake(codec)) || is_geminilake(codec)
> -
> +				|| is_kabylake(codec)) || is_geminilake(codec) \
> +				|| is_cannonlake(codec)
>  #define is_valleyview(codec) ((codec)->core.vendor_id == 0x80862882)
>  #define is_cherryview(codec) ((codec)->core.vendor_id == 0x80862883)
>  #define is_valleyview_plus(codec) (is_valleyview(codec) || is_cherryview(codec))
> @@ -3841,6 +3842,7 @@ HDA_CODEC_ENTRY(0x80862808, "Broadwell HDMI",	patch_i915_hsw_hdmi),
>  HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_i915_hsw_hdmi),
>  HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
>  HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
> +HDA_CODEC_ENTRY(0x8086280c, "Cannonlake HDMI",	patch_i915_glk_hdmi),
>  HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_glk_hdmi),
>  HDA_CODEC_ENTRY(0x80862800, "Geminilake HDMI",	patch_i915_glk_hdmi),
>  HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
> -- 
> 2.15.1
> 

-- 

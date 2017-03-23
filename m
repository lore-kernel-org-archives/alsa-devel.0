From: "Kp, Jeeja" <jeeja.kp@intel.com>
Subject: Re: [PATCH] ALSA: hda - set intel audio clock to
	a	properly value
Date: Thu, 23 Mar 2017 13:11:01 +0000
Message-ID: <FE1218A4CE6FF04999892577E0FB3E8361EEB7F0@BGSMSX102.gar.corp.intel.com>
References: <1488867622-21765-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 05639266AE2
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 14:11:22 +0100 (CET)
In-Reply-To: <1488867622-21765-1-git-send-email-libin.yang@intel.com>
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
To: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "infernix@infernix.net" <infernix@infernix.net>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Yang, Libin
> Sent: Tuesday, March 7, 2017 11:50 AM
> To: alsa-devel@alsa-project.org; tiwai@suse.de
> Cc: Yang, Libin <libin.yang@intel.com>; Lin, Mengdong
> <mengdong.lin@intel.com>; infernix@infernix.net
> Subject: [alsa-devel] [PATCH] ALSA: hda - set intel audio clock to a properly
> value
> 
> From: Libin Yang <libin.yang@intel.com>
> 
> On some Intel platforms, the audio clock may not be set correctly with initial
> setting. This will cause the audio playback/capture rates wrong.
> 
> This patch checks the audio clock setting and will set it to a properly value if it
> is not set correct.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188411
> 
> Signed-off-by: Libin Yang <libin.yang@intel.com>
> ---
>  include/sound/hda_register.h        | 12 +++--
>  sound/hda/ext/hdac_ext_controller.c |  6 +--
>  sound/pci/hda/hda_intel.c           | 91
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 103 insertions(+), 6 deletions(-)
> 
> diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
> index 0013063..7ea16cb 100644
> --- a/include/sound/hda_register.h
> +++ b/include/sound/hda_register.h
> @@ -227,6 +227,8 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2,
> SDO3 };
>  #define AZX_REG_PPLCLLPU		0xC
> 
>  /* registers for Multiple Links Capability Structure */
> +/* Multiple Links Capability */
> +#define AZX_REG_ML_CAP_BASE		0xc00
Base is already available as part of bus, use bus->mlcap


> +#define AZX_REG_ML_LCAPx(x)	(AZX_REG_ML_CAP_BASE + (0x40 +
> 0x40 * x))
> +#define AZX_REG_ML_LCTLx(x)	(AZX_REG_ML_CAP_BASE + (0x44 +
> 0x40 * x))
This is specific to the had legacy driver as only link0 is used, I think this can be moved to driver
 As define. If it required to use all the link, then need to use ext functions to initialize the address
per link.

> +#define ML_LCTL_SCF_MASK			0xF
> +#define AZX_MLCTL_SPA				(0x1 << 16)
> +#define AZX_MLCTL_CPA				(0x1 << 23)
> +#define AZX_MLCTL_SPA_SHIFT			16
> +#define AZX_MLCTL_CPA_SHIFT			23
> 
> +
>  static void hda_intel_init_chip(struct azx *chip, bool full_reset)  {
>  	struct hdac_bus *bus = azx_bus(chip);
> @@ -564,6 +652,9 @@ static void hda_intel_init_chip(struct azx *chip, bool
> full_reset)
> +
> +	if (IS_SKL_PLUS(pci))
> +		intel_init_lctl(chip);
Use bus->mlcap to check for multilink capability  is present.

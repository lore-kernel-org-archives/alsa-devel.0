From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] ALSA: hda: add hdac_adsp_enable module
 flag
Date: Thu, 30 Apr 2015 11:02:19 -0500
Message-ID: <5542520B.8080606@linux.intel.com>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CAFEF265DC6
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 18:02:32 +0200 (CEST)
In-Reply-To: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On 4/30/15 9:52 AM, Vinod Koul wrote:
> Some Intel HDA controllers sport a DSP. These systems can also be enabled
> with ASoC HDA driver as well. So add a flag in hda-core to enable/disable
> aDSP This flag for now is false, and should be true once the ASoC based
> systems mature.  The integrators/OS vendors can configure this flag based on
> system preference.

This choice is contingent on the BIOS options, you can't enable the DSP 
if the BIOS said no DSP...

>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>   include/sound/hdaudio.h  | 11 +++++++++++
>   sound/hda/hda_bus_type.c |  4 ++++
>   2 files changed, 15 insertions(+)
>
> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> index b97c59eab7ab..015bec1079f9 100644
> --- a/include/sound/hdaudio.h
> +++ b/include/sound/hdaudio.h
> @@ -12,6 +12,17 @@
>   #include <sound/memalloc.h>
>   #include <sound/hda_verbs.h>
>
> +/*
> + * hdac_adsp_enable: exported HD-A aDSP enable configuration.
> + *
> + * Some Intel HDA controllers sport a DSP, for these platform we can bypass
> + * aDSP and use as regular HDA controller or enable aDSP and use aDSP
> + * along with I2S codecs etc.
> + * hdac_adsp_enable would enable the aDSP based HDA controller if the
> + * platform supports it
> + */
> +extern bool hdac_adsp_enable;
> +
>   /* codec node id */
>   typedef u16 hda_nid_t;
>
> diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
> index 519914a12e8a..80e0570ffbf4 100644
> --- a/sound/hda/hda_bus_type.c
> +++ b/sound/hda/hda_bus_type.c
> @@ -10,6 +10,10 @@
>   MODULE_DESCRIPTION("HD-audio bus");
>   MODULE_LICENSE("GPL");
>
> +bool hdac_adsp_enable = false;
> +module_param(hdac_adsp_enable, bool, 0444);
> +MODULE_PARM_DESC(hdac_adsp_enable, "Enable aDSP on Intel HDA based systems");
> +
>   static int hda_bus_match(struct device *dev, struct device_driver *drv)
>   {
>   	struct hdac_device *hdev = dev_to_hdac_dev(dev);
>

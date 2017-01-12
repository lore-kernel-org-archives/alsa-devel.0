From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: Intel: bxtn: Store the
 FW/Library context at boot
Date: Thu, 12 Jan 2017 08:11:21 +0000
Message-ID: <1484208681.2604.66.camel@loki>
References: <1484195084-24446-1-git-send-email-jeeja.kp@intel.com>
 <1484195084-24446-2-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ED82D266838
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 09:11:26 +0100 (CET)
In-Reply-To: <1484195084-24446-2-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-01-12 at 09:54 +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> Store the DSP firmware/library at boot, so that for S3 to S0 transition
> use the stored ctx for downloading the firmware to DSP memory.
> 
> Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> ---
>  sound/soc/intel/skylake/bxt-sst.c | 55 +++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
> index 15a063a..7762d5a 100644
> --- a/sound/soc/intel/skylake/bxt-sst.c
> +++ b/sound/soc/intel/skylake/bxt-sst.c
> @@ -50,33 +50,47 @@ static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
>  	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
>  }
>  
> +static void sst_bxt_release_library(struct skl_lib_info *linfo, int lib_count)
> +{
> +	int i;
> +
> +	for (i = 1; i < lib_count; i++) {

It probably makes sense to replace 1 with a macro here to indicate the
first non base FW ID number. This can be done in other places too to
make the  code more readable for library management.

Liam

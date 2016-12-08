From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: remove unused 'out_fmt' variable
Date: Thu, 8 Dec 2016 15:30:01 +0530
Message-ID: <20161208095959.GY6408@localhost>
References: <1481176902-131803-1-git-send-email-kirtika@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481176902-131803-1-git-send-email-kirtika@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirtika Ruchandani <kirtika@chromium.org>
Cc: tiwai@suse.com, arnd@arndb.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hardik T Shah <hardik.t.shah@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 07, 2016 at 10:01:42PM -0800, Kirtika Ruchandani wrote:
> Commit 4cd9899f0d16 introduced struct skl_module_fmt* out_fmt without
> using it. Compiling with W=1 gives the below warning, fix it.
> 
> sound/soc/intel/skylake/skl-topology.c: In function ‘skl_tplg_update_buffer_size’:
> sound/soc/intel/skylake/skl-topology.c:301:34: warning: variable ‘out_fmt’ set but not used [-Wunused-but-set-variable]
> 
> This is a harmless warning and is only being fixed to reduce the noise
> with W=1 in the kernel.

Heya,

Can you please tell me which tree this warning was found on? At least this
doesn't exist upstream. The out_fmt is very well used.

If you saw this in Chromium tree then it might be due to some missing
backports..

> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index bd313c9..4352236a 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -298,7 +298,7 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
> 				struct skl_module_cfg *mcfg)
>  {
> 	int multiplier = 1;
> -	struct skl_module_fmt *in_fmt, *out_fmt;
> +	struct skl_module_fmt *in_fmt;
> 	int in_rate, out_rate;
> 
> 
> @@ -306,7 +306,6 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
> 	 * change for pin 0 only
> 	 */
> 	in_fmt = &mcfg->in_fmt[0];
> -	out_fmt = &mcfg->out_fmt[0];
> 
> 	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
> 		multiplier = 5;
> --
> 2.8.0.rc3.226.g39d4020

-- 
~Vinod

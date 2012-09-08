From: Fengguang Wu <fengguang.wu@intel.com>
Subject: sound/soc/soc-dapm.c:1023:4: error: implicit
 declaration of function 'regulator_allow_bypass'
Date: Sat, 8 Sep 2012 09:51:06 +0800
Message-ID: <20120908015106.GA19743@localhost>
References: <20120908014450.GB19345@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 191322616E9
 for <alsa-devel@alsa-project.org>; Sat,  8 Sep 2012 03:51:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120908014450.GB19345@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

[add the missing subject line..]

On Sat, Sep 08, 2012 at 09:44:50AM +0800, Fengguang Wu wrote:
> Hi Mark,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> head:   e8bb382aa74747f23e2903c15e48e9f06de5c60a
> commit: 9ad4ba77112a3700129cdb142796a54680baa266 [100/103] ASoC: dapm: Allow regulators to bypass as well as disable when idle
> config: x86_64-allmodconfig (attached as .config)
> 
> All related error/warning messages:
> 
> sound/soc/soc-dapm.c: In function 'dapm_regulator_event':
> sound/soc/soc-dapm.c:1023:4: error: implicit declaration of function 'regulator_allow_bypass' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> 
> vim +1023 sound/soc/soc-dapm.c
>   1018	{
>   1019		int ret;
>   1020	
>   1021		if (SND_SOC_DAPM_EVENT_ON(event)) {
>   1022			if (w->invert & SND_SOC_DAPM_REGULATOR_BYPASS) {
> > 1023				ret = regulator_allow_bypass(w->regulator, true);
>   1024				if (ret != 0)
>   1025					dev_warn(w->dapm->dev,
>   1026						 "Failed to bypass %s: %d\n",
>   1027						 w->name, ret);
>   1028			}
> 
> ---
> 0-DAY kernel build testing backend         Open Source Technology Centre
> Fengguang Wu <wfg@linux.intel.com>                     Intel Corporation

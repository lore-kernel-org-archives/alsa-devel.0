From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/19] ASoC: mrst_machine: add speaker
 widget to moorestown machine driver
Date: Wed, 4 May 2011 17:17:34 +0100
Message-ID: <20110504161734.GE10912@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134514.32443.76742.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64716103939
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 18:18:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504134514.32443.76742.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 09:45:14PM +0800, Lu Guanqun wrote:

> @@ -72,6 +91,7 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
>  	snd_soc_dapm_nc_pin(dapm, "LINEOUTR");
>  
>  	snd_soc_dapm_enable_pin(dapm, "Headphone");
> +	snd_soc_dapm_disable_pin(dapm, "Speaker");
>  
>  	snd_soc_dapm_sync(dapm);

There's nothing in this patch that ever enables the speaker...

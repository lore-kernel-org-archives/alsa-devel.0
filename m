From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] add output/input widgets in ad1938 to make
 dac/adc dynamic PM work
Date: Wed, 12 Aug 2009 14:34:05 +0100
Message-ID: <20090812133404.GB11898@rakim.wolfsonmicro.main>
References: <1250048065-23433-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D8F42448B
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 15:34:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250048065-23433-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2009 at 11:34:25AM +0800, Barry Song wrote:
> According to the function dapm_dac_check_power() in
> sound/soc/soc-dapm.c, dac power can't be on/off stand-alone without any
> output widget as sink. And according to dapm_adc_check_power(), adc
> power can't be on/off stand-alone without any input widget as source. So
> we can't only define some stand-alone SND_SOC_DAPM_DAC/SND_SOC_DAPM_ADC
> to hope their power can be managed dynamically.

> Signed-off-by: Barry Song <21cnbao@gmail.com>

Applied, thanks.

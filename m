From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 2/4] ASoC: tlv320aic3x: Add runtime
 regulator control to aic3x_set_bias_level
Date: Mon, 20 Sep 2010 10:36:13 +0100
Message-ID: <20100920093612.GB3414@rakim.wolfsonmicro.main>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
	<1284968354-12536-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07A4F103834
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 11:36:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284968354-12536-3-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 20, 2010 at 10:39:12AM +0300, Jarkko Nikula wrote:
> Now all the regulators are disabled when entering into SND_SOC_BIAS_OFF
> and enabled when coming back to SND_SOC_BIAS_STANDBY state. Currently this
> runtime control happens only with suspend/resume as this patch does not
> change the default idle behavior.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

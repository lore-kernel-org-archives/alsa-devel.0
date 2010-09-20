From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 4/4] ASoC: tlv320aic3x: Let the codec hit
 SND_SOC_BIAS_OFF when idle
Date: Mon, 20 Sep 2010 11:39:15 +0100
Message-ID: <20100920103915.GF3414@rakim.wolfsonmicro.main>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
	<1284968354-12536-5-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC6C0103840
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 12:39:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284968354-12536-5-git-send-email-jhnikula@gmail.com>
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

On Mon, Sep 20, 2010 at 10:39:14AM +0300, Jarkko Nikula wrote:
> Now codec hits the SND_SOC_BIAS_OFF also when it is idle. This is also
> the default state after probing and codec is left unconfigured and
> unpowered by default. Initialization will happen when the bias state changes
> and aic3x_set_power does power-up and cache sync.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: ssm2602: Re-enable oscillator
	after suspend
Date: Tue, 27 Sep 2011 11:20:57 +0100
Message-ID: <20110927102056.GB2910@opensource.wolfsonmicro.com>
References: <1317114528-16736-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A46722443E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 12:20:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317114528-16736-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2011 at 11:08:46AM +0200, Lars-Peter Clausen wrote:
> Currently the the internal oscillator is powered down when entering BIAS_OFF
> state, but not re-enabled when going back to BIAS_STANDBY. As a result the
> CODEC will stop working after suspend if the internal oscillator is used to
> generate the sysclock signal. This patch fixes it by clearing the appropriate
> bit in the power down register when the CODEC is re-enabled.

Applied, thanks.

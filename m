From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: wm8731: rework power management
Date: Thu, 30 Jun 2011 08:22:07 -0700
Message-ID: <20110630152203.GB3249@opensource.wolfsonmicro.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
	<ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<20110629171148.GB10798@opensource.wolfsonmicro.com>
	<4E0C80B8.7030006@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 256D12457A
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 17:22:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E0C80B8.7030006@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 30, 2011 at 03:57:12PM +0200, Nicolas Ferre wrote:

Please fix your mailer to line wrap within paragraphs.

> First of all, I experienced issues while not having OSC enabled during
> suspend/resume cycle. Am I right supposing that, if using oscillator
> to clock the codec, I have to keep it running during a suspend/resume
> cycle?

No, not at all.  What makes you believe that you would you need to do
that?

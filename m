From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH,
	RFC 3/3] pxa/magician: add I2C board info	and platform data for
	UDA1380
Date: Mon, 15 Jun 2009 11:26:52 +0100
Message-ID: <20090615102652.GA13873@rakim.wolfsonmicro.main>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-5-git-send-email-philipp.zabel@gmail.com>
	<20090614150023.GC4482@sirena.org.uk>
	<f17812d70906141906p4e5a2e28j2f95dcd8f0455660@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A69C1037FD
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 12:26:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906141906p4e5a2e28j2f95dcd8f0455660@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 10:06:21AM +0800, Eric Miao wrote:

> Normally, I'll queue such patch in my pending branch and will be pushed
> out until the other patch(es) with dependency has been merged upstream.

That's fine for me.

Philipp, if you want to avoid bisection issues I'd suggest making the
first patch shuffle the registration code into the ASoC machine driver
then have your PXA patch shuffle that into arch/arm.  I did something
similar for wm8731 when converting that.

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] imx-ssi: Use a hrtimer in FIQ mode
Date: Thu, 8 Apr 2010 10:53:25 +0100
Message-ID: <20100408095324.GB6303@rakim.wolfsonmicro.main>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
	<1270719086-23453-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 216E810389B
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 11:53:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1270719086-23453-4-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 11:31:26AM +0200, Sascha Hauer wrote:

> -	/* Restart the timer; if we didn't report we'll run on the next tick */
> -	add_timer(&iprtd->timer);
> +	hrtimer_forward_now(hrt, ns_to_ktime(iprtd->poll_time_ns));

Hrm, this looks like it's going to have an issue with clock drift -
we're now unconditionally advancing the timer every period, even if the
data transfer hasn't pushed through a period of data.  This will cause
problems on lengthy playbacks (and shorter ones if the clocks are
sufficiently out of sync).

From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] ASoC: RX1950: Fix hw_params function
Date: Mon, 22 Nov 2010 15:15:46 +0200
Message-ID: <201011221515.46603.anarsoul@gmail.com>
References: <1289652821-5435-1-git-send-email-anarsoul@gmail.com>
	<20101115122736.GA12986@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DDD9E103800
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:15:52 +0100 (CET)
Received: by eyg24 with SMTP id 24so3761088eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 05:15:52 -0800 (PST)
In-Reply-To: <20101115122736.GA12986@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 15 November 2010 14:27:36 Mark Brown wrote:
> On Sat, Nov 13, 2010 at 02:53:41PM +0200, Vasily Khoruzhick wrote:
> > Unfortunatelly, I misunderstood datasheet, and on s3c244x-iis
> > when MPLLin source for master clock is selected, prescaler has
> > no effect. Remove dividor calculation for 44100 rate; remove 88200
> > rate at all, rx1950 can't do it.
> > 
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Applied, thanks.

Mark, is it possible to merge this patch into for-2.6.37?

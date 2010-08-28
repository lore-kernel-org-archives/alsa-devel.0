From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: uda1380: make driver more
	powersave-friendly
Date: Sat, 28 Aug 2010 10:14:46 +0100
Message-ID: <20100828091435.GC9324@opensource.wolfsonmicro.com>
References: <1282981776-10014-1-git-send-email-anarsoul@gmail.com>
	<1282981776-10014-2-git-send-email-anarsoul@gmail.com>
	<20100828085627.GA9324@opensource.wolfsonmicro.com>
	<201008281208.01273.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03EEC10383A
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 11:14:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008281208.01273.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 28, 2010 at 12:07:54PM +0300, Vasily Khoruzhick wrote:

> It seems that you misunderstood me, chip defaults are ok for first power up, 
> but resume is not first power up and codec defaults differ from cache, so we 
> want to sync cache with codec regs on resume, but it is not possible to sync 
> mixer regs until i2s clock is not applied, so we just mark them as dirty to 
> sync them later (just before playback, when i2s clock is already applied)

The normal flow for this is to mark things as dirty when you cut the
power rather than in one particular restore path - that is more robust
against code changes which alter the set of situations which can turn
off the power.

From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use
 reg_def_copy	instead of reg_cache_default
Date: Thu, 6 Jan 2011 10:26:43 -0600
Message-ID: <4D25ED43.9010701@freescale.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
	<20110105230339.GB5476@opensource.wolfsonmicro.com>
	<4D24F9E4.1080704@freescale.com>
	<20110105232947.GA8514@sirena.org.uk>
	<20110105235115.GB5714@opensource.wolfsonmicro.com>
	<4D250995.4020409@freescale.com>
	<20110106003455.GA12153@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by alsa0.perex.cz (Postfix) with ESMTP id 38555244B1
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 17:28:40 +0100 (CET)
In-Reply-To: <20110106003455.GA12153@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> So ask that question; "I looked at this and I'm not really sure if it's
> supposed to work or not - thing X suggests yes, thing Y suggests no but
> looks like a bug so..." and so on.
> 
> In cases like this (although not I suspect this particular one) the
> answer is often that there was't any particular consideration for
> whatever unusual case you're looking at.

Ah, but I don't think my case is "unusual".  Frankly, I think it's unusual to
hard-code default register values into a driver.  I just don't see how you can
guarantee that the values will be correct for all supported revisions of the chip.

On the CS4270, for instance, one register contains the chip revision number.
There's no way I can know which revision will be used on any given board.

Anyway, I'll work on fixing this and post a patch.

-- 
Timur Tabi
Linux kernel developer at Freescale

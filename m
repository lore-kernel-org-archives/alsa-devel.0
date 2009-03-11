From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ALSA: drop outdated and broken
	sa11xx-uda1341 driver
Date: Wed, 11 Mar 2009 21:26:54 +0000
Message-ID: <20090311212654.GE18096@n2100.arm.linux.org.uk>
References: <20090311211113.GA18750@rainbow>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 02CD81038A2
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 22:34:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090311211113.GA18750@rainbow>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2009 at 12:11:13AM +0300, Dmitry Artamonow wrote:
> It depends on L3 support from 2.4 kernel (CONFIG_L3) that never got
> merged into mainline. Since there's no way to use it on any of
> supported machines (iPaq h3100 or h3600), better drop it for now.
> It can be reimplemented later using ASoC infrastructure (there's
> already a driver for uda1341 codec in mainline, so only CPU and machine
> parts need to be written).

Yay, someone finally removing this.

I never saw this going in, but when I read through it, it was totally
iPAQ specific.  Having seen soo much effort put in to the OSS driver
to make it flexible, have the iPAQ people use that, and then write
their own ALSA specific driver irked the people who contributed to
the OSS driver, to the extent that the OSS support was ripped out.  (So
I have platforms here were there _was_ full sound support but with the
advent of ALSA, lost all sound support.)  It was certainly a sad day
when this driver was merged.

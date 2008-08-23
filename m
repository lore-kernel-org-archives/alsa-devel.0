From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC V2: disable automatic volume
	control in the	CS4270 sound driver
Date: Sat, 23 Aug 2008 14:39:06 +0100
Message-ID: <20080823133906.GA19258@opensource.wolfsonmicro.com>
References: <1218126153-26095-1-git-send-email-timur@freescale.com>
	<1218126153-26095-2-git-send-email-timur@freescale.com>
	<48AF2D39.6000701@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BAE5610380D
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Aug 2008 15:39:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48AF2D39.6000701@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 22, 2008 at 04:18:49PM -0500, Timur Tabi wrote:

> Did you guys forget about this patch?  I don't see it in asoc-v2-dev.

Just lost in the shuffle.  I've managed to locate a copy in my archives
and applied it now.  When sending reminders like this the more normal
approach is to resubmit the entire patch - apart from anything else,
there's a reasonable chance that if the patch was lost the original mail
has been lost as well so it'll need to be resent anyway.

It really would be better if changes like this could also be made to
mainline as well - it is much easier to review the differences between
the two branches if there aren't changes like this one that are
unrelated to the API changes mixed in as well.

From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1848 ac loop
Date: Wed, 19 Sep 2007 08:58:40 +0200
Message-ID: <46F0C8A0.9060401@gmail.com>
References: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id F27BF24447
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 08:59:42 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0709181930050.27377@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/19/2007 07:22 AM, Trent Piepho wrote:

> New thread for the the final version of the patches for my fixes to the
> ad1848 auto-calibration loop.  I made a couple suggested changes.  These
> should be ok to apply, and should be independent of the other as yet
> un-applied patches that have been posted by Rene and Krzysztof.

I don't believe I have anything outstanding anymore. If these are applied, 
I'll place one more on top to clean up that printk mess in there.

First "simplest fix" patch acked as a necesary fix for a dumb msleep while 
atomic bug that was introduced (by me).

Second "simplify" patch acked both as a simplification and a bugfix for a 
race that was introduced in the conversion to msleep().

Rene.

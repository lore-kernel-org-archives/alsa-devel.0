From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i.MX audio support
Date: Thu, 19 Nov 2009 16:28:30 +0000
Message-ID: <20091119162830.GA31336@rakim.wolfsonmicro.main>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AAA1E1037FF
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 17:28:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, javier.martin@vista-silicon.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:

> There already is a driver for i.MX in the tree, this one is a nearly complete
> rewrite. I haven't touched the in Kernel driver with these patches. The in
> Kernel driver has several problems, it doesn't use ioremap, uses direct pointer
> derefs instead of proper access functions and the only board supported so far is
> itself not supported in mainline.

I've CCed in Javier who wrote the currently merged code.

I'll review these patches tomorrow or over the weekend, however this
jumps out at me as being something that we'd want to fix before merging
since having two drivers for the same bit of hardware always leads to
problems going forwards.  I don't mind how this is addressed, replacing
the existing driver or incrementally fixing it would both work for me
(the latter is obviously preferrable but equally well we don't want to
get bogged down).

The approach of using FIQ for i.MX3x until SDMA gets merged seems like a
reasonable one.  It's not ideal but it will work and it shouldn't create
any problems transitioning to SDMA when that is submitted.

BTW, might be nice to use --no-chain-reply-to for git send-email - it
makes long patch sets look a lot nicer in a threaded mail reader.  Not a
big deal, though.

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: possible fix for buffer underruns on msm7k alsa
 driver
Date: Sun, 15 Aug 2010 12:29:25 +0100
Message-ID: <20100815112925.GA11017@sirena.org.uk>
References: <1281810584.15120.13.camel@gnutoo-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8024F2451C
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 13:29:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281810584.15120.13.camel@gnutoo-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 14, 2010 at 08:29:44PM +0200, Denis 'GNUtoo' Carikli wrote:
> hi, I'm still rebasing the codeaurora alsa driver for msm soc like the
> htcdream on the android msm 2.6.32 kernel.
> I looked the commits for the other socs like msm7kv2 and
> qsd8k(snapdragon)

Your mail is very lengthy and something seems to have stripped all the
indentation from the source code you've pasted.  This all makes it
extremely hard to read, and the fact that it's discussing drivers which
have never been sent upstream doesn't help either.

The last time I looked at MSM audio drivers I noticed several abuses of
APIs in there which make me concerned about the robustness of any
changes that one might make to the code.  I've no idea if this was the
same set of drivers as you are looking at, it's really unfortunate that
work on these drivers appears so fragmented.

From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: Re: possible fix for buffer underruns on msm7k alsa
	driver
Date: Sun, 15 Aug 2010 19:58:01 +0200
Message-ID: <1281895083-24953-1-git-send-email-GNUtoo@no-log.org>
References: <20100815112925.GA11017@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp201.alice.it (smtp201.alice.it [82.57.200.97])
	by alsa0.perex.cz (Postfix) with ESMTP id A00A8244E7
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 19:58:32 +0200 (CEST)
In-Reply-To: <20100815112925.GA11017@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>Your mail is very lengthy and something seems to have stripped all the
>indentation from the source code you've pasted.  This all makes it
>extremely hard to read, and the fact that it's discussing drivers which
>have never been sent upstream doesn't help either.
>
>The last time I looked at MSM audio drivers I noticed several abuses of
>APIs in there which make me concerned about the robustness of any
>changes that one might make to the code.  I've no idea if this was the
>same set of drivers as you are looking at, it's really unfortunate that
>work on these drivers appears so fragmented.

The reference code source is at:
http://gitorious.org/htc-msm-2-6-32/leviathan-incoming/trees/android-msm-2.6.32-rebase/sound/soc/msm

And the audio patch that I rebased were attached
The most important one is that one:
[PATCH 2/4] sound: soc: msm7k: improve buffer underrun issue

There are only 2 patches.

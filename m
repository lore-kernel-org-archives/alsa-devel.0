From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: possible fix for buffer underruns on msm7k alsa
 driver
Date: Sun, 15 Aug 2010 20:55:35 +0100
Message-ID: <20100815195535.GA12388@sirena.org.uk>
References: <20100815112925.GA11017@sirena.org.uk>
	<1281895083-24953-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C76E31037F5
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 21:55:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281895083-24953-1-git-send-email-GNUtoo@no-log.org>
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

On Sun, Aug 15, 2010 at 07:58:01PM +0200, Denis 'GNUtoo' Carikli wrote:

> >The last time I looked at MSM audio drivers I noticed several abuses of
> >APIs in there which make me concerned about the robustness of any
> >changes that one might make to the code.  I've no idea if this was the
> >same set of drivers as you are looking at, it's really unfortunate that
> >work on these drivers appears so fragmented.

> The reference code source is at:
> http://gitorious.org/htc-msm-2-6-32/leviathan-incoming/trees/android-msm-2.6.32-rebase/sound/soc/msm

That looks roughly like the problematic code I mentioned above.

> And the audio patch that I rebased were attached
> The most important one is that one:
> [PATCH 2/4] sound: soc: msm7k: improve buffer underrun issue

> There are only 2 patches.

Sorry, I'm a bit lost as to what the actual question is here?

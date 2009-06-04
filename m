From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC
	codec:	SSM2602: assign last substream to the master when
	shutting down
Date: Thu, 4 Jun 2009 09:59:21 +0100
Message-ID: <20090604085921.GD6983@rakim.wolfsonmicro.main>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59EB41037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:59:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 09:26:34PM -0400, Mike Frysinger wrote:

> it could be.  i was going by the changes that werent in 2.6.30.  i
> thought i looked for previous submissions, but i must have missed
> previous attempts.  i'm not familiar with alsa stuff, so i'm not

The patch hadn't previously been sent in that form but it looks like
it's attempting to fix a bug which had had some previous goes at fixing
it that required updates.

> always sure when i need to bang on Cliff to get things fixed up
> (changes split / better comments / etc...).

If you're not sure there's a case for better changelogs at least! :)

> if fixes miss a merge window, then that's an issue.  but in general,
> users only see fixes per release, so sending things more quickly there
> wouldnt really help ?

The issue is that things are missing merge windows - they're getting
sent in but if there's any review comments a revised version of the
patch isn't getting posted until the next batch of submissions.  It's
these revisions rather than the initial submissions that I'm concerned
about.

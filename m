From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Update Poodle to current ASoC API
Date: Thu, 24 Jul 2008 15:03:54 +0100
Message-ID: <20080724140353.GC14962@sirena.org.uk>
References: <20080724125448.GA4695@doriath.ww600.siemens.net>
	<20080724131019.GA14962@sirena.org.uk> <488885CB.702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F3FF324984
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 16:03:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <488885CB.702@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 24, 2008 at 09:38:19PM +0800, Eric Miao wrote:
> Mark Brown wrote:

> > I've queued this for Takashi, thanks (he's on holiday this week).  I
> > had thought that at least the second hunk was already fixed but it seems
> > not.

> This probably should go through the arm tree, along with other
> poodle patches, otherwise it just creates headache for Russell
> in the next merge.

Avoiding headaches for Russell was part of the goal here - ASoC is
currently undergoing some fairly invasive renovations which increase the
chances of conflicts being introduced with changes done to sound/soc
outside that.

This patch is in sound/soc only so it can't directly conflict with the
arch/arm changes that Russell is or will be carrying.

> As if should go into 2.6.27, I don't know. Depending on if it
> qualifies to be a fix or just a clean-up, from ALSA's point of
> view.

Currently it fails to build, partially fixed by this patch, so it's
not just coding style.

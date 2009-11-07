From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] ASoC/mpc5200: Add fudge factor to
 value reported by .pointer()
Date: Sat, 7 Nov 2009 19:33:18 +0000
Message-ID: <20091107193318.GB31789@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083448.18908.80366.stgit@angua>
	<20091107181153.GA31789@sirena.org.uk>
	<fa686aa40911071019y6be8283bu8d36d96420deefab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BB18103823
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 20:33:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fa686aa40911071019y6be8283bu8d36d96420deefab@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 07, 2009 at 11:19:54AM -0700, Grant Likely wrote:
> On Sat, Nov 7, 2009 at 11:11 AM, Mark Brown

> > It occurs to me that in terms of dealing with what's going on here this
> > probably is achieving exactly the same effect as Jon's code in that it
> > tells ALSA that things are a bit ahead of where the buffer started.

> Possibly, but I can both reproduce and eliminate the problem Jon is
> seeing regardless of whether or not this patch, so I'm not yet
> convinced.

That doesn't entirely surprise me; I'm not convinced that the original
approach entirely deals with the issue rather than just making it much
harder to see.

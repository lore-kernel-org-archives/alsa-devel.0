From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 01/13] Temporarily undo
 2008f137e92220b98120c4803499cdddb2b0fb06
Date: Thu, 14 May 2009 17:25:41 +0100
Message-ID: <1242318341.31458.1786.camel@finisterre>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015901.28145.40556.stgit@terra>
	<20090514101305.GB28291@sirena.org.uk>
	<9e4733910905140737u74e594f5wfc17fc068dc36361@mail.gmail.com>
	(sfid-20090514_153719_357777_D8DDC275)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F41B2103997
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 18:25:42 +0200 (CEST)
In-Reply-To: <9e4733910905140737u74e594f5wfc17fc068dc36361@mail.gmail.com>
	(sfid-20090514_153719_357777_D8DDC275)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-05-14 at 10:37 -0400, Jon Smirl wrote:

> You and I can easily see how this patch can be folded into the next
> one. Git is broken in this situation. I've reported the issue to the
> git people and they acknowledge it, but no one has fixed it. Git's
> merge strategy does not handle the case of a file splitting. When git
> tries to merge this one-liner into the next patch that splits the
> files, it does the merge wrong which then messes up the entire patch
> stack.

It should be possible to do the relevant thing by hand - it's only a one
line change you're staging out. Like I say, not the end of the world
anyway.

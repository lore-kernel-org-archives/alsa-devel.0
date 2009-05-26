From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 0/5] AC97 driver for mpc5200
Date: Tue, 26 May 2009 10:21:38 +0100
Message-ID: <20090526092137.GA2645@sirena.org.uk>
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FA86246BB
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 11:21:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 10:44:12PM -0500, Timur Tabi wrote:
> On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> > ? ? ?The macro spin_event_timeout() takes a condition and timeout value

> My patch is already set to go through the powerpc tree, so there's no
> need to repost it here.  Please, you changed the title of the patch.

Indeed.  Since this is a new driver I'm happy to let the code go in
without the new function and then sort itself out in the merge window.

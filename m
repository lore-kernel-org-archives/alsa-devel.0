From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 0/5] AC97 driver for mpc5200
Date: Tue, 26 May 2009 12:43:17 +0100
Message-ID: <20090526114316.GC8969@sirena.org.uk>
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
	<9e4733910905260408x335ac337wc77e4d9ac5027f61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BDB582474F
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 13:43:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905260408x335ac337wc77e4d9ac5027f61@mail.gmail.com>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 07:08:52AM -0400, Jon Smirl wrote:
> On Mon, May 25, 2009 at 11:44 PM, Timur Tabi <timur@freescale.com> wrote:

> > My patch is already set to go through the powerpc tree, so there's no
> > need to repost it here. ?Please, you changed the title of the patch.

> I'm changing the code, I removed the ! on the rc. Geert just asked to
> have it changed to an in-line too.

If you're doing that you need make it explicit and submit an incremental
patch against the PowerPC tree.  You'll also need to take care of any
affected users there.

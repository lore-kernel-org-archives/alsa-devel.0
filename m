From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Convert bitfields in ASOC into full int
	width
Date: Wed, 23 Jul 2008 17:19:58 +0100
Message-ID: <20080723161958.GD22926@sirena.org.uk>
References: <20080723030135.21577.69012.stgit@terra>
	<20080723103024.GA8377@sirena.org.uk>
	<9e4733910807230849y4d9273bfk11ccf5b783a8e2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DE09A103806
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 18:19:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807230849y4d9273bfk11ccf5b783a8e2d@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 11:49:50AM -0400, Jon Smirl wrote:

> Mask is usually the same as mask, but hasn't this been written to
> allow a max smaller than the max? If so these two areas look wrong.

Yes, that's the idea.

> 		if (power) {
> 			int i;
> 			/* power up has happended, increase volume to last level */
> 			if (invert) {
> // shouldn't this be
> //				for (i = max; i > widget->saved_value; i--)
> 				for (i = mask; i > widget->saved_value; i--)
> // and this mask is right

I think so.

> And this one should have used mask instead of max:

Looks like it, yes.

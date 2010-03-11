From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] mmp: support ssp in pxa168
Date: Thu, 11 Mar 2010 10:58:05 +0000
Message-ID: <20100311105804.GD2585@rakim.wolfsonmicro.main>
References: <771cded01003100514r70f0f53eydda7b916f92bef64@mail.gmail.com>
	<20100310142832.GB24422@rakim.wolfsonmicro.main>
	<f17812d71003110020g67bb7fd6tfe1381294b6cfe8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 92C37103920
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 11:58:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f17812d71003110020g67bb7fd6tfe1381294b6cfe8f@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 11, 2010 at 04:20:35PM +0800, Eric Miao wrote:
> On Wed, Mar 10, 2010 at 10:28 PM, Mark Brown

> > cycle? =A0I can apply the patches on a branch by themselves which can a=
lso
> > be pulled into the PXA tree if needed.

> I'd expect there to be some merge conflicts I need to solve along with
> my cleaning up of the SSP code. That said, it's better to go via -pxa
> tree and get the multi-codec work solved in linux-next?

That's not going to be possible with at least the machine driver - if
it's only present in one tree we can't do fixups in the other.  This is
why I'm saying put it on a branch and merge it into both trees, that way
both trees have the code in them as though things had been merged into
mainline already so problems are much less likely.

> Mark, could you please point me the reference to the multi-codec work
> so I can have a rough feeling of the possible merge issues?

There's a branch in Liam's git tree (still sketching out the goal rather
than the finished product):

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git

Big thing is that there's most likely going to be at least cosmetic
changes to how cards are registered.

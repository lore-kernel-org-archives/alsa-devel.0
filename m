From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [RFC PATCH 4/5] ASoC: remove those unnecessary
	#ifdef	CONFIG_PXA3xx .. #endif
Date: Thu, 23 Apr 2009 11:04:19 +0200
Message-ID: <20090423090419.GA29567@buzzloop.caiaq.de>
References: <f17812d70904222206h27c58e40t5c8383133df1a7d0@mail.gmail.com>
	<20090423081715.GA30105@sirena.org.uk>
	<f17812d70904230133l34f77174sc18d4f30879dac64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 50F0A103852
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 11:04:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904230133l34f77174sc18d4f30879dac64@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 04:33:34PM +0800, Eric Miao wrote:
> On Thu, Apr 23, 2009 at 4:17 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> > This isn't done for compiler optimisation - it's done because the
> > register bit macros are only defined if PXA3xx support is being built
> > in. =A0I've no problem with removing those guards but without that you'=
ll
> > get build failures on PXA2xx.
> >
> =

> Yeah, indeed. This is a rush (so the title is RFC), sorry. I'll get those
> conditional #ifdef .. #endif removed as well in the ssp-regs.h, it
> always makes me upset.

Well, I put them in there to clearly state which CPUs have support
for this particular feature. Especially for PXAs, where even register
definitions are considered confidential, this might help people fishing
in muddy waters. Some comment would do as well, though.

Daniel

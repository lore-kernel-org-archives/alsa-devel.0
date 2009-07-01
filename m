From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [RFC] I2S and LEFT_J
Date: Wed, 1 Jul 2009 14:17:21 +0200
Message-ID: <20090701121721.GB19257@buzzloop.caiaq.de>
References: <f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
	<1245077824.24109.51.camel@brutus>
	<20090615150433.GF6106@sirena.org.uk>
	<1245086420.24109.159.camel@brutus>
	<4A39F3A5.5030109@gmail.com> <1245328258.303.45.camel@brutus>
	<20090622221430.GH29236@buzzloop.caiaq.de>
	<1246062508.10360.358.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9588B24384
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 14:17:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246062508.10360.358.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On Fri, Jun 26, 2009 at 09:28:28PM -0300, Daniel Ribeiro wrote:
> Em Ter, 2009-06-23 =E0s 00:14 +0200, Daniel Mack escreveu:
> > Without network mode, these are the register values that do what I need:
> > =

> >   SSCR0 0x2100037F
> >   SSCR1 0x00C01d08
> >   SSPSP 0x31a08084
> >   (SSTSA/SSRSA don't matter in this case)
> =

> Thanks for the testing. If you don't mind, can you please replace the
> third patch, and try this one instead?

Jup, applied now.

> Use set_tdm_slot(5, 5, 4, 16), if this works for you we can just drop
> the pxa3xx special case and use SSCR0_FSRT and network mode for both
> pxa2xx and pxa3xx.

That gives an asynchronous LRCLK again.

> If not, use set_tdm_slot(1, 1, 1, 16), and tweak the
> (slots =3D=3D 1 && slot_width =3D=3D 16) special case as needed. This con=
dition
> should give you a config without SSCR0_MOD, and you should be able to
> match the register values above.

Unfortunately it doesn't. The resulting register values are

  SSCR0 0x200003ff
  SSCR1 0x00e01d80
  SSPSP 0x31a00084

and the LRCLK does not toggle any more at all, and hence DMA is not
happening. I couldn't do more investigation on this right now, but the
value dump might help. Let me know if I can do more tests.

Thanks,
Daniel

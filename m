From: Code Kipper <codekipper@gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/9] ASoC: sun4i-i2s: Fix sun8i tx
 channel offset mask
Date: Tue, 4 Jun 2019 10:15:22 +0200
Message-ID: <CAEKpxBn-XX+GRrMuCccwcC9TFKXGYV4S2ZwX+jBV==33RsW-aQ@mail.gmail.com>
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-2-codekipper@gmail.com>
 <20190604073443.cnnqd7ucbaehxdvj@flea> <CAGb2v64T5MypDD9A5FNfyikB9vFJZf9+TiQaXi_o2K53QmfaQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGb2v64T5MypDD9A5FNfyikB9vFJZf9+TiQaXi_o2K53QmfaQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Jun 2019 at 09:39, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Jun 4, 2019 at 3:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Jun 03, 2019 at 07:47:27PM +0200, codekipper@gmail.com wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > Although not causing any noticeable issues, the mask for the
> > > channel offset is covering too many bits.
> > >
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Would be nice to have
>
> Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Thanks....I'll keep this in mind for future reference as jernej also
mention this to me.
BR,
CK
>
> But otherwise,
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

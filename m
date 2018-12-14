From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: ASoC: About graph node issue without 'reg' property
Date: Fri, 14 Dec 2018 11:13:59 +0900
Message-ID: <20181214111358.FB47.4A936039@socionext.com>
References: <20181213182739.GZ10669@sirena.org.uk> <87tvjh7zj2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87tvjh7zj2.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san, Mark,

On Fri, 14 Dec 2018 09:05:02 +0900 <kuninori.morimoto.gx@renesas.com> wrote:

> 
> Hi Hayashi-san
> 
> Sorry for my buggy patch.
> I and Tony could confirm that my posted patch can solve
> this issue. I will re-post it again as v3 patch-series.
> I'm happy if you can test it (and give it Tested-by).
> 
> 	https://patchwork.kernel.org/patch/10727943/

Thank you for your great effort, and sorry my cross-post before your RFC patch
because I didn't catch it.

I confirmed your RFC patch solved the issue.
I'll also test your v3 patch-series on my environment.

> > [1  <text/plain; us-ascii (quoted-printable)>]
> > On Thu, Dec 13, 2018 at 04:24:28PM +0000, Mark Brown wrote:
> > > On Thu, Dec 13, 2018 at 07:39:45PM +0900, Kunihiko Hayashi wrote:
> > > 
> > > > Maybe I think that we'd better add 'reg' properties to each port,
> > > > however, there might be same matter in other SoCs, so I'm not sure
> > > > whether your patch breaks the backword compatibility or
> > > > our devicetrees are wrong.
> > 
> > > > I'd be glad if I could hear something about this issue from you.
> > 
> > > There's an ongoing thread between Morimoto-san and Tony Lindgren around
> > > the graph card including this issue, there Morimoto-san proposed some
> > > code which would let the reg property be optional.  Device trees should
> > > still be updated but that way we wouldn't actually break anything which
> > > would be good.

Yes. It's desiable to add the reg property in spite of the fixes.
I'll update our devicetrees.

Thank you,

> > 
> > There's a patch now - "[PATCH][RFC] ASoC: simple-card-utils: fixup
> > asoc_simple_card_get_dai_id() ID method".
> > [2 signature.asc <application/pgp-signature (7bit)>]
> > No public key for 24D68B725D5487D0 created at 2018-12-14T03:27:38+0900 using RSA


---
Best Regards,
Kunihiko Hayashi

From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 18:25:56 -0700
Message-ID: <20170404012555.GA19996@Asurada-Nvidia>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <CAG5mAdyg9jbNcGi6kNLf5s1wk7HkchM5-MjVVJNuATU07HtrUQ@mail.gmail.com>
 <20170403220811.GA21156@Asurada-Nvidia>
 <CAG5mAdxDiH4_FVqT5fC+PFGZ108GQCZiLLhja8xGRK0RdWo3oQ@mail.gmail.com>
 <20170403235542.GA23047@Asurada-Nvidia>
 <CAG5mAdwNj4K3Rk2LVXiN3i3QeS50vU4RUjHXPLg8Af7u1n_Pkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B32266A4B
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 03:25:54 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id 79so33489459pgf.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 18:25:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG5mAdwNj4K3Rk2LVXiN3i3QeS50vU4RUjHXPLg8Af7u1n_Pkg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 03, 2017 at 05:39:22PM -0700, Caleb Crome wrote:

> > If possible, could you try to confirm what's the diff between the
> > two SCR values of before-regmap and after-regmap in your case?
> 
> With this patch (broken audio, includes tx and rx, so 2 updates.
> Running atest software)
> ------------------------
> Apr  4 00:35:03 arm kernel: [   33.678451] Before update: 0x00001098
> Apr  4 00:35:03 arm kernel: [   33.682339] After update: 0x0000109f
> Apr  4 00:35:04 arm kernel: [   33.687196] Before update: 0x0000109f
> Apr  4 00:35:04 arm kernel: [   33.690916] After update: 0x0000109f
> 
> 
> Before this patch (working audio, running atest software)
> ------------------------
> Apr  4 00:38:24 arm kernel: [   68.261765] Before update: 0x00001098
> Apr  4 00:38:24 arm kernel: [   68.265653] After update: 0x0000109d
> Apr  4 00:38:24 arm kernel: [   68.270865] Before update: 0x0000109d
> Apr  4 00:38:24 arm kernel: [   68.274560] After update: 0x0000109f

So my understanding is correct. For 2-channel use cases, this
change probably wouldn't matter because the data is correctly
aligned -- there'd be only some zero data in the beginning.
But it is hard to tell for multi-channels.

SSI FIFO depth is 15 -- for dual-fifo settings, data wouldd be
only aligned if the channel number is 2, 6, 10. If you are able
to test 6 or 10 channels, I would like to see the result.

Overall, we probably need some support from i.MX hardware team.
Instead of setting three bits together, we need an alternative
solution which would create some flexibility for multi channel
cases. Otherwise, we may try to get rid of the NETWORK mode,
and the TE/RE-together-set accordingly.

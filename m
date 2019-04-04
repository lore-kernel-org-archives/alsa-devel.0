From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: audio-graph-card: don't select DPCM
 via audio-graph-card
Date: Wed, 3 Apr 2019 21:24:01 -0300
Message-ID: <CAOMZO5CZsxG=vAemWBUNH4rW0JfDr5kJ5CgB5XUBrmQqCAPyLg@mail.gmail.com>
References: <87ef6lnq52.wl-kuninori.morimoto.gx@renesas.com>
 <871s2i8wgt.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07B5AF8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 02:24:12 +0200 (CEST)
Received: by mail-lj1-x242.google.com with SMTP id h16so432081ljg.11
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2019 17:24:12 -0700 (PDT)
In-Reply-To: <871s2i8wgt.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 3, 2019 at 9:21 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Mark
>
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > commit ae3cb5790906b ("ASoC: audio-graph-card: merge
> > audio-graph-scu-card") merged audio-graph-scu-card which can
> > handle DPCM into audio-graph-card.
> >
> > By this patch, the judgement to select "normal sound card" or
> > "DPCM sound card" is based on its OF-graph endpoint connection.
> > But, because of it, existing "audio-graph-card" user who is
> > assuming "normal sound card" might select DPCM unintentionally.
> >
> > To solve this issue, this patch allows "audio-graph-card" user
> > can select "normal sound card", and "audio-graph-scu-card" user
> > can select both "normal sound card" and "DPCM sound card".
> > This keeps compatibility collectry.
> >
> > Reported-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
>
> I didn't mention.
> This patch is for v5.1

Maybe you should add a Fixes tag then?

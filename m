From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] ASoC: rsnd: explain extended Audio
	DMAC peri peri address
Date: Mon, 18 Mar 2019 09:04:04 +0100
Message-ID: <CAMuHMdWiCOvToh6gZnfTeiyZbeTmrYcBDve0_L_0s5LkqSDy9w@mail.gmail.com>
References: <87imwgye1k.wl-kuninori.morimoto.gx@renesas.com>
 <87ftrkye0f.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com
 [209.85.217.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74087F80709
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 09:04:17 +0100 (CET)
Received: by mail-vs1-f66.google.com with SMTP id j12so8897537vsd.3
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 01:04:17 -0700 (PDT)
In-Reply-To: <87ftrkye0f.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Jiada Wang <jiada_wang@mentor.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 18, 2019 at 6:11 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> If SoC has extended Audio DMAC peri peri address,
> DT needs to select it.
> Otherwise, it can select normal Audio DMAC peri peri address.
> Extended Audio DMAC peri peri address can use BUSIF4-7,
> normal address can't.
>
> Reported-by: Jiada Wang <jiada_wang@mentor.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [RFC PATCH 1/2] ASoC: simple-card: add support for
	bclk_ratio
Date: Tue, 26 Feb 2019 13:46:15 -0500
Message-ID: <CAGngYiXTEVfojHXePhcpjJPH80DWGCJ1o90PFXDq8jg6qEEN+w@mail.gmail.com>
References: <20190225164218.19439-1-TheSven73@gmail.com>
 <877ednbdnz.wl-kuninori.morimoto.gx@renesas.com>
 <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9142F8967C
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 19:46:28 +0100 (CET)
Received: by mail-oi1-x244.google.com with SMTP id t206so11219690oib.3
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 10:46:28 -0800 (PST)
In-Reply-To: <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 26, 2019 at 4:11 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Given that it is normal to talk about I2S being clocked at "64fs",
> "32fs" etc, wouldn't it just be much neater to specify _this_ value
> in DT, rather than half that value?
>

Would we be able to reach consensus on Russell's suggestion ?

From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [RFC PATCH 1/2] ASoC: simple-card: add support for
	bclk_ratio
Date: Tue, 26 Feb 2019 11:31:15 -0500
Message-ID: <CAGngYiXSNbQbcY1tbnYURWTCu7rJk=L1H+So7kanJmpxkV5bEQ@mail.gmail.com>
References: <20190225164218.19439-1-TheSven73@gmail.com>
 <877ednbdnz.wl-kuninori.morimoto.gx@renesas.com>
 <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
 <CAGngYiXrGNvwobKy+u8QWWsDowhTE8E7OSpVOOL1Yu9PvH-Z9w@mail.gmail.com>
 <20190226154519.e2wbvbkjynkaob4c@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FA64F8966C
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 17:31:27 +0100 (CET)
Received: by mail-ot1-x344.google.com with SMTP id v62so11604402otb.3
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 08:31:27 -0800 (PST)
In-Reply-To: <20190226154519.e2wbvbkjynkaob4c@shell.armlinux.org.uk>
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

On Tue, Feb 26, 2019 at 10:45 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
>
> I can't see how you'd extend a single I2S setup to support multi-
> channel audio without either adding more I2S data lines or adding
> additional WS signals (so making it e.g., a binary number).
>

That's a very good point too. In light of this, I struggle to understand how
the ssl_ssi can specify this:

static struct snd_soc_dai_driver fsl_ssi_dai_template = {
        .playback = {
                .stream_name = "CPU-Playback",
                .channels_min = 1,
                .channels_max = 32,
        },

There is talk in the manual about "network mode", which could work by changing
the LRCLK only at the first slot - thereby allowing clients to receive all
slots just by counting, as long as they know the slot size?

LRCLK   _____/-----------------\_____/---------
DATA    SLOT1|SLOT2|SLOT3|SLOT4|SLOT1

Well idk, I'm way out of my depth here.

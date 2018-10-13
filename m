From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 03/10] ASoC: sun8i-codec: add support for
 speaker amp GPIO
Date: Sat, 13 Oct 2018 12:00:19 +0800
Message-ID: <CAGb2v66sfw6AQFjCjDA5JwYsE4zOaKjxjSLX5J8vq=wZrdHDVw@mail.gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
 <20181013033230.6506-4-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BF4C2678CA
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 06:00:33 +0200 (CEST)
Received: by mail-ed1-f66.google.com with SMTP id l14-v6so4197498edq.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 21:00:33 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45])
 by smtp.gmail.com with ESMTPSA id j22-v6sm1436922edh.47.2018.10.12.21.00.31
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 21:00:32 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id a13-v6so15370821wrt.5
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 21:00:31 -0700 (PDT)
In-Reply-To: <20181013033230.6506-4-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Code Kipper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 13, 2018 at 11:33 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Some boards may have external amplifier for speaker that is controlled
> via GPIO, add support for it in similar way as it's done in sun4i-codec
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

ASoC now has a generic amplifier driver. Please use that instead.

See Documentation/devicetree/bindings/sound/simple-amplifier.txt

ChenYu

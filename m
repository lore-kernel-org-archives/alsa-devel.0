From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/9] ASoC: sun4i-i2s: Add quirk to handle
	fixed WSS
Date: Mon, 4 Dec 2017 08:43:33 +0800
Message-ID: <CAGb2v64BpqPzj0WOeiY0mQkX9QXqKctUJyfD9DOVfaE_K6k39g@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-2-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 29DD526710B
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 01:44:03 +0100 (CET)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 45EC020434
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 08:43:57 +0800 (CST)
Received: by mail-wm0-f54.google.com with SMTP id 64so11460004wme.3
 for <alsa-devel@alsa-project.org>; Sun, 03 Dec 2017 16:43:57 -0800 (PST)
In-Reply-To: <20171203204157.20829-2-anarsoul@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Dec 4, 2017 at 4:41 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> I2S for audio codec on sun50i-A64 always uses fixed word select size value,
> no matter what is sample width. Add quirk to support that.

Please clarify on this. Does this mean the WSS bitfield is useless and it
always sends out the same sample sizes regardless of the setting? Or it's
the codec that can only use a fixed sample width?

As far as I can tell, the code you added in this patch points to the latter.
In that case. this is the wrong way to go about it. The limitation is a
property of the codec, not the I2S controller. If the codec assumes 32 bits
per sample, then that is what you should setup in the code driver. See
sun8i_codec_dai in sound/soc/sunxi/sun8i-codec.c where you can set the
format. You'll likely need to make a copy of the data structure for A64,
and tie it to the compatible.

ChenYu

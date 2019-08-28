From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 1/2] ASoC: sun4i-i2s: Revert "ASoC: sun4i-i2s: Remove
 duplicated quirks structure"
Date: Wed, 28 Aug 2019 15:32:26 +0800
Message-ID: <CAGb2v65d3SjJEU_zqXqEKakTYoOB7tk_fo7OkJ_Gvq5Yok+_=A@mail.gmail.com>
References: <20190827123131.29129-1-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827123131.29129-1-mripard@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <mripard@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Code Kipper <codekipper@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Aug 27, 2019 at 8:31 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> This reverts commit 3e9acd7ac6933cdc20c441bbf9a38ed9e42e1490.
>
> It turns out that while one I2S controller is described in the A83t
> datasheet, the driver supports another, undocumented, one that has been
> inherited from the older SoCs, while the documented one uses the new
> design.
>
> Fixes: 3e9acd7ac693 ("ASoC: sun4i-i2s: Remove duplicated quirks structure")
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

This patch got applied as

    455b1d42e82c ("ASoC: sunxi: Revert initial A83t support")

The new subject is very confusing. If anything it should read

    ASoC: sun4i-i2s: Split H3 and later SoC support from A83T support

ChenYu

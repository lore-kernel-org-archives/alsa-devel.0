From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] ASoC: sun8i-codec: Invert Master / Slave condition
Date: Thu, 9 Nov 2017 00:22:36 +0800
Message-ID: <CAGb2v658cy=vZkWDKQc-zCwfq+ezLqxctk=YwjidhsOzjDQY2A@mail.gmail.com>
References: <20171108154710.16407-1-maxime.ripard@free-electrons.com> <20171108154710.16407-2-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171108154710.16407-2-maxime.ripard@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Code Kipper <codekipper@gmail.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 8, 2017 at 11:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The current code had the condition backward when checking if the codec
> should be running in slave or master mode.
>
> Fix it, and make the comment a bit more readable.
>
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

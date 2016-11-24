From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [patch] ASoC: sunxi: Uninitialized variable in probe()
Date: Thu, 24 Nov 2016 12:33:37 +0800
Message-ID: <CAGb2v64R=0h-89t0MB5OZWzqK-Qobr3AS8HkadjthAuiFuL_Yw@mail.gmail.com>
References: <20161123222906.GA27895@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161123222906.GA27895@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Linux-ALSA <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2016 at 6:29 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Oddly enough, my version of GCC misses this uninitialized variable.
>
> Fixes: ba2ff3027b5a ("ASoC: sunxi: Add support for A23/A33/H3 codec's analog path controls")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

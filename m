From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: wm8955: harmless underflow in wm8955_put_deemph()
Date: Tue, 13 Oct 2015 13:29:04 +0100
Message-ID: <20151013122904.GJ8805@ck-lbox>
References: <20151013071048.GG31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151013071048.GG31537@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2015 at 10:10:48AM +0300, Dan Carpenter wrote:
> Valid values for "deemph" are zero and one, but we mistakenly allow
> negative values as well.  It's harmless but we may as well clean it up.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles

From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: wm8731: harmless underflow in wm8731_put_deemph()
Date: Tue, 13 Oct 2015 13:27:33 +0100
Message-ID: <20151013122733.GG8805@ck-lbox>
References: <20151013070857.GC31537@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151013070857.GC31537@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <fabio.estevam@freescale.com>, Songjun Wu <songjun.wu@atmel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Axel Lin <axel.lin@ingics.com>, Sergey Kiselev <sergey.kiselev@intel.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2015 at 10:08:57AM +0300, Dan Carpenter wrote:
> The code tries to verify that "deemph" is zero or one, but it fails to
> account for that it can be negative.  It's harmless because negatives
> are treated the same as one, but we should fix it just to silence the
> static checker warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles

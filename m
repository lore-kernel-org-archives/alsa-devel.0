From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: wm8741: check for error returns from
	wm8741_set_pdata()
Date: Wed, 20 May 2015 08:48:32 +0100
Message-ID: <20150520074832.GB31187@opensource.wolfsonmicro.com>
References: <20150520074035.GB18278@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150520074035.GB18278@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Sergej Sawazki <ce3a@gmx.de>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 20, 2015 at 10:40:35AM +0300, Dan Carpenter wrote:
> Static checkers complain that "ret" is always zero so the conditions are
> never true.
> 
> The intention here was clearly to check for errors from
> wm8741_set_pdata().  Although, since wm8741_set_pdata() never returns
> errors, it doesn't affect runtime.
> 
> Fixes: c354b54cfdf6 ('ASoC: wm8741: Add differential mono mode support')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles

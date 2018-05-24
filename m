From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH] sound: Use octal not symbolic permissions
Date: Thu, 24 May 2018 09:41:23 +0530
Message-ID: <20180524041123.GB26663@vkoul-mobl>
References: <b32d7b5f7827cc3283e4e46c3135144373404621.1527103197.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b32d7b5f7827cc3283e4e46c3135144373404621.1527103197.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 23-05-18, 12:20, Joe Perches wrote:
> Convert the S_<FOO> symbolic permissions to their octal equivalents as
> using octal and not symbolic permissions is preferred by many as more
> readable.
> 
> see: https://lkml.org/lkml/2016/8/2/1945
> 
> Done with automated conversion via:
> $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
> 
> Miscellanea:
> 
> o Wrapped one multi-line call to a single line
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  sound/core/compress_offload.c             |  2 +-

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

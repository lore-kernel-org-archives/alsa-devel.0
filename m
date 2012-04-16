From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] soc: fix printk format in soc-dapm.c
Date: Mon, 16 Apr 2012 19:52:04 -0300
Message-ID: <CAOMZO5BXn=LpEpyzcYqn=dSYhO2orBLwYD=XStFPqVhtr5S-6Q@mail.gmail.com>
References: <20120416161121.261ba4e7e38989173accfb16@canb.auug.org.au>
	<4F8CC0E9.3010407@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4F8CC0E9.3010407@xenotime.net>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 16, 2012 at 10:01 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> Fix printk format warning for 'formats':
>
> sound/soc/soc-dapm.c:2913:5: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'u64'

I have sent a fix for this earlier today and Mark has already applied it.

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung: s3c-i2s-v2.c needs module.h
Date: Sun, 2 Oct 2011 19:26:06 +0100
Message-ID: <20111002182605.GC2857@opensource.wolfsonmicro.com>
References: <1317562466.4996.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317562466.4996.2.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 02, 2011 at 09:34:26PM +0800, Axel Lin wrote:
> Include <linux/module.h> to fix below build error:
> 
>   CC      sound/soc/samsung/s3c-i2s-v2.o
> sound/soc/samsung/s3c-i2s-v2.c:573: warning: data definition has no type or storage class

What tree is this for?  My primary development platform is based on this
driver, I'd expect to have noticed any build issues and I rather suspect
this isn't what you're supposed to do after all the module.h stuff has
settled down.

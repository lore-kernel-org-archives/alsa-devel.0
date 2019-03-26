From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BACKPORT 4.4.y 02/25] ALSA: compress: add support for 32bit
 calls in a 64bit kernel
Date: Tue, 26 Mar 2019 08:55:14 +0100
Message-ID: <CAK8P3a22Mp9yR49CEe2bq240SuSpbvy1XBDa2sSvWYMt=AZM3Q@mail.gmail.com>
References: <20190322154425.3852517-1-arnd@arndb.de> <20190322154425.3852517-3-arnd@arndb.de>
 <20190326010911.GB29420@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326010911.GB29420@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ravindra Lokhande <rlokhande@nvidia.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Joe Perches <joe@perches.com>, Dan Carpenter <dan.carpenter@oracle.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 26, 2019 at 2:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 22, 2019 at 04:43:53PM +0100, Arnd Bergmann wrote:
> > From: Ravindra Lokhande <rlokhande@nvidia.com>
> >
> > Compress offload does not support ioctl calls from a 32bit userspace
> > in a 64 bit kernel. This patch adds support for ioctls from a 32bit
> > userspace in a 64bit kernel
> >
> > Signed-off-by: Ravindra Lokhande <rlokhande@nvidia.com>
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > (cherry picked from commit c10368897e104c008c610915a218f0fe5fa4ec96)
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  sound/core/compress_offload.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
>
> How is this not a "new feature"?  What bug does this fix?  Has this ever
> worked in the past?

It has never worked in the past, but I consider it a bug for the compat layer
to behave differently from native code. In this case, any 32-bit application
using the SNDRV_COMPRESS_* ioctls will just fail to do anything on
a 64-bit kernel at all without the trivial fix that should have been there when
the driver was originally merged.

     Arnd

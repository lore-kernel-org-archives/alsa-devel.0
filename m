From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH 01/11] MAINTANERS: Add AXD as a supported
 driver
Date: Wed, 29 Oct 2014 11:12:52 +0530
Message-ID: <20141029054252.GX28745@intel.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
 <1414495589-8579-2-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414495589-8579-2-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2014 at 11:26:19AM +0000, Qais Yousef wrote:
> AXD is Audio Processing IP driver that will be added in the following commits

This should be after the addition of files, so last patch pls

-- 
~Vinod
> 
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <alsa-devel@alsa-project.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dab92a78d1d5..b42c7386190e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1826,6 +1826,12 @@ F:	include/uapi/linux/ax25.h
>  F:	include/net/ax25.h
>  F:	net/ax25/
>  
> +AXD AUDIO PROCESSING IP DRIVER
> +M:	Qais Yousef <qais.yousef@imgtec.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/axd.txt
> +F:	drivers/char/axd/
> +
>  AZ6007 DVB DRIVER
>  M:	Mauro Carvalho Chehab <m.chehab@samsung.com>
>  L:	linux-media@vger.kernel.org
> -- 
> 2.1.0
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 

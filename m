From: Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 1/6] docs: fix a couple of new broken references
Date: Wed, 31 Jul 2019 15:36:55 -0500
Message-ID: <0fd2f332-891f-b3f8-6d6c-e58358611228@oracle.com>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <5b4fae5978d309641fa8ba233a9efe2b48201cd6.1564603513.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5b4fae5978d309641fa8ba233a9efe2b48201cd6.1564603513.git.mchehab+samsung@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Kleikamp <shaggy@kernel.org>, alsa-devel@alsa-project.org, Evgeniy Dushistov <dushistov@mail.ru>, Mathieu Poirier <mathieu.poirier@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Maxime Ripard <maxime.ripard@bootlin.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, jfs-discussion@lists.sourceforge.net, Mauro Carvalho Chehab <mchehab@infradead.org>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 7/31/19 3:08 PM, Mauro Carvalho Chehab wrote:
> Those are due to recent changes. Most of the issues
> can be automatically fixed with:
> 
> 	$ ./scripts/documentation-file-ref-check --fix
> 
> The only exception was the sound binding with required
> manual work.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: > Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt | 2 +-
>  MAINTAINERS                                                 | 4 ++--
>  drivers/hwtracing/coresight/Kconfig                         | 2 +-
>  fs/jfs/Kconfig                                              | 2 +-
>  fs/ufs/Kconfig                                              | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
> index 2ca3d138528e..7ecf6bd60d27 100644
> --- a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
> +++ b/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
> @@ -4,7 +4,7 @@ Allwinner SUN8I audio codec
>  On Sun8i-A33 SoCs, the audio is separated in different parts:
>  	  - A DAI driver. It uses the "sun4i-i2s" driver which is
>  	  documented here:
> -	  Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +	  Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
>  	  - An analog part of the codec which is handled as PRCM registers.
>  	  See Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
>  	  - An digital part of the codec which is documented in this current
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6de82f019a52..f109a8bcffda 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8659,7 +8659,7 @@ L:	jfs-discussion@lists.sourceforge.net
>  W:	http://jfs.sourceforge.net/
>  T:	git git://github.com/kleikamp/linux-shaggy.git
>  S:	Maintained
> -F:	Documentation/filesystems/jfs.txt
> +F:	Documentation/admin-guide/jfs.rst
>  F:	fs/jfs/
>  
>  JME NETWORK DRIVER
> @@ -16439,7 +16439,7 @@ F:	drivers/hid/hid-udraw-ps3.c
>  UFS FILESYSTEM
>  M:	Evgeniy Dushistov <dushistov@mail.ru>
>  S:	Maintained
> -F:	Documentation/filesystems/ufs.txt
> +F:	Documentation/admin-guide/ufs.rst
>  F:	fs/ufs/
>  
>  UHID USERSPACE HID IO DRIVER:
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 14638db4991d..7a9f5fb08330 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -106,7 +106,7 @@ config CORESIGHT_CPU_DEBUG
>  	  can quickly get to know program counter (PC), secure state,
>  	  exception level, etc. Before use debugging functionality, platform
>  	  needs to ensure the clock domain and power domain are enabled
> -	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
> +	  properly, please refer Documentation/trace/coresight-cpu-debug.rst
>  	  for detailed description and the example for usage.
>  
>  endif
> diff --git a/fs/jfs/Kconfig b/fs/jfs/Kconfig
> index 22a273bd4648..05cb0e8e4382 100644
> --- a/fs/jfs/Kconfig
> +++ b/fs/jfs/Kconfig
> @@ -5,7 +5,7 @@ config JFS_FS
>  	select CRC32
>  	help
>  	  This is a port of IBM's Journaled Filesystem .  More information is
> -	  available in the file <file:Documentation/filesystems/jfs.txt>.
> +	  available in the file <file:Documentation/admin-guide/jfs.rst>.
>  
>  	  If you do not intend to use the JFS filesystem, say N.
>  
> diff --git a/fs/ufs/Kconfig b/fs/ufs/Kconfig
> index fcb41516ea59..6d30adb6b890 100644
> --- a/fs/ufs/Kconfig
> +++ b/fs/ufs/Kconfig
> @@ -9,7 +9,7 @@ config UFS_FS
>  	  this file system as well. Saying Y here will allow you to read from
>  	  these partitions; if you also want to write to them, say Y to the
>  	  experimental "UFS file system write support", below. Please read the
> -	  file <file:Documentation/filesystems/ufs.txt> for more information.
> +	  file <file:Documentation/admin-guide/ufs.rst> for more information.
>  
>            The recently released UFS2 variant (used in FreeBSD 5.x) is
>            READ-ONLY supported.
> 

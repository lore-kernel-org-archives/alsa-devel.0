From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] sound,
 isapnp: allow building more drivers with COMPILE_TEST
Date: Tue, 24 Apr 2018 10:34:04 +0200
Message-ID: <d6007528-98a3-492a-e1d3-d43c23bf3a09@intel.com>
References: <082977bdb133dc0570f690d3f3a120207f1d63f1.1524229123.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E9C4266CA1
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 10:34:08 +0200 (CEST)
In-Reply-To: <082977bdb133dc0570f690d3f3a120207f1d63f1.1524229123.git.mchehab@s-opensource.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 4/20/2018 2:58 PM, Mauro Carvalho Chehab wrote:
> Drivers that depend on ISAPNP currently can't be built with
> COMPILE_TEST. However, looking at isapnp.h, there are already
> stubs there to allow drivers to include it even when isa
> PNP is not supported.
>
> So, remove such dependencies when COMPILE_TEST.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>   drivers/pnp/isapnp/Kconfig | 2 +-
>   sound/isa/Kconfig          | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
> index f1ef36673ad4..a1af146d2d90 100644
> --- a/drivers/pnp/isapnp/Kconfig
> +++ b/drivers/pnp/isapnp/Kconfig
> @@ -3,7 +3,7 @@
>   #
>   config ISAPNP
>   	bool "ISA Plug and Play support"
> -	depends on ISA
> +	depends on ISA || COMPILE_TEST
>   	help
>   	  Say Y here if you would like support for ISA Plug and Play devices.
>   	  Some information is in <file:Documentation/isapnp.txt>.
> diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
> index d2a6cdd0395c..43b35a873d78 100644
> --- a/sound/isa/Kconfig
> +++ b/sound/isa/Kconfig
> @@ -39,7 +39,7 @@ config SND_ADLIB
>   
>   config SND_AD1816A
>   	tristate "Analog Devices SoundPort AD1816A"
> -	depends on PNP && ISA
> +	depends on PNP
>   	select ISAPNP
>   	select SND_OPL3_LIB
>   	select SND_MPU401_UART
> @@ -67,7 +67,7 @@ config SND_AD1848
>   
>   config SND_ALS100
>   	tristate "Diamond Tech. DT-019x and Avance Logic ALSxxx"
> -	depends on PNP && ISA
> +	depends on PNP
>   	select ISAPNP
>   	select SND_OPL3_LIB
>   	select SND_MPU401_UART
> @@ -108,7 +108,7 @@ config SND_AZT2316
>   
>   config SND_AZT2320
>   	tristate "Aztech Systems AZT2320"
> -	depends on PNP && ISA
> +	depends on PNP
>   	select ISAPNP
>   	select SND_OPL3_LIB
>   	select SND_MPU401_UART


Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

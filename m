From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v1 08/11] ASoC: Intel: Make PCI dependency
	explicit
Date: Fri, 21 Dec 2018 19:18:21 -0800
Message-ID: <eb27ab03-4f42-2e2e-9873-16d9a6927e2b@infradead.org>
References: <20181222001452.7474-1-okaya@kernel.org>
 <20181222001452.7474-9-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CE43267AC2
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2018 04:18:30 +0100 (CET)
In-Reply-To: <20181222001452.7474-9-okaya@kernel.org>
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
To: Sinan Kaya <okaya@kernel.org>, linux-next@vger.kernel.org
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/21/18 4:14 PM, Sinan Kaya wrote:
> IOSF_MBI driver depends on CONFIG_PCI set but this is not specified
> anywhere.

wrong patch description...?

> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  sound/soc/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 2fd1b61e8331..b0764b2fe001 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>  config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>  	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>  	default ACPI
> -	depends on X86 && ACPI
> +	depends on X86 && ACPI && PCI
>  	select SND_SST_IPC_ACPI
>  	select SND_SST_ATOM_HIFI2_PLATFORM
>  	select SND_SOC_ACPI_INTEL_MATCH
> 


-- 
~Randy

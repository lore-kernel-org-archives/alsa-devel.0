From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: Intel: Convert all sst_codecs
 data defintion to c99 style
Date: Fri, 9 Jun 2017 09:28:52 +0530
Message-ID: <20170609035852.GU2885@localhost>
References: <1496885261-10771-1-git-send-email-harshapriya.n@intel.com>
 <1496885261-10771-3-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 9215D267339
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 05:56:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1496885261-10771-3-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 07, 2017 at 06:27:40PM -0700, Harsha Priya wrote:
> C99 style struct initialization helps in readability as well as
> initialization of variables not specified as NULL. This patch
> changes the struct data defintions in skl.c that were not in c99 style.

here as well :(

> ---
>  sound/soc/intel/skylake/skl.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 4ebae85..6a79fc7 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -876,10 +876,25 @@ static void skl_remove(struct pci_dev *pci)
>  	dev_set_drvdata(&pci->dev, NULL);
>  }
>  
> -static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
> -static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
> -static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
> -static struct sst_codecs kbl_poppy_codecs = { 1, {"10EC5663"} };
> +static struct sst_codecs skl_codecs = {
> +	.num_codecs = 1,
> +	.codecs = {"NAU88L25"}
> +};
> +
> +static struct sst_codecs kbl_codecs = {
> +	.num_codecs = 1,
> +	.codecs = {"NAU88L25"}
> +};
> +
> +static struct sst_codecs bxt_codecs = {
> +	.num_codecs = 1,
> +	.codecs = {"MX98357A"}
> +};
> +
> +static struct sst_codecs kbl_poppy_codecs = {
> +	.num_codecs = 1,
> +	.codecs = {"10EC5663"}
> +};
>  
>  static struct sst_acpi_mach sst_skl_devdata[] = {
>  	{
> -- 
> 1.9.1
> 

-- 
~Vinod

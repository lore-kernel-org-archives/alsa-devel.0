From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] intel_sst: fix comment typo
Date: Thu, 8 Sep 2011 15:43:08 -0700
Message-ID: <20110908224307.GA5201@opensource.wolfsonmicro.com>
References: <20110906072129.7310.6960.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA26324E0B
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 00:43:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110906072129.7310.6960.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>, gregkh@suse.de
Cc: Koul Vinod <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 06, 2011 at 03:21:29PM +0800, Lu Guanqun wrote:
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> ---
>  drivers/staging/intel_sst/intel_sst_dsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

This is a staging driver - patches should go via Greg (who I've added
here) to avoid collisions with other staging work.  This has:

Acked-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Liam Girdwood <lrg@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I've applied the other three patches, thanks.

> 
> diff --git a/drivers/staging/intel_sst/intel_sst_dsp.c b/drivers/staging/intel_sst/intel_sst_dsp.c
> index a89e1ad..426d2b9 100644
> --- a/drivers/staging/intel_sst/intel_sst_dsp.c
> +++ b/drivers/staging/intel_sst/intel_sst_dsp.c
> @@ -104,7 +104,7 @@ static int sst_start_mrst(void)
>  /**
>   * sst_start_medfield - Start the SST DSP processor
>   *
> - * This starts the DSP in MRST platfroms
> + * This starts the DSP in Medfield platfroms
>   */
>  static int sst_start_medfield(void)
>  {
> 

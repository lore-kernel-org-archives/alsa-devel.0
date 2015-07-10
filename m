From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 10 Jul 2015 09:30:32 +0530
Message-ID: <20150710040032.GW836@localhost>
References: <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org>
 <559A90CE.2030105@gmail.com> <20150707031950.GD11002@localhost>
 <559BDB7F.9010105@gmail.com> <20150707170821.GL11002@localhost>
 <559C3F4A.5030307@gmail.com> <20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it>
 <559D88C1.3010504@bazdara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3475C2664B5
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 05:58:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <559D88C1.3010504@bazdara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luka Karinja <lk@bazdara.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, Antonio Ospite <ao2@ao2.it>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Tyler Yeomans <tyeo098@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 08, 2015 at 10:32:01PM +0200, Luka Karinja wrote:
> Hello guys. I have been trying to get sound on my Asus T100TAF with rt5642.
> I have been following your various threads but i'm not succesfull
> with getting sound working.
> Hoppfully you can give me a hand
> 
> The changes i made to the kernel:
> 
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index bb19b58..b45cf3e 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -118,7 +118,7 @@ static const struct sst_res_info byt_rvp_res_info = {
>  	.mbox_size = 0x1000,
>  	.acpi_lpe_res_index = 0,
>  	.acpi_ddr_index = 2,
> -	.acpi_ipc_irq_index = 5,
> +	.acpi_ipc_irq_index = 0,
irq index in deafult shoudl work for t100, you should see interrupts

>  };
>  static struct sst_platform_info byt_rvp_platform_data = {
> @@ -345,6 +345,8 @@ static int sst_acpi_remove(struct platform_device *pdev)
>  static struct sst_machines sst_acpi_bytcr[] = {
>  	{"10EC5640", "T100", "bytt100_rt5640", NULL, "intel/fw_sst_0f28.bin",
>  						&byt_rvp_platform_data },
> +	{"10EC5642", "T100", "bytt100_rt5640", NULL, "intel/fw_sst_0f28_ssp0.bin",
> +						&byt_rvp_platform_data },
That wont work, I have verfied with T100, it is SSP2 based, so SSP0 will nto
work here. I am trying to get this tested on latest driver and provide a
working config. Will update shortly

-- 
~Vinod

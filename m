From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
 driver" to the asoc tree
Date: Tue, 31 May 2016 07:29:19 -0500
Message-ID: <bd2f5937-39bf-5892-959e-ec11cf2c5dba@linux.intel.com>
References: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 644B326057F
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 14:29:22 +0200 (CEST)
In-Reply-To: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pietro <pxpert@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/31/16 3:43 AM, Pietro wrote:
> Hi,
>
> I'm an owner of a 2 in 1 Netbook with an Atom X5 Z8300 SoC with rt5651 codec (Cube iWork 11).
>
> To get audio working I Added these lines of code to the ./soc/intel/atom/sst/sst_acpi.c file:
>
> --- ./soc/intel/atom/sst/sst_acpi.c.old 2016-05-31 09:05:40.045682194 +0200
> +++ ./soc/intel/atom/sst/sst_acpi.c     2016-05-31 09:07:26.829324148 +0200
> @@ -342,9 +342,12 @@
>                                                 &chv_platform_data },
>         {"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
>                                                 &chv_platform_data },
> +       {"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
> +                                               &byt_rvp_platform_data },
>         {},
>  };

use the same as for rt5640 on cht:

/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", 
NULL, &chv_platform_data },

>
> +
>  static const struct acpi_device_id sst_acpi_ids[] = {
>         { "80860F28", (unsigned long)&sst_acpi_bytcr},
>         { "808622A8", (unsigned long) &sst_acpi_chv},
>
>
>
>
> Then i added the UCM files linked in these archive:
> https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
>
>
>
> With this configuration, audio seems to work, but is 'slow': Playback speed is at slow motion, and seconds move slowly (Tried with aplay and audacious with many sound files, using directly Alsa and Pulseaudio with no differencies).
>
> This seems to be a DSP Clock problem. Have you got any suggestions to solve this problem?

we've had this report before with rt5640 but it's unclear what might 
cause this. the codec is configured as slave and uses the bit clock as 
source for its PLL.
the easiest fix in this case would be to use the 19.2 MCLK which is 
enabled by default on CHT, see examples in cht-bsw-rt5645 (look at 
platform clock control and everything with set_sys_clk, but keep the 2 
slots). We will add this on baytrail as well at some point when we have 
a clock framework driver for the MCLK control.

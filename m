From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Build Medfield compressed ops
Date: Fri, 9 May 2014 00:18:50 +0000
Message-ID: <8D3F6266AEB6384E807C6FFC6FE195E3030B94B4@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 16F4E265524
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 02:19:31 +0200 (CEST)
Content-Language: en-US
Content-ID: <D6C9A972BD78FD4B8712722008F23DA8@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org


On 9 May 2014 04:01, Mark Brown <broonie@kernel.org> wrote:
>
> From: Mark Brown <broonie@linaro.org>
>
> Since commit 4b68b4e1c564 (ASoC: Intel: split the pcm and compress to
> different files) the compressed ops haven't been built causing link
> failures on allyesconfig and making the driver unbuildable.  Add the
> object to the Makefile to fix that.
>

Thanks looks like makefile patch missed this. I will fix and resend the series next week when I am back
> Signed-off-by: Mark Brown <broonie@linaro.org>
Acked-by Vinod Koul <vinod.koul@intel.com>

> ---
>  sound/soc/intel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
> index 5d3fb6f35a19..0db4e2f336dc 100644
> --- a/sound/soc/intel/Makefile
> +++ b/sound/soc/intel/Makefile
> @@ -2,7 +2,7 @@
>  snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
>  snd-soc-sst-acpi-objs := sst-acpi.o
>
> -snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o
> +snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o sst-mfld-platform-compress.o
>  snd-soc-mfld-machine-objs := mfld_machine.o
>
>  obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
> --
> 2.0.0.rc2
>

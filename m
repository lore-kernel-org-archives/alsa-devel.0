From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ARM: tegra: Add to struct
	harmony_audio_platform_data
Date: Tue, 01 Feb 2011 14:01:46 +0000
Message-ID: <1296568906.3327.14.camel@odin>
References: <1296513435-14792-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BEF4224519
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:01:50 +0100 (CET)
Received: by wyi11 with SMTP id 11so6657198wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 06:01:50 -0800 (PST)
In-Reply-To: <1296513435-14792-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-31 at 15:37 -0700, Stephen Warren wrote:
> Add fields to describe all the audio-related GPIOs on Harmony, except for
> the codec's GPIO IRQ, which will be passed in its i2c_board_info.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Mark, can you please apply this to your tegra-arch branch, and merge that.
> Thanks!
> 
>  arch/arm/mach-tegra/include/mach/harmony_audio.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/include/mach/harmony_audio.h b/arch/arm/mach-tegra/include/mach/harmony_audio.h
> index 5c46391..af08650 100644
> --- a/arch/arm/mach-tegra/include/mach/harmony_audio.h
> +++ b/arch/arm/mach-tegra/include/mach/harmony_audio.h
> @@ -16,4 +16,7 @@
>  
>  struct harmony_audio_platform_data {
>  	int gpio_spkr_en;
> +	int gpio_hp_det;
> +	int gpio_int_mic_en;
> +	int gpio_ext_mic_en;
>  };


Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

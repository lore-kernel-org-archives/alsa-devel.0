From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: intel: Fix PM and non-atomic crash
	in bytcr drivers
Date: Mon, 24 Apr 2017 16:39:47 -0500
Message-ID: <14ce353a-5dd5-76bc-d98b-d0d3e8b4e757@linux.intel.com>
References: <20170424120955.15519-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 19546266AF7
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 23:39:49 +0200 (CEST)
In-Reply-To: <20170424120955.15519-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 04/24/2017 07:09 AM, Takashi Iwai wrote:
> The FE setups of Intel SST bytcr_rt5640 and bytcr_rt5651 drivers carry
> the ignore_suspend flag, and this prevents the suspend/resume working
> properly while the stream is running, since SST core code has the
> check of the running streams and returns -EBUSY.  Drop these
> superfluous flags for fixing the behavior.
>
> Also, the bytcr_rt5640 driver lacks of nonatomic flag in some FE
> definitions, which leads to the kernel Oops at suspend/resume like:
This patch also fixes the known bug that reboot had to be forced on some 
BYT platforms with a manual restart when the audio driver was enabled.
Thanks Takashi!

>
>    BUG: scheduling while atomic: systemd-sleep/3144/0x00000003
>    Call Trace:
>     dump_stack+0x5c/0x7a
>     __schedule_bug+0x55/0x70
>     __schedule+0x63c/0x8c0
>     schedule+0x3d/0x90
>     schedule_timeout+0x16b/0x320
>     ? del_timer_sync+0x50/0x50
>     ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
>     ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
>     ? remove_wait_queue+0x60/0x60
>     ? sst_prepare_and_post_msg+0x275/0x960 [snd_intel_sst_core]
>     ? sst_pause_stream+0x9b/0x110 [snd_intel_sst_core]
>     ....
>
> This patch addresses these appropriately, too.
>
> Cc: <stable@vger.kernel.org> # v4.1+
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 4 ++--
>   sound/soc/intel/boards/bytcr_rt5651.c | 2 --
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 5c7219fb3aa8..9e2a3404a836 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -621,7 +621,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
>   		.codec_dai_name = "snd-soc-dummy-dai",
>   		.codec_name = "snd-soc-dummy",
>   		.platform_name = "sst-mfld-platform",
> -		.ignore_suspend = 1,
> +		.nonatomic = true,
>   		.dynamic = 1,
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
> @@ -634,7 +634,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
>   		.codec_dai_name = "snd-soc-dummy-dai",
>   		.codec_name = "snd-soc-dummy",
>   		.platform_name = "sst-mfld-platform",
> -		.ignore_suspend = 1,
>   		.nonatomic = true,
>   		.dynamic = 1,
>   		.dpcm_playback = 1,
> @@ -661,6 +660,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
>   						| SND_SOC_DAIFMT_CBS_CFS,
>   		.be_hw_params_fixup = byt_rt5640_codec_fixup,
>   		.ignore_suspend = 1,
> +		.nonatomic = true,
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
>   		.init = byt_rt5640_init,
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 3186f015939f..8164bec63bf1 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -235,7 +235,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
>   		.codec_dai_name = "snd-soc-dummy-dai",
>   		.codec_name = "snd-soc-dummy",
>   		.platform_name = "sst-mfld-platform",
> -		.ignore_suspend = 1,
>   		.nonatomic = true,
>   		.dynamic = 1,
>   		.dpcm_playback = 1,
> @@ -249,7 +248,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
>   		.codec_dai_name = "snd-soc-dummy-dai",
>   		.codec_name = "snd-soc-dummy",
>   		.platform_name = "sst-mfld-platform",
> -		.ignore_suspend = 1,
>   		.nonatomic = true,
>   		.dynamic = 1,
>   		.dpcm_playback = 1,

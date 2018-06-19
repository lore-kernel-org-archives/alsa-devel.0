From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: kbl_da7219_max98357a: add
 fe_ops for kbl Audio Capture Port
Date: Tue, 19 Jun 2018 09:41:59 -0500
Message-ID: <912e7c2c-9b6a-d764-2096-9df54f8d6bfc@linux.intel.com>
References: <1529388966-5184-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BFC6F2675D5
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 16:42:15 +0200 (CEST)
In-Reply-To: <1529388966-5184-1-git-send-email-mac.chiang@intel.com>
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
To: mac.chiang@intel.com, alsa-devel@alsa-project.org
Cc: naveen.m@intel.com, broonie@kernel.org, louiscollard@google.com
List-Id: alsa-devel@alsa-project.org

On 6/19/18 1:16 AM, mac.chiang@intel.com wrote:
> From: Mac Chiang <mac.chiang@intel.com>
> 
> platform support fixed constraint hw_prams as Stereo, 48KHz, 16 bits.
> This fixed the headset mic recorded noise due to mono capturing
> request from some apps. e.g. online Voice Recorder

This change mirrors existing code in bxt_da7219_max98357a.c so

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Louis Collard <louiscollard@google.com>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> ---
>   sound/soc/intel/boards/kbl_da7219_max98357a.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> index 94294c2..7961f1f 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> @@ -380,6 +380,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
>   		.trigger = {
>   			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
>   		.dpcm_capture = 1,
> +		.ops = &kabylake_da7219_fe_ops,
>   	},
>   	[KBL_DPCM_AUDIO_DMIC_CP] = {
>   		.name = "Kbl Audio DMIC cap",
> 

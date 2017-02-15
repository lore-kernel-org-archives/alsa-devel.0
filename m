From: Florian Kauer <florian.kauer@koalo.de>
Subject: Re: [PATCH v4] ASoC: bcm2835: Add 8 channel
	(multitrack) capability
Date: Wed, 15 Feb 2017 13:37:08 +0100
Message-ID: <88f46323-d243-e1af-c294-e1f844d366d0@koalo.de>
References: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
 <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A79B266B81
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 13:37:23 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id r18so8002325wmd.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 04:37:23 -0800 (PST)
In-Reply-To: <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>, alsa-devel@alsa-project.org, broonie@kernel.org, florian.meier@koalo.de, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, swarren@wwwdotorg.org, lee@kernel.org, phil@raspberrypi.org, eric@anholt.net, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 02/14/2017 10:04 PM, Matt Flax wrote:
> This patch adds multitrack capability if in DSP mode A and the
> codec is master.
> 
> In bcm2835_i2s_startup, snd_pcm_hw_constraint_single is used to set
> channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and SND_SOC_DAIFMT_DSP_A
> are set. Otherwise, channels are set to 2. These settings are
> accomplished using the SNDRV_PCM_HW_PARAM_CHANNELS variable.
> 
> In bcm2835_i2s_shutdown the channels are set to 2 by default.
> 
> In bcm2835_i2s_hw_params, DSP mode A format is now an option.
> Before replicating the format variable (from ch2 to ch1) for
> register loading, requested channels are checked to be either 2 or 8.
> This can be expanded later to accomodate other channel counts if
> supported by the sound card hardware.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---

Acked-by: Florian Kauer <florian.kauer@koalo.de>

Looks good and is a much better approach than just adding the additional
case.

Greetings,
Florian

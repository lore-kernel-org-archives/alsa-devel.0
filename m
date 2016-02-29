From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] ASoC: qcom: add dependency on HAS_DMA
Date: Mon, 29 Feb 2016 22:01:25 +0530
Message-ID: <56D4725D.1030001@gmail.com>
References: <1456755939-7848-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456755939-7848-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 29 February 2016 07:55 PM, Sudip Mukherjee wrote:
> m32r allmodconfig build is failing with the error:
> ERROR: "bad_dma_ops" [sound/soc/qcom/snd-soc-lpass-platform.ko] undefined!
> ERROR: "dma_common_mmap" [sound/soc/qcom/snd-soc-lpass-platform.ko] undefined!
>
> lpass-platform uses DMA so add HAS_DMA in the Kconfig. Also add the same
> for SND_SOC_LPASS_IPQ806X and SND_SOC_LPASS_APQ8016 as they will also
> select SND_SOC_LPASS_PLATFORM.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>
> m32r allmodconfig build for next-20160229 is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/112534168

Please discard this. It introduces new errors.
I will send v2 after more checking.

regards
sudip

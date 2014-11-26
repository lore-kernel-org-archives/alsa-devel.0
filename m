From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel][PATCH] ASoC: wm8960: LRCM operation should after
 software reset
Date: Wed, 26 Nov 2014 12:33:10 +0100
Message-ID: <5475BA76.8080809@metafoo.de>
References: <1416999740-21805-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416999740-21805-1-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <b50113@freescale.com>, broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/26/2014 12:02 PM, Zidan Wang wrote:
> When shared_lrclk is set, LRCM will be enabled. But the following software
> reset in wm8960_probe will reset it to the default state. So LRCM operation
> should after software reset.

It's probably a better idea to move the reset (together with the other 
register updates) to the I2C driver probe.

- Lars

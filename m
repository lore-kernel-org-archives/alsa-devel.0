From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: tlv320dac33: Add guarding parentheses to macros
Date: Thu, 29 Sep 2011 09:59:26 +0300
Message-ID: <3462016.6xldpjznMt@barack>
References: <1317269397.4561.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317269397.4561.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 29 September 2011 12:09:57 Axel Lin wrote:
> Put parentheses around macro argument uses. This avoids pitfalls
> for the programmer, where the argument expansion does not give the
> expected result, for example:
> 
> SAMPLES_TO_US(substream->runtime->rate, dac33->uthr - DAC33_MODE7_MARGIN +
> 1);

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

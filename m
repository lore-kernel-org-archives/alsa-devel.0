From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 3/4 v7] ASoC: dwc: Add PIO PCM extension
Date: Wed, 25 May 2016 11:49:12 +0100
Message-ID: <57458328.8080900@synopsys.com>
References: <cover.1463996627.git.joabreu@synopsys.com>
 <d81055d826825874c9d76922d2275688b2586fa6.1463996627.git.joabreu@synopsys.com>
 <20160524164151.GM8206@sirena.org.uk> <57448A42.9050606@synopsys.com>
 <20160524175144.GO8206@sirena.org.uk> <57457A63.5060702@synopsys.com>
 <20160525101801.GT8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525101801.GT8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,


On 25-05-2016 11:18, Mark Brown wrote:
> On Wed, May 25, 2016 at 11:11:47AM +0100, Jose Abreu wrote:
>
>> I think I will take the second option. Something like this:
>> "
>>     ret = snd_dmaengine_pcm_register(...)
>>     if (ret == -EPROBE_DEFER)
>>         return ret;
>>     else
>>         pio_register(...);
>> "?
> Sure.  You should print a diagnostic if you fail to get the DMA, for any
> real system it's going to be a bug.

Ok, will do that. I noticed the last I2S patch that you merged
("ASoC: dwc: Add helper functions to disable/enable irqs") is not
in for-next yet. Should I base my work on 'topic/dwc' branch?

Best regards,
Jose Miguel Abreu

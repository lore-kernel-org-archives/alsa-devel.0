From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH v2 1/3] ASoC: dwc: I2S Controller instance param added
Date: Wed, 18 Apr 2018 18:18:44 +0530
Message-ID: <a6a4cf79-b7f7-a565-28a8-6205f8d13936@amd.com>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524049494-19526-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20180418112442.GB10061@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418112442.GB10061@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Markus Elfring <elfring@users.sourceforge.net>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On Wednesday 18 April 2018 04:54 PM, Mark Brown wrote:
> On Wed, Apr 18, 2018 at 04:34:52PM +0530, Vijendar Mukunda wrote:
>> When multiple I2S controller instances created,
>> i2s_instance parameter refers to i2s controller instance value.
> 
> You're missing the point here a bit - it's not just the defines for the
> magic numbers that are the problem, it's the whole idea of passing
> instance numbers around like this that's the big problem.  Whatever you
> are trying to do here is most likely better accomplished at the machine
> driver level.  If I'm missing something here and this is a useful
> concept to have in the driver it really needs to be articulated much
> more clearly than in your very brief changelog, and most likely done at
> the subsystem level (though the fact that we've managed to get this far
> without needing it is a bit of a red flag).
> 

In Audio Coprocessor (ACP), There are three I2S controllers can be
configured/enabled.(I2S SP, I2S MICSP, BT I2S)
Default enabled I2S controller instance is I2S SP instance.
There is a requirement to enable BT I2S controller Instance along with
I2S SP controller instance in one of our platforms Which has multiple 
codecs connected to each instance.

AMD GPU ACP driver creates devices for Playback and capture devices for 
both the I2S Controller instances using MFD framework.
Designware driver probe call gets invoked for every device creation with
resource information and platform data provided by GPU driver.

We have added one more parameter i2s instance to dwc platform data.
So that AMDGPU ACP Driver will pass I2S controller instance value to dwc 
driver while creating device nodes for I2S Controllers.

In ACP DMA Driver  acp_dma_open () call, We are retrieving dwc 
controller dev data as mentioned below.
dw_i2s_dev *dev = snd_soc_dai_get_drvdata(prtd->cpu_dai);

 From dev->i2s_instance , ACP DMA Driver gets to know current I2S 
controller instance value.
We want to make ACP DMA driver platform independent one so that it will 
work across all platforms.

This is a generic implementation. Any platform which uses Designware I2S
controller can use this implementation when multiple I2S controller
instances are created.
This patch stores the I2S controller instance value in platform data.
Please suggest us, if there is any better way to handle it.

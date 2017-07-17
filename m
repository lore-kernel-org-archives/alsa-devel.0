From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/3] ASoC: codecs: msm8916-wcd-digital: fix dmic support
Date: Mon, 17 Jul 2017 15:52:09 +0100
Message-ID: <24fe9c00-6254-5e6d-472f-6b4186044b68@linaro.org>
References: <20170717135410.26812-1-srinivas.kandagatla@linaro.org>
 <20170717135410.26812-4-srinivas.kandagatla@linaro.org>
 <20170717144528.dj7kovmssggnbhx4@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717144528.dj7kovmssggnbhx4@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 17/07/17 15:45, Mark Brown wrote:
> On Mon, Jul 17, 2017 at 03:54:10PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch fixes dmic support which was broken in this driver.
> 
> In what way is DMIC support broken and how does this patch fix it?
> 
The driver was not selecting DMIC in CIC filter source path.
Which is why dmic was not functional from the beginning.

--srini

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 08/14] ASoC: qcom: add dma channel control offset
 to variant data
Date: Tue, 05 May 2015 08:16:56 +0100
Message-ID: <55486E68.7020304@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <1430414252-11210-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235909.GD27804@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150502235909.GD27804@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 03/05/15 00:59, Kenneth Westfield wrote:
> On Thu, Apr 30, 2015 at 06:17:32PM +0100, Srinivas Kandagatla wrote:
>> This patch adds ability to pass dma channel control bits start offset, which
>> differ in differnet qcom SOCs. On apq8016 dma channel control bits start
>> after an offset of 1.
>
> Alot of the SOCs have similar small differences in the LPASS register
> map.  For now, this is fine, but we will probably want to add some
> system of quirks to handle these differences; as more SOCs drivers
> are implemented.
>
Yes, I agree, only reason for adding it in to variant data could be that 
I was looking at drivers/mmc/host/mmmci.c file a lot :-)

--srini

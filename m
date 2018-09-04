From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 2/4] ASoC: tlv320aic31xx: Add overflow
	detection support
Date: Tue, 4 Sep 2018 09:38:24 -0500
Message-ID: <274b9d82-542b-dbf7-94e2-a61bc6eb2bbc@ti.com>
References: <20180831182434.14499-1-afd@ti.com>
 <20180831182434.14499-2-afd@ti.com> <20180903130318.GH10302@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 44B542678DD
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 16:38:27 +0200 (CEST)
In-Reply-To: <20180903130318.GH10302@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/03/2018 08:03 AM, Mark Brown wrote:
> On Fri, Aug 31, 2018 at 01:24:32PM -0500, Andrew F. Davis wrote:
>> Similar to short circuit detection, when the ADC/DAC is saturated and
>> overflows poor audio quality can result and should be reported to the
>> user. This device support Automatic Dynamic Range Compression (DRC)
>> to reduce this but it is not enabled currently in this driver.
> 
>> +	if (value & AIC31XX_DAC_OF_LEFT)
>> +		dev_err(dev, "Left-channel DAC overflow has occurred\n");
>> +	if (value & AIC31XX_DAC_OF_RIGHT)
>> +		dev_err(dev, "Right-channel DAC overflow has occurred\n");
> 
> So, this will sound terrible but I'm not sure that unconditionally
> shouting in the logs is the right thing to do here - people do sometimes
> put non-audio signals through sound cards (using them as generic DACs
> and ADCs) and it seems like it could get very spammy.  Perhaps a lower
> level warning message, some counters or even some control that allows
> the warnings to be masked.
> 

As these events do not stop the function of the sound card, I agree
warnings would be more appropriate than errors, I'll make that change.

Andrew

From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Fri, 8 Nov 2013 09:52:16 +0800
Message-ID: <527C43D0.2030301@marvell.com>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
 <20131106112421.GI11602@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B6CBA261735
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 02:52:27 +0100 (CET)
In-Reply-To: <20131106112421.GI11602@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 11/06/2013 07:24 PM, Mark Brown wrote:
> On Tue, Nov 05, 2013 at 04:30:08PM +0800, Qiao Zhou wrote:
>> add TISSP mode support. with this mode enabled, ssp controller
>> works in TI-ssp protocol automatically and doesn't need to
>> configure sspsp register to set the timing for tx/rx.
>
> What is TISSP mode in an audio context?
It's normal SSP mode, and it has a pulse of one bit clock width, which 
is the frame start signal. previously it's mainly used for voice call 
which is mono stream. current I2S or DSP_x format use PSP, which 
configures the details of transmit/receive timing. we can also use PSP 
to suit this SSP format. But since the SSP controller provides such HW 
convenience, so we want to add it. I'm not sure it's proper, and want to 
ask for suggestions.
>
>> +	/*
>> +	 * add TISSP protocol support. setting to this mode, ssp controller
>> +	 * works in TI-ssp mode, and need not set psp register to conf
>> +	 * detailed timing.
>> +	 */
>> +	case SND_SOC_DAIFMT_SSP:
>> +		sscr0 |= SSCR0_TISSP;
>> +		sscr1 |= SSCR1_RWOT;
>>
>>   	default:
>>   		return -EINVAL;
>
> I don't think this code has been tested...
sorry for missing the "break", will update it. I want to ask suggestions 
about the logic of this piece of code from mainline and we do test the 
code logic on our platform.
>
-- 

Best Regards
Qiao

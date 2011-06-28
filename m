From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Mixer control for signed gain value
Date: Tue, 28 Jun 2011 09:21:31 -0700
Message-ID: <4E09FF8B.4090103@codeaurora.org>
References: <4E02DDF3.2070509@codeaurora.org>
	<20110623103757.GC21932@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id B5EEC10388E
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 18:21:51 +0200 (CEST)
In-Reply-To: <20110623103757.GC21932@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 6/23/2011 3:37 AM, Mark Brown wrote:
> On Wed, Jun 22, 2011 at 11:32:19PM -0700, Patrick Lai wrote:
>
>> The CODEC I am working with takes byte-long gain value in two's
>> complement form.
>> In soc-core.c, the closest functions I see are
>>   snd_soc_info_volsw_s8
>> snd_soc_get_volsw_s8
>> snd_soc_set_volsw_s8
>
>> These functions are coded to work with two integer values. For my
>> purpose, I suppose that I can always set 2nd integer input as zero.
>> However, would I still be able to set volume like
>> amixer sset "Codec Gain" 100 as percentage. If yes, how will amixer
>> know to put upper 8 bits of 16 bit gain in 2nd integer value element?
>
> Could you clarify what the control you're dealing with is?  You say
> above that your gains are byte long but here you're talking about them
> actually being 16 bit.  If they're 16 bit you probably need to write a
> new control type.

Yes, CODEC in question takes byte-long signed gain value and would like
to reuse snd_soc_xxx_volsw_xx mixer callback functions in soc-core.c.
The only functions I see handle signed value are
snd_soc_info_volsw_s8, snd_soc_get_volsw_s8, snd_soc_get_volsw_s8
Unless I am mistaken, these functions deal with two signed byte-long
values which get concatenated into 16-bit value. Perhaps, original
purpose is to set left and right 8-bit gain values at the same time on
a single codec register which takes 16-bit value.
So, my question is whether I should reuse volsw_s8 mixer control
functions and have mixer application ignore integer.value[1] to suit my
purpose or redefine new set of mixer control functions i.e
snd_soc_set_volsw_single_s8. Otherwise, is there existing alternative
to handle set/put byte-long signed value?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

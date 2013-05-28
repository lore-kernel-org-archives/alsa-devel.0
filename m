From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: "Negative" volume settings in a kcontrol
Date: Tue, 28 May 2013 13:46:15 +0200
Message-ID: <51A49907.70105@topic.nl>
References: <51824609.30405@canonical.com> <1367498241.8766.3.camel@localhost>
 <5182746C.1070603@topic.nl> <5187AEA5.1020108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob07.myregisteredsite.com
 (atl4mhob07.myregisteredsite.com [209.17.115.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E7002608EB
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 13:46:17 +0200 (CEST)
Received: from mail.hostingplatform.com ([10.30.71.204])
 by atl4mhob07.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r4SBkGXR017041
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 07:46:16 -0400
In-Reply-To: <5187AEA5.1020108@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/06/2013 03:22 PM, Clemens Ladisch wrote:
> Mike Looijmans wrote:
>> Some codec registers need negative values. For example,
>> sound/soc/codecs/tlv320aic32x4.c specifies this:
>>
>>   78         SOC_DOUBLE_R_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
>>   79                         AIC32X4_RDACVOL, 0, 0x30, 0, tlv_step_0_5),
>>
>> It's incomplete. The actual range is from -63.5dB to +24dB in 0.5 dB steps.
>> The 8-bit value is interpreted as a signed 8-bit integer, so to get -3dB
>> the register value must be -6 or 0xFA.
>>
>> How do I explain that to Alsa?
>
> There are some ASoC helper macros that handle signed register fields, such
> as SOC_DOUBLE_S8_TLV and SOC_SINGLE_XR_SX.  If those don't do what you want,
> you have to write your own.

SOC_DOUBLE_S8_TLV seems to be a misnamed hardware-specific macro. It 
provides no way to specify the location of the left/right bits so the 
macro name is misleading.

SOC_SINGLE_XR_SX is too new for my kernel. And from what I gather, I 
cannot use it anyway for my purposes. So the solution turns out to be 
"write my own". The SOC_DOUBLE_S8_TLV macro did provide a very nice 
starting point though.

Thanks for the pointer though, it turned out to be the key to a solution.

>> (and on a side note "amixer" doesn't accept negative values either)
>
> A workaround would be to set the control value first to 0 and then to
> the desired negative value ... but this bug needs fixing.

I have no idea what you meant here.

Kind regards,
Mike.

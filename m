From: "Jesslyn Abdul Salam" <jesslyn.abdulsalam@gmail.com>
Subject: Re: AIC23 SOC Driver on OSK5912
Date: Tue, 7 Oct 2008 19:20:45 +0530
Message-ID: <e762f7a90810070650q642aa05eu1f909e7898042ee6@mail.gmail.com>
References: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
	<20081007115450.GD19835@sirena.org.uk>
	<dfeb90390810070502x42ec3d85heb87f21d5c3074ec@mail.gmail.com>
	<e762f7a90810070506q2d4e299eqe2d6d9bc515aeec0@mail.gmail.com>
	<e762f7a90810070506x9c26ecfh6fa68a833c2ae98b@mail.gmail.com>
	<e762f7a90810070518r22dfa404s3f34f3ade79db7bf@mail.gmail.com>
	<48EB6820.3090809@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id 6FBC6245BC
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 15:51:00 +0200 (CEST)
Received: by gxk10 with SMTP id 10so6900617gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2008 06:50:46 -0700 (PDT)
In-Reply-To: <48EB6820.3090809@mistralsolutions.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Not yet. Would please share what you have done to make it work ? Also when I
tried to strace aplay , it keeps looking for a
</share/alsa/cards/tlv320aic23.conf> file which is not there in the alsa-lib
package. Any idea what goes in that file ?

Regards

Jesslyn

On Tue, Oct 7, 2008 at 7:16 PM, Arun KS <arunks@mistralsolutions.com> wrote:

> Jesslyn Abdul Salam wrote:
>
>> I got it working. I2C_BOARD_INFO macro was wrongly intialized. Instead of
>> tlv320aic23 i had written tlvaic23. Thanks to Arun for pointing this error
>>
>>
> Can you hear audio playing?
> Because i had done some hack to make it working in 5912osk.
> I want to know you are not facing it or not.
>
> Arun
>
>  Jesslyn Abdul Salam
>>
>>
>> On Tue, Oct 7, 2008 at 5:36 PM, Jesslyn Abdul Salam <
>> jesslyn.abdulsalam@gmail.com> wrote:
>>
>>
>>
>>> ---------- Forwarded message ----------
>>> From: Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
>>> Date: Tue, Oct 7, 2008 at 5:36 PM
>>> Subject: Re: [alsa-devel] AIC23 SOC Driver on OSK5912
>>> To: Arun KS <arunks@mistralsolutions.com>
>>>
>>>
>>> Yes, it is there. but it shows as "tlv320aic23b" instead of "tlv320aic"
>>> Will that be the reason ????
>>>
>>>
>>>
>>>
>>> On Tue, Oct 7, 2008 at 5:32 PM, Arun KS <arunks@mistralsolutions.com
>>> >wrote:
>>>
>>>
>>>
>>>> On Tue, Oct 7, 2008 at 5:24 PM, Mark Brown <broonie@sirena.org.uk>
>>>> wrote:
>>>>
>>>>
>>>>> On Tue, Oct 07, 2008 at 05:18:55PM +0530, Jesslyn Abdul Salam wrote:
>>>>>
>>>>>
>>>>>
>>>>>> I have been trying to use the AIC23 ALSA SoC driver for OSK5912 for
>>>>>> the
>>>>>>
>>>>>>
>>>>> past
>>>>
>>>>
>>>>> few days. I got the driver patch from the linux-omap/alsa-devel mailing
>>>>>> lists. The driver got compiled along just fine. But when the kernel
>>>>>>
>>>>>>
>>>>> boots,
>>>>
>>>>
>>>>> no sound cards have been listed.
>>>>>>
>>>>>>
>>>>> CCing in Arun KS <arunks@mistralsolutions.com> who contributed that
>>>>> support.
>>>>>
>>>>>
>>>>>
>>>>>> Advanced Linux Sound Architecture Driver Version 1.0.17.
>>>>>>          ASoC version
>>>>>> 0.13.2
>>>>>> AIC23 Audio Codec
>>>>>> 0.1
>>>>>> MCLK = 12000000 [12000000], usecount =
>>>>>> 0
>>>>>> ALSA device
>>>>>> list:
>>>>>>    No soundcards
>>>>>> found.
>>>>>>          Any one have tested this before ?
>>>>>>
>>>>>>
>>>>> Can you check i2c?
>>>>
>>>> # cat /sys/bus/i2c/devices/1-001b/name
>>>> tlv320aic23
>>>>
>>>>
>>>>
>>>>> _______________________________________________
>>>>> Alsa-devel mailing list
>>>>> Alsa-devel@alsa-project.org
>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
>>
>>
>
>
> Please do not print this email unless it is absolutely necessary. Spread
> environmental awareness.
>
>
> -------------------------------------------------------DISCLAIMER------------------------------------------------------
> The information transmitted herewith is confidential and proprietary
> information intended only for use by the individual or entity to which it is
> addressed. If the reader of this message is not the intended recipient, you
> are hereby notified that any review, retransmission, dissemination,
> distribution, copying or other use of, or taking of any action in reliance
> upon this information is strictly prohibited. If you have received this
> communication in error, please contact the sender and delete the material
> from your computer.
>
> --------------------------------------------------------------------------------------------------------------------------------
>
>
>
>

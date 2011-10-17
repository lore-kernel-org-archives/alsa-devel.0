From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: Re: DM365 McBSP as Master
Date: Mon, 17 Oct 2011 17:59:03 +0530
Message-ID: <CAODvfaHtaNp=9stMC8LduRsKwpGTwQ-3R4=yKoRodzVBABEXPA@mail.gmail.com>
References: <CAODvfaF4f0ZrPQdR1CiFBp5=WZAkj9fQnjNPgdY15c0wYW-fkA@mail.gmail.com>
	<4E78A059.4010300@mentor.com>
	<CAODvfaG=uSC0J6-q+Cd6cb4Sfb1gNRoYE2UCAziKmtVKa2_qeQ@mail.gmail.com>
	<CAODvfaEEwdPbZGz91H-F080nfPh33r8Y16aCoB83SeghaMGqbA@mail.gmail.com>
	<4E7C3039.1090203@mentor.com>
	<CAODvfaEMx+Jz0dYbUcPsyJ6JWKXi-_wmbXC=MsC11Jv+PUuJ1g@mail.gmail.com>
	<4E9BF5A0.5090203@mentor.com>
	<CAODvfaFCDuQWGNKHuNWNSOU3d4vcwj-7WquA9xfuCCk1dOYQ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8DF6224411
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 14:29:04 +0200 (CEST)
Received: by yws29 with SMTP id 29so1885548yws.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2011 05:29:03 -0700 (PDT)
In-Reply-To: <CAODvfaFCDuQWGNKHuNWNSOU3d4vcwj-7WquA9xfuCCk1dOYQ7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vladimir Barinov <Vladimir_Barinov@mentor.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Vladimir,

error log is as shown below.

root@dm368-evm:/# ./myoss
Audio Driver failed to open, oss_fd = -1 errno = 22

-Sreedhar.

On 10/17/11, Appalayagari Sreedhar <sreecha01@gmail.com> wrote:
> Hi Vladimir,
>
> Thank you very much. i will do the same.
> on further probing and testing.
>
> i found that if i open the device O_WRONLY and O_RDONLY mode it works.
> if i try to open the device using the O_RDWR mode it fails.
>
> is there any configuration settings i need to check.
>
> -Sreedhar.
>
> On 10/17/11, Vladimir Barinov <Vladimir_Barinov@mentor.com> wrote:
>> Hi Sreedhar,
>>
>> You should always CC the alsa-devel channel list for any alsa related
>> questions instead of writing directly to TI support and me. But you can
>> CC both me and TI people.
>> In that case your questions will not go unanswered.
>>
>>
>> Appalayagari Sreedhar wrote:
>>> Hi Vladimir,
>>>
>>> I need your help to solve one issue.
>>>
>>> I have developed a audio driver in ALSA model, the audio ic is
>>> interfaced with the TI DM365 processor MCBSP ports. I am working with
>>> the 2.6.32 kernel.
>>>
>>> I am able to play the audio using the aplay command.  but when i try
>>> to open the device using /dev/dsp i am getting the -ve value. it fails
>>> to open the device.
>>>
>> I believe that you've enabled OSS emulation for alsa drivers:
>> CONFIG_SND_PCM_OSS=y
>> and read carefully Documentation/sound/alsa/OSS-Emulation.txt guide.
>>
>> Here you didn't mention how you are trying to open /dev/dsp and the
>> error log sample.
>> If you'll read the mentioned guide then you'll find some hints about PCM
>> mode changes via proc interface. Probably that will shine some light on
>> your issue.
>>
>>> when i check the
>>>
>>>
>>>>> ls /dev/dsp
>>>>>
>>>
>>> it is available in the device directory.
>>>
>>> I have enabled the Sound OSS related options in the kernel menuconfig.
>>> with the same options i am able to open the device for the tlv320aic3x
>>> device.
>>>
>>> Could you please suggest where i am doing wrong? and help to solve
>>> this problem.
>>>
>>> One more observation :
>>>
>>> after doing aplay i am able to open the device using the /dev/dsp.
>>>
>>> if try to open the device using the /dev/dsp before aplay i am getting
>>> the error.
>>>
>>> could you please tell me where i am doing.
>>>
>> It seems that aplay configures the codec and mcbsp interface calling
>> it's TRIGGER_START but your own application does not. Once configured
>> the pcm streams can pass normally using /dev/dsp. Not usre but seems
>> that the problem in inability to call TRIGGER.
>>
>> Regards,
>> Vladimir
>>> I have posted the queries in ti e2e website, please check them below.
>>> i did not receive any proper response till now so i am contacting you.
>>>
>>> http://e2e.ti.com/support/embedded/f/354/p/138037/504805.aspx
>>>
>>> Thank you in advance.
>>> Sreedhar.
>>>
>>> On 9/23/11, Vladimir Barinov <Vladimir_Barinov@mentor.com> wrote:
>>>
>>>> Hi Sreedhar,
>>>>
>>>> Appalayagari Sreedhar wrote:
>>>>
>>>>> Hi Vladimir Barinov,
>>>>>
>>>>> Now I am able to make it work McBSP as master and also as slave.
>>>>> We decided to configure the McBSP as Slave and Codec as Master.
>>>>>
>>>>> I have one question, Since the Clocks are generated by the Codec.
>>>>> will there be any Channel Swap in the audio?
>>>>>
>>>>> If so how to handle this channel swap mechanism.
>>>>>
>>>>>
>>>> Yes, It possible to get channels swap on any external codec.
>>>> Unfortunately I don't know any strong method for this issue. I just
>>>> experience similar problem on TI's PMIC audio and get rid from  EVERY
>>>> excessive clock in system to be able to fix it. I mean you have to stop
>>>> all related clocks in proper sequence during audio pause/stop. When I
>>>> did it the channel swap was fixed.
>>>>
>>>> Regards,
>>>> Vladimir
>>>>
>>>>> Thank you,
>>>>> Sreedhar.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> On 9/20/11, Appalayagari Sreedhar <sreecha01@gmail.com> wrote:
>>>>>
>>>>>
>>>>>> Hi Vladimir Barinov,
>>>>>>
>>>>>> Thank you very much.  I will check as you suggested.
>>>>>> Thanks once again you are only person from whom i got the support
>>>>>> since
>>>>>> 5
>>>>>> days.
>>>>>>
>>>>>> Thanks once again.
>>>>>>
>>>>>> Thank you,
>>>>>> Sreedhar.
>>>>>>
>>>>>> On 9/20/11, Vladimir Barinov <Vladimir_Barinov@mentor.com> wrote:
>>>>>>
>>>>>>
>>>>>>> Sreedhar,
>>>>>>>
>>>>>>> 1) verify that mux registers are configured properly
>>>>>>> 2) startup with codec as master since the current code tested in
>>>>>>> this
>>>>>>> mode and usually msbsp can't provide variety of clocks to match all
>>>>>>> samplerates.
>>>>>>> 3) check that you can read/write codec registers with success (i2c
>>>>>>> works
>>>>>>> find and the codec is not in reset state - check your h/w)
>>>>>>> Probe MCLK by scope and find that signal is ON, otherwise you didn't
>>>>>>> make codec setup (i2c communication or codec doesn't work)
>>>>>>>
>>>>>>> After above you can start moving to MCBSP  as master if you really
>>>>>>> need
>>>>>>> it.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Vladimir
>>>>>>>
>>>>>>> Appalayagari Sreedhar wrote:
>>>>>>>
>>>>>>>
>>>>>>>> Hi Vladimir Barinov,
>>>>>>>>
>>>>>>>> I am working with DM365 evm board.  I have interfaced conexant
>>>>>>>> audio
>>>>>>>> ic to the McBSP.
>>>>>>>>
>>>>>>>> I need to do I2S data transfer. I need to program the McBSP as
>>>>>>>> master
>>>>>>>> and conexant audio IC as slave.
>>>>>>>>
>>>>>>>> i did the macro changes in the davinci-evm.c file in AUDIO_FORMAT
>>>>>>>> like
>>>>>>>> this.
>>>>>>>>
>>>>>>>> #define AUDIO_FORMAT (SND_SOC_DAIFMT_I2S | \
>>>>>>>>                 SND_SOC_DAIFMT_CBS_CFS)
>>>>>>>>
>>>>>>>> I am using the McBSP internal clock for McBSP. I printed the McBSP
>>>>>>>> registers and found that SCLKME - 0 and CLKSM - 1.  by reading the
>>>>>>>> registers.
>>>>>>>>
>>>>>>>> when i run the aplay command i am not viewing any clocks when i
>>>>>>>> probe
>>>>>>>> the signals using the CRO.
>>>>>>>>
>>>>>>>> Could you please tell me where i am doing wrong?
>>>>>>>>
>>>>>>>> Please find my queries in the following thread in the ti e2e
>>>>>>>> comminity.
>>>>>>>>
>>>>>>>> http://e2e.ti.com/support/embedded/f/354/p/134788/485628.aspx#485628
>>>>>>>>
>>>>>>>> Thank you, Sreedhar.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>
>>
>>
>

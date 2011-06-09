From: Liam Girdwood <lrg@ti.com>
Subject: Re: asoc: no valid backend routes for PCM: SDP4430
	Media
Date: Thu, 9 Jun 2011 10:42:10 +0100
Message-ID: <4DF09572.6070900@ti.com>
References: <537926.35497.qm@web161718.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D0C02413F
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 11:42:16 +0200 (CEST)
In-Reply-To: <537926.35497.qm@web161718.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hong zhang <henryzhang62@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Henry,

On 08/06/11 20:08, hong zhang wrote:
> Liam,
> 
> I have downloaded kernel tar ball. Three questions need your help.
> 
> 1. which defconfig should be used in arch/arm/configs?
>    I do not see OMAP4 for SDP4430 (blaze board). Panda does not have DMIC 
>    only blaze has it.
> 

There is an omap2plus defconfig.

> 2. On blaze board, I have to turn off two analog captures and leave DMIC open. Can you verify my gst-launch is correct? I cannot capture voice from DMIC on OMAP4 blaze board us it.
> 
>    gst-launch-0.10 -v alsasrc num-buffers=1000 ! 'audio/x-raw-int,rate=8000,channels=1,endianness=1234,width=16,depth=16' ! audioconvert ! wavenc! filesink location=/home/normanc/Desktop/8000.wav
> 
> 3. If I specify DMIC device, command is rejected.
> 
> gst-launch-0.10 -v alsasrc device="hw:0,10" num-buffers=1000 ! 'audio/x-raw-int, rate=8000,channels=1,endianness=1234,width=16,depth=16' ! audioconvert ! wavenc! filesink location=/home/normanc/Desktop/8000.wav
> 

The easiest thing todo first is to get arecord working. Use hw:0,1 for DMIC and make sure you use alsamixer to configure the correct audio paths for DMIC to hw:0,1.

> TI support team in France says item 2 should work for DMIC. But I simply could not get it. TI team says item 2 works for "official release 2.6.35-990-omap4 #9".
> 
> I have spent 1 week on it with 2.6.35-990-omap4 #9
> 
> Please advise!
> 

It does look like you have not configured the audio route here for the DMIC to hw:0,1. Use the ABE diagram to create your route with alsamixer.

Liam

> Thanks.
> 
> ---henry
> 
> --- On Wed, 6/8/11, Liam Girdwood <lrg@ti.com> wrote:
> 
>> From: Liam Girdwood <lrg@ti.com>
>> Subject: Re: [alsa-devel] asoc: no valid backend routes for PCM: SDP4430 Media
>> To: "hong zhang" <henryzhang62@yahoo.com>
>> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
>> Date: Wednesday, June 8, 2011, 9:22 AM
>> On 07/06/11 20:59, hong zhang wrote:
>>> Liam,
>>>
>>> Actually, I could not prove DMIC on OMAP4 blaze board
>> is working in both kernel 2.6.35 and 2.6.38 using arecord
>> and gstreamer-alsa.
>>>
>>> In 2.6.35, arecord returns 44 bytes with read error
>>> In 2.6.38, arecord collects native data.
>>>
>>> Gstreamer-alsa could not get voice after turning off
>> analog captures using amixer. 
>>>
>>> Any information regarding DMIC on OMAP4? I see people
>> send DMIC patch to 2.6.38.
>>>
>>
>> DMIC works on OMAP4, can you try my branch :-
>>
>> https://gitorious.org/omap-audio/linux-audio/commits/lrg/topic/omap-asoc-next-3.1
>>
>> Liam
>>
>>

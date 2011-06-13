From: Patrick Lai <plai@codeaurora.org>
Subject: Re: soc-dsp questions
Date: Sun, 12 Jun 2011 21:55:08 -0700
Message-ID: <4DF5982C.6070705@codeaurora.org>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>
	<1303810865.3332.57.camel@odin>
	<20110426101848.GA23812@sirena.org.uk>
	<4DF1C08F.90306@codeaurora.org>
	<20110610094226.GA26436@opensource.wolfsonmicro.com>
	<4DF2C2BD.6050505@codeaurora.org>
	<20110611114806.GD2738@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 6367E1037FC
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 06:55:11 +0200 (CEST)
In-Reply-To: <20110611114806.GD2738@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, waiw@codeaurora.org, pl bossart <bossart.nospam@gmail.com>, asishb@codeaurora.org, jaywang@codeaurora.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

>> Are you referring to fixup function in the machine driver? It works for
>> hardware parameter that is fixed per machine. For example, regardless
>> sample rate of front-ends that are routed to same back-end,
>> back-end sample rate is fixed to 48KHz. I am already taking advantage
>> of the hook.
>
> Yes.  Since it's code it *could* do conditional things based on some
> setting if it needs to.
>
Yes, I don't see any better way unless propagating knowledge of 
front-end/back-end all the way to user-space. I plan on adding 
enumeration of
channel mode in machine driver which sets variable read by the fix up
function. So, CPU and CODEC drivers do not need to provide enumeration
of channel modes. However, same control would have to be added to every
machine driver.

>> Another query I have is how to handle back-end error. The audio bus
>> which is running on my machine requires close coordination between CPU
>> and CODEC. Essentially, if one side is unable to respond to incoming
>> data in time, data exchange halts. I am looking for way to reset both
>> CPU and CODEC back to fresh state. One approach I am thinking is to
>> generate XRUN error(snd_pcm_stop(SNDRV_PCM_STATE_XRUN) and have
>> application call prepare() to reset CPU and CODEC back to good state.
>> I see each back-end is registered as PCM device so it's possible that
>> application can read /dev/snd/timer to get notified. However, do I call
>> prepare() on one of FE PCM devices that are routed to the back end in
>> question? Would this approach work? Any suggestion?
>
> I'd expect that from an application point of view this will just work
> already?  The application will just operate on the PCM it's operating on
> and will notice a stall in the same way it does for any other device
> then the front/back end machinery will connect everything up in the same
> way it does for every operation when (if!) the application tries to
> recover.

Yes, I suppose existing mechanism would work if the front-end PCM is not 
hostless. Eventually, underrun/overrun would be detected. If front-end 
PCM is hostless, host processor for my case would not even know that 
Front-end is stalled even though back-end knows. I suppose
we could enhance framework to propagate XRUN error from back-end to 
front-end and have front end generate XRUN signal back to user-space. 
However, for multiple Front-end to same back end case, all clients of 
front-end PCM get notified of XRUN error and all of them call prepare(). 
I can see there can be adverse effect with such behavior.
Maybe it's easier to recover under the hood without user-space knowing it.

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

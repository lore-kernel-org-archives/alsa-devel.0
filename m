From: Patrick Lai <plai@codeaurora.org>
Subject: Re: soc-dsp questions
Date: Fri, 10 Jun 2011 18:19:57 -0700
Message-ID: <4DF2C2BD.6050505@codeaurora.org>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>
	<1303810865.3332.57.camel@odin>
	<20110426101848.GA23812@sirena.org.uk>
	<4DF1C08F.90306@codeaurora.org>
	<20110610094226.GA26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id ABD39103806
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Jun 2011 03:20:01 +0200 (CEST)
In-Reply-To: <20110610094226.GA26436@opensource.wolfsonmicro.com>
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

On 6/10/2011 2:42 AM, Mark Brown wrote:

>
> That might be handlable by either of the methods I was suggesting above.
> Of course depending on the algorithms you're running the DSP may want
> more mics than it's producing output channels - beam forming or noise
> cancellation are the obvious examples there.

Yes, exactly.

> Do you mean not also a concern?  I *believe* OMAP is passing the
> configuration through to the external DAI using the front end/back end
> connection so the format gets selected by the app when it does a record,

Can you elaborate more on "configuration through external DAI" ?
Is there an example?

> possibly with rewriting through the hook functions in the machine driver.

Are you referring to fixup function in the machine driver? It works for
hardware parameter that is fixed per machine. For example, regardless
sample rate of front-ends that are routed to same back-end,
back-end sample rate is fixed to 48KHz. I am already taking advantage
of the hook.

Another query I have is how to handle back-end error. The audio bus
which is running on my machine requires close coordination between CPU
and CODEC. Essentially, if one side is unable to respond to incoming
data in time, data exchange halts. I am looking for way to reset both
CPU and CODEC back to fresh state. One approach I am thinking is to
generate XRUN error(snd_pcm_stop(SNDRV_PCM_STATE_XRUN) and have
application call prepare() to reset CPU and CODEC back to good state.
I see each back-end is registered as PCM device so it's possible that
application can read /dev/snd/timer to get notified. However, do I call
prepare() on one of FE PCM devices that are routed to the back end in
question? Would this approach work? Any suggestion?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

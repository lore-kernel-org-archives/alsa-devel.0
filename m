From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp questions
Date: Mon, 13 Jun 2011 18:55:00 +0100
Message-ID: <4DF64EF4.7050903@ti.com>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>	<1303810865.3332.57.camel@odin>	<20110426101848.GA23812@sirena.org.uk>	<4DF1C08F.90306@codeaurora.org>	<20110610094226.GA26436@opensource.wolfsonmicro.com>	<4DF2C2BD.6050505@codeaurora.org>
	<20110611114806.GD2738@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id C57CB243A3
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 19:55:07 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Patrick Lai <plai@codeaurora.org>, "waiw@codeaurora.org" <waiw@codeaurora.org>, pl bossart <bossart.nospam@gmail.com>, "asishb@codeaurora.org" <asishb@codeaurora.org>, "jaywang@codeaurora.org" <jaywang@codeaurora.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 11/06/11 12:48, Mark Brown wrote:
> On Fri, Jun 10, 2011 at 06:19:57PM -0700, Patrick Lai wrote:

> 
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

This is how it works on OMAP4. 

The ABE handles and recovers most BE errors internally and can also interrupt the CPU for serious errors (to signal XRUNs etc).

Liam

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp questions
Date: Sat, 11 Jun 2011 12:48:07 +0100
Message-ID: <20110611114806.GD2738@opensource.wolfsonmicro.com>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>
	<1303810865.3332.57.camel@odin>
	<20110426101848.GA23812@sirena.org.uk>
	<4DF1C08F.90306@codeaurora.org>
	<20110610094226.GA26436@opensource.wolfsonmicro.com>
	<4DF2C2BD.6050505@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A21F224152
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Jun 2011 13:48:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DF2C2BD.6050505@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, waiw@codeaurora.org, pl bossart <bossart.nospam@gmail.com>, asishb@codeaurora.org, jaywang@codeaurora.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 06:19:57PM -0700, Patrick Lai wrote:
> On 6/10/2011 2:42 AM, Mark Brown wrote:

> >Do you mean not also a concern?  I *believe* OMAP is passing the
> >configuration through to the external DAI using the front end/back end
> >connection so the format gets selected by the app when it does a record,

> Can you elaborate more on "configuration through external DAI" ?
> Is there an example?

That's the whole soc-dsp front end/back end connection thing so the OMAP
drivers should provide an example.

> >possibly with rewriting through the hook functions in the machine driver.

> Are you referring to fixup function in the machine driver? It works for
> hardware parameter that is fixed per machine. For example, regardless
> sample rate of front-ends that are routed to same back-end,
> back-end sample rate is fixed to 48KHz. I am already taking advantage
> of the hook.

Yes.  Since it's code it *could* do conditional things based on some
setting if it needs to.

> Another query I have is how to handle back-end error. The audio bus
> which is running on my machine requires close coordination between CPU
> and CODEC. Essentially, if one side is unable to respond to incoming
> data in time, data exchange halts. I am looking for way to reset both
> CPU and CODEC back to fresh state. One approach I am thinking is to
> generate XRUN error(snd_pcm_stop(SNDRV_PCM_STATE_XRUN) and have
> application call prepare() to reset CPU and CODEC back to good state.
> I see each back-end is registered as PCM device so it's possible that
> application can read /dev/snd/timer to get notified. However, do I call
> prepare() on one of FE PCM devices that are routed to the back end in
> question? Would this approach work? Any suggestion?

I'd expect that from an application point of view this will just work
already?  The application will just operate on the PCM it's operating on
and will notice a stall in the same way it does for any other device
then the front/back end machinery will connect everything up in the same
way it does for every operation when (if!) the application tries to
recover.

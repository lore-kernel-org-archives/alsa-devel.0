From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp questions
Date: Fri, 10 Jun 2011 10:42:30 +0100
Message-ID: <20110610094226.GA26436@opensource.wolfsonmicro.com>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>
	<1303810865.3332.57.camel@odin>
	<20110426101848.GA23812@sirena.org.uk>
	<4DF1C08F.90306@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77DE510382F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 11:42:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DF1C08F.90306@codeaurora.org>
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

On Thu, Jun 09, 2011 at 11:58:23PM -0700, Patrick Lai wrote:
> On 4/26/2011 3:18 AM, Mark Brown wrote:

> >This is roughly the same thing I've been talking about for digital DAPM
> >links.  I've got code which runs at the minute but the implementation
> >sucks too much, should be able to pull out some of the preparation work
> >in the next day or so.

> Is it possible I can take an early glimpse of implementation? I do have

No, the code ended up colliding with something someone else had done and
wasn't worth saving so I just threw it away.  However I did get the
external interface upstream before I did that - that was the code to
support not providing a platform driver for a DAI.  What the code did
was to look to see if there was a platform driver and if there wasn't
it'd add some DAPM nodes and links which would bring up the DAI with no
userspace involvement.

> use cases that PCM is exchanged between two back-ends. Right now, I
> need to define DUMMY hostless front-end DAI links to bring up the
> back-ends. Another query is how hardware parameters is passed to
> back-end with your design? Not able to choose back-end channel mode

For the initial code they were just inferred from the capabilities of
the DAI - all the cases I'm interested in are for interoperation with
something that's fixed format at one end of the link so I could punt on
that issue.  I'd thought about allowing the dai_link to have a set of
hw_params settings stored in it which the user would be given an
enumeration to select from but hadn't actually done anything concrete
with it.

> independent of front-end channel mode is a big problem especially if
> channel mode is more than stereo. DSP is handles upmixing/downmixing
> happens in our design. Right now, we force channel mode to stereo. So,
> for the scenario which we just want mono input, we have codec
> configured to pick up single mic input to both left and right channel.
> DSP takes average of two channels into mono stream. Once we need to
> support > 2 channel recording, it's wasteful to go with the same
> approach if all we want is mono input. Did we talk about this topic

That might be handlable by either of the methods I was suggesting above.
Of course depending on the algorithms you're running the DSP may want
more mics than it's producing output channels - beam forming or noise
cancellation are the obvious examples there.

> during workshop? Why is my problem also a concern on OMAP4/ABE?

Do you mean not also a concern?  I *believe* OMAP is passing the
configuration through to the external DAI using the front end/back end
connection so the format gets selected by the app when it does a record,
possibly with rewriting through the hook functions in the machine driver.

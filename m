From: Patrick Lai <plai@codeaurora.org>
Subject: Re: soc-dsp questions
Date: Thu, 09 Jun 2011 23:58:23 -0700
Message-ID: <4DF1C08F.90306@codeaurora.org>
References: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>	<1303810865.3332.57.camel@odin>
	<20110426101848.GA23812@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 276BE24502
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 08:58:26 +0200 (CEST)
In-Reply-To: <20110426101848.GA23812@sirena.org.uk>
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

On 4/26/2011 3:18 AM, Mark Brown wrote:
> On Tue, Apr 26, 2011 at 10:41:05AM +0100, Liam Girdwood wrote:
>> On Mon, 2011-04-25 at 17:01 -0500, pl bossart wrote:
>>> To prepare next week's ALSA-Asoc meeting, I reviewed Liam's
>>> dsp-upstream code, and I am a bit unclear on the 'no_host_mode'
>>> supported by some DAIs. Apparently these are regular ALSA PCM
>>> substreams, except that there are no data exchanges to/from the host.
>
>> Ah, this part is WIP and will not be part of the initial submission. We
>> are currently using this for audio between the MODEM and ABE that does
>> not pass through the CPU.

This mode is also deployed on QC MSM as well.
>
> This is roughly the same thing I've been talking about for digital DAPM
> links.  I've got code which runs at the minute but the implementation
> sucks too much, should be able to pull out some of the preparation work
> in the next day or so.
>
Is it possible I can take an early glimpse of implementation? I do have
use cases that PCM is exchanged between two back-ends. Right now, I
need to define DUMMY hostless front-end DAI links to bring up the
back-ends. Another query is how hardware parameters is passed to
back-end with your design? Not able to choose back-end channel mode
independent of front-end channel mode is a big problem especially if
channel mode is more than stereo. DSP is handles upmixing/downmixing
happens in our design. Right now, we force channel mode to stereo. So,
for the scenario which we just want mono input, we have codec
configured to pick up single mic input to both left and right channel.
DSP takes average of two channels into mono stream. Once we need to
support > 2 channel recording, it's wasteful to go with the same
approach if all we want is mono input. Did we talk about this topic
during workshop? Why is my problem also a concern on OMAP4/ABE?
Suggestion?


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

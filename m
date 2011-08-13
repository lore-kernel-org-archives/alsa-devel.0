From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: Add ADAU1373 codec support
Date: Sat, 13 Aug 2011 05:25:41 +0200
Message-ID: <4E45EEB5.8080107@metafoo.de>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>	
	<1312948364-2587-2-git-send-email-lars@metafoo.de>	
	<20110811092702.GA18454@opensource.wolfsonmicro.com>	
	<4E43AACF.5060701@metafoo.de>	
	<1313068590.19990.2.camel@finisterre.wolfsonmicro.main>	
	<4E4471E1.5060706@metafoo.de>
	<1313112046.19990.32.camel@finisterre.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C6621037EA
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Aug 2011 05:28:01 +0200 (CEST)
In-Reply-To: <1313112046.19990.32.camel@finisterre.wolfsonmicro.main>
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
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/12/2011 03:20 AM, Mark Brown wrote:
> On Fri, 2011-08-12 at 02:20 +0200, Lars-Peter Clausen wrote:
>> On 08/11/2011 03:16 PM, Mark Brown wrote:
> 
>>> Sorry, what does this actually control? I guess I've been mislead but
>>> from the name of the control I'd expect it to control if the outputs
>>> were physically connected as mono or stereo outputs.
> 
>> It controls how Lineout and Speaker mixers distribute the left and right input
>> channels to their output channels.
> 
> Ah, I see. I guess that should really be represented in DAPM so that if
> we're playing a mono signal out we figure out that both left and right
> channels are connected even if there's only input for one of them,
> especially for the line outputs which may be connected to external
> speaker drivers or something that needs power management.
> 

Looks as if both my understanding and my explanation on how this controls works
were a bit inaccurate.

So here is how it works: There are 4 possible settings
Mute: Both the left and the right mixer are muted
Left Channel (L+R): The right mixer is muted. The left mixer is unmuted and for
the input bypass signals both the left and the right channel are mixed into the
output.
Right Channel (L+R): Similar to Left Channel (L+R), only for the right mixer.
Stereo: Both the left and the right mixer are unmuted. For the left mixer the
left channels of the input bypass signals are mixed into the output and for the
right mixer the right channels.

Since this driver's DAPM already doesn't distinguish between the left and the
right channel of the input bypass signals none of the outputs or mixers are not
powered when they should be.

So I would like to keep these as enums, as they are right now.

- Lars

From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Record stereo from one input on the soundcard
Date: Mon, 28 Jan 2019 08:52:29 +0100
Message-ID: <alpine.DEB.2.20.1901280841190.10606@lnxricardw1.se.axis.com>
References: <87muo6uhww.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
 <87sgxgxy9l.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
 <e285bd85-2f7b-b7f8-5b1d-83bf50eb42ec@ivitera.com>
 <87h8dux81g.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CE29266A89
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 08:52:37 +0100 (CET)
In-Reply-To: <87h8dux81g.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomas Nordin <tomasn@posteo.net>
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Sun, 27 Jan 2019, Tomas Nordin wrote:

> Ok, thanks. I have been a bit confused about the relation between the -c
> option argument and the number of inputs on a card. If I understand
> correctly, the -c option does not say anything about what inputs to
> record from, it is saying what kind of audiofile to produce?

-c 2 means "take two channels from the card and produce two channels of 
output". It does not at all address how those two channels are formed in 
the card. Usually sound cards have an internal mixer, so that input 1 
could be feeding channels 1 and 2 for instance. However, in my (limited) 
experience, the audio routed to USB is often more or less directly mapped 
to the physical inputs, with any internal mixer in the sound card 
providing monitoring functionality (the headphone output primarily).

Looking quickly at a picture of the sound card, it looks as if the two 
inputs are mono inputs, balanced when XLR connectors are used, potentially 
unbalanced when 1/4" connectors are used.

I would think that inputs 1 and 2 are sent as the left and right channels 
over USB, and that's what you get when you use arecord -c 2.

Connecting the headphone output of your drum module to input 1 will thus 
result in a mono recording on channel 1.

My guess is that the internal mixer of the sound card is set up to 
distribute both input channels to both left and right headphone outputs, 
thus you can hear sound in both the left and right channels of the 
headphone output, even when using only one of the inputs.

Most soundcards have a Windows and/or Mac application which can control 
the internal mixer; sadly, most often they use a proprietary interface and 
thus do not show up as ALSA controls. Sometimes the mixer application can 
be run under Wine; more often in a virtual Windows environment such as 
VirtualBox.

If you do want to record both channels, you would need to have a cable 
that has a stereo connector on one end, for connecting to your drum 
module, and two mono 1/4" connectors at the other end, providing inputs 1 
and 2 with the left and right channels.

What is the drum module? Does it not have ordinary outputs as well as the 
headphone output?

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30

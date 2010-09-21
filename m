From: Krzysztof Foltman <wdev@foltman.com>
Subject: Re: proposed MPD16 latency workaround
Date: Tue, 21 Sep 2010 11:01:37 +0100
Message-ID: <4C988281.4010700@foltman.com>
References: <4C9154F4.8040304@foltman.com> <4C91DD19.5000005@ladisch.de>
	<4C921DA5.6080301@foltman.com> <4C970BFD.3080006@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpoproxy2-pub.bluehost.com (cpoproxy2-pub.bluehost.com
	[67.222.39.38]) by alsa0.perex.cz (Postfix) with SMTP id 939CB243ED
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 12:06:40 +0200 (CEST)
In-Reply-To: <4C970BFD.3080006@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20/09/10 08:23, Clemens Ladisch wrote:

> It is possible that an opened MIDI port uses resources that would be
> needed by other devices.

True.

> I'd estimate that the power usage is measurable on laptops.  Changing
> the driver to submit URBs only when a port is open is one of those
> changes that I want to do whenever I have time to do unimportant
> changes.

In that case, you can probably just use my changes as a starting point. 
They should be easily adaptable for at least some of the devices (I 
think only multiple cables per port are hard to support with current 
set-up). Some day, maybe :)

> Well, it turned out bigger than I would have liked.
> Compile-tested.  Handle with care.

Checked it yesterday. The data input works, however, the trying to 
output some sysex data with amidi prints the "bad dma" messages from the 
UHCI driver, and data don't end up on a device. Also, either on 
disconnection or rmmod it OOPSes (can't tell which of them, it came up 
in the dmesg output but I couldn't do proper tests yet).

I'll try to investigate it further when I have a couple of hours.

That aside, why do you need URB_NO_FSBR flag for the URBs? Because of 
prevalence of very short packets in the Akai MIDI protocol?

>> To clarify: in this solution, to enable control input, you need to send
>> a fake sysex on control output.
> I've changed it so that you can send anything to enable the input.

That might cause some problems if I (or anyone else) create the config 
program. They're avoidable (only run the config tool while JACK is not 
running), but still, it's not what I'd expect as a user.

I'll try to write a patch for all JACKs to blacklist the control device, 
that should take care of the JACK incompatibility.

Krzysztof

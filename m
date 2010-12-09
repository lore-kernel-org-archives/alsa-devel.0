From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Gigabyte 880GM-USB3 MIDI and Dolby 5.1/7.1 issues
Date: Thu, 09 Dec 2010 12:52:10 +0100
Message-ID: <4D00C2EA.1060204@ladisch.de>
References: <AANLkTimb5AnPm13d0kpMmjq4nOTH0dXA_VyO2CXbr_bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5E35F103C7E
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 12:50:18 +0100 (CET)
In-Reply-To: <AANLkTimb5AnPm13d0kpMmjq4nOTH0dXA_VyO2CXbr_bQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Gardner <jgardner@jonathangardner.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jonathan Gardner wrote:
> First, with my older motherboard, I could control the various output
> and input levels of the channels. With this motherboard, I only have
> one channel "Internal Audio Analog Stereo".

This looks like PulseAudio's idea of a user-friendly abstraction.
Try "alsamixer -D hw:0".

> Second, I never really got MIDI working, at least not that I recall in
> my 10 years of Linux. I know MIDI is possible, I just don't know what
> it takes. I've been playing with musescore which apparently plays the
> notes over MIDI so you can hear what you wrote, which would be nice.

Your mainboard doesn't support MIDI, but I guess you don't have any
external MIDI devices anyway.

To play back MIDI data, you need some synthesizer.  Try FluidSynth.


Regards,
Clemens

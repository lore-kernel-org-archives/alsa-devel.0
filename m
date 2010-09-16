From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: proposed MPD16 latency workaround
Date: Thu, 16 Sep 2010 11:02:17 +0200
Message-ID: <4C91DD19.5000005@ladisch.de>
References: <4C9154F4.8040304@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id F3000243EA
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 11:02:04 +0200 (CEST)
In-Reply-To: <4C9154F4.8040304@foltman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Foltman <wdev@foltman.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Krzysztof Foltman wrote:
> I've played with USB MIDI driver and MPD16 a bit more. The problem is 
> definitely triggered by submitting URBs on the configuration input 
> endpoint - when these are killed, the latency disappears. Disabling the 
> configuration port works, but is a bit heavy-handed, so I've implemented 
> a workaround: initially, the URBs for the input configuration endpoint 
> are not submitted until two conditions are met:
> 
> i) the control port is actually open (I check that using input_triggered 
> bitmask)
> 
> ii) the driver is switched into config mode by sending a special SysEx 
> message to the output port (which is intercepted by the driver and used 
> to set a flag). This is to prevent programs that open all the MIDI ports 
> in the system (JACK daemon with ALSA MIDI driver, a2jmidid etc.) from 
> starting unwanted communication with configuration endpoints.

This can be considered a bug in those programs.

> I'm mostly interested in the review of the general approach - I have
> some doubts about thread-safety of calling snd_usbmidi_input_update_ep
> from send function

I also have doubts, but I didn't look too much into this.

Since this device uses a completely vendor-dependent protocol, your
changes result in a driver that uses practically none of the common
code for the MPD16.  Furthermore, your code makes it harder to maintain
the driver because these parts of the code cannot be tested without the
MPD16.  In other words, I think that writing a separate driver would be
a better idea.

I'll see if I can write it until Monday; you'll just have to test it
and remove my bugs.  :)

> and about the elegance of the SysEx approach (vs. ioctl or something
> else).

If the control port is used only by some specialized control
application, it doesn't matter too much which mechanism is used.
If the data port is already being used by it, the SysEx approach
would indeed be the simplest to use.


Regards,
Clemens

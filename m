From: Krzysztof Foltman <wdev@foltman.com>
Subject: Re: proposed MPD16 latency workaround
Date: Thu, 16 Sep 2010 14:37:41 +0100
Message-ID: <4C921DA5.6080301@foltman.com>
References: <4C9154F4.8040304@foltman.com> <4C91DD19.5000005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpoproxy1-pub.bluehost.com (cpoproxy1-pub.bluehost.com
	[69.89.21.11]) by alsa0.perex.cz (Postfix) with SMTP id A8216243AF
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 15:41:47 +0200 (CEST)
In-Reply-To: <4C91DD19.5000005@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 16/09/10 10:02, Clemens Ladisch wrote:

>> ii) the driver is switched into config mode by sending a special SysEx
>> message to the output port (which is intercepted by the driver and used
>> to set a flag). This is to prevent programs that open all the MIDI ports
>> in the system (JACK daemon with ALSA MIDI driver, a2jmidid etc.) from
>> starting unwanted communication with configuration endpoints.
> This can be considered a bug in those programs.

Yes. Well, it's the case of what's right vs. what's convenient. I think 
the assumption that opening a MIDI port (sequencer or raw) won't cause 
disastrous results (like increased latency of some other port) is a fair 
assumption.

Also, working around the problem in the central place (kernel driver) 
is, in my opinion, more convenient than fixing that otherwise-harmless 
behaviour in many other projects (jackd1, jackd2, a2jmidid, another JACK 
implementation by Torben Hohn that I don't know the name of). Especially 
given the minimal popularity of the MPD16.

> Since this device uses a completely vendor-dependent protocol, your
> changes result in a driver that uses practically none of the common
> code for the MPD16.

Well, it _could_ be used for some other USB MIDI devices (the ones using 
bulk mode on input endpoints) to reduce data churn on USB ports when 
devices are physically connected but their MIDI ports are not used. 
Probably isn't worth it though: the power and bandwidth use of the 
unnecessary polling is probably minimal.

The MPD16 code *does* use some things in the generic driver, like most 
of the setup code. The only differences are: 1) I/O quirks (and many 
other devices have those), 2) conditional opening of endpoints 
(potentially reusable). I don't think the impact is very severe, 
comparing with the Roland stuff in the same file, for example.

> I'll see if I can write it until Monday; you'll just have to test it
> and remove my bugs.  :)

That would be great - if you have time for it. I definitely can take 
care of testing/debugging in that case.

> If the control port is used only by some specialized control
> application, it doesn't matter too much which mechanism is used.
> If the data port is already being used by it, the SysEx approach
> would indeed be the simplest to use.

To clarify: in this solution, to enable control input, you need to send 
a fake sysex on control output. The device has no functional *data* 
output, as far as I can tell - there's only data input which sends 
events from the pads and the slider.

I thought of using alternatives like a hwdep device, a mixer control or 
an ioctl, but those were frighteningly hard to implement and not really 
much nicer for the user. And the control port talks MIDI (SysEx 
messages) anyway.

That specialized control application doesn't even exist at this point. 
So, a low-effort alternative option to consider would be to completely 
drop the ability to configure the device, as most of the configuration 
can be done from the device anyway (the inconvenient but working "hold 
some button, press some pads" type of interface).

If I had to choose between "enormous latency and automatic 
configuration... maybe some day" and "imperceptible latency, but have to 
set it up manually", I'd definitely choose the latter.

Krzysztof

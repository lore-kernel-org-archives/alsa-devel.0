From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 8 Sep 2010 09:54:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009080934380.10278@eeebox2.perex-int.cz>
References: <1282640988.3053.43.camel@odin>
	<alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<20100907155355.GE25830@sirena.org.uk>
	<alpine.LNX.2.00.1009072001580.10278@eeebox2.perex-int.cz>
	<20100907185358.GA1125@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FADD243C6
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 09:54:51 +0200 (CEST)
In-Reply-To: <20100907185358.GA1125@rakim.wolfsonmicro.main>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Sep 2010, Mark Brown wrote:

> Currently outside of the explict sequences provided to override the
> default transitions the use case manager configurations are declarative
> rather than ordering based.  This lets the user specify end states and
> lets the use case manager code work out the best way to accomplish those
> configurations which seems like a valuable property.

I don't see any difference here. I checked the Liam's code and there is 
no intelligence regarding the ALSA controls API. The sequences are just 
processed in the serialized way and they must be (for example to satisfy 
the time delay requirements between control writes).

>> configurations can use this API to send events to another manager
>> which can control another parts of the system like video, input
>> devices, network devices and so on according the sound setup.
>
> I do agree that this may be useful but I don't see that we need to
> rewrite the ALSA control management bit of things for that, the
> declarative style seems like a win there.  I also feel that it may make
> more sense to do this externally to this library in a higher level tool
> which controls both this and other things.

Note that my proposal is just extension. It's like difference between full 
desktop system and a small optimized system (for example for small 
wireless hardware platforms). There are many differences in the boot 
style and root system trees, because not all things are required for 
small systems. Nobody forces the user to use the exec command.

>> Also, the possibility to generate the alsa-lib's configuration files
>> at run-time might be a nice feature for future. I take UCM like a
>
> This might be useful, though I'd expect that Pulse might be more useful
> for a lot of systems.
>
>> way to integrate all things regarding PCM streams and mixer controls
>> together and let users / system administrators / distribution makers
>> create the abstract layers depending their requirements.
>
> That's my understanding of what the idea is.
>
>> It's about flexibility.
>
> As I said above I'm concerned that you're trying to move this into
> something which is much more of a system level use case manager than an
> audio specific one, and limiting the audio domain as part of that.  If
> we're doing too much of that then we're into the domain of the system
> level software that would be driving the UCM.

My motivation is to make UCM useable also for the desktop systems. In this 
environment might be useful to send external events to another layers when 
an app requests specific audio device. For example, HDMI is connected with 
the video link so the X11 server might be notified about this request.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

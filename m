From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Fri, 18 Jun 2004 15:39:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D344FC.8070804@joe-job.com>
References: <40D1E4E7.8000704@joe-job.com>	<200406172326.i5HNQkQV017899@dhin.linuxaudiosystems.com> <s5hacz1p5vd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacz1p5vd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Alsa-devel@lists.sourceforge.net, pzad@pobox.sk
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> At Thu, 17 Jun 2004 19:26:46 -0400,
> Paul Davis wrote:
> 
>>>To reiterate the situation:  currently the ASIO drivers for this card 
>>>provide an order of magnitude
>>>better latency than the ALSA driver.  I am constantly hearing claims 
>>>that ALSA is superior to ASIO,
>>>but no one can tell me why the ALSA drivers for this *very* common 
>>>device provide 5-10x worse latency
>>>than the ASIO drivers.
>>>
>>>As I see it, this is a glaring deficiency.
>>
>>as a disinterested observer, i would just note that by my
>>understanding, Creative have not released all the necessary
>>programming information on the emu10k1. i suspect that whatever is
>>necessary to get the period size down to the levels the ASIO driver(s)
>>are using is in the information that they will not release without an
>>NDA. 
> 
> 
> It might be.  But my guess is that ASIO uses the playback interrupt
> for capture, too.
> 

Thank you, this was the idea that I had, to use the playback interrupt 
to drive the capture.  I was hoping someone with in-depth knowledge of 
ALSA would agree.

Is there another ALSA driver that provides an example of this kind of 
design?  I am pretty new to hacking device drivers and an example would 
be helpful, if one is available.

P.S. Here is some background for people who are familiar with the 
emu10k1 hardware but don't use Windows or the kX drivers, I think there 
are a few on this list: The kX ASIO driver maps each FXBus channel onto 
an ASIO input and output port.  In order to do low latency/multichannel 
recording, you have to use the DSP manager to connect one of the 
physical inputs or outputs to an FXBus channel, then your ASIO app can 
read or write to that channel.

I think we only need to be concerned with the FXBus capture/playback device.

Lee


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND

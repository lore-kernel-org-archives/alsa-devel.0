From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Fwd: [was Re: [linux-audio-user] Multiple (three) RME Hammerfalls... any experience]
Date: Sat, 29 Nov 2003 10:10:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311291510.hATFAhZF015715@oud.linuxaudiosystems.com>
References: <3FC891F9.20701@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 29 Nov 2003 21:32:57 +0900."
             <3FC891F9.20701@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: A list for linux audio users <linux-audio-user@music.columbia.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> I can't help you much, however, unless JACK has
>> recently been worked on I think there's a 32 track
>> limitation. It's known to be technically trivial.

still in place at this time. there is a simple 1-2 line solution; i'm
not sure if its the right one, since it simply substitutes a 64
channel limit.

>> Midi Time Code syncronization in Ardour could also be
>> problematic, it doesn't work with my Tascam DM-24.
>> Even though transport location is accurate, the
>> automation system can't interpret Ardour mtc. Paul has
>> announced his intention to implement SMPTE but I'm not
>> sure if that's been done yet.

yes, to repeat a familiar refrain these days, being an MTC master
on an unpatched linux system is, to the best of my knowledge,
fundamentally impossible. your other systems will chase the linux
master, but will not lock to it.

>> I wonder what the status of 96kHz adat is with the
>> hammerfall drivers.

for the hdsp, its know to work fine. the digi9652 works, but it may
require some work to configure the device properly. sorry i don't
remember more (and i'm the author .. :)

>>>The problem is that we have to transfer a few hours
>>>of 72-channel music
>>>from three synced Mackie SDR24/96's to a harddisk. I
>>>don't really know 
>>>what format the music is recorded in.
>>>
>>>As my colleague is unable to use three RME
>>>Hammerfall DSP card's in his
>>>dual G4 powermac with OSX (don't know exact
>>>version), I wondered if I
>>>could use Linux to capture the music to harddisk.
>>>
>>>If anybody has any experience, please let me know.
>>>Otherwise we will
>>>proceed with one card and thus 24 channels at a
>>>time, which does work.

i personally think you will have a much easier time doing it one card
at a time. there is nothing about ALSA that will stop you from trying
this, assuming as ron noted that you wordclock-sync all 3 cards. but
you will also be streaming a large amount of data to disk (on the
order of 13MB/sec at 48kHz, twice that at 96kHz), and you will need a
pretty robust disk subsystem to manage this flawlessly. 

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Multiple Delta 1010LT woes: UPDATE
Date: Sat, 21 Feb 2004 09:26:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402210907440.1870@pnote.perex-int.cz>
References: <4036521E.9070407@sun.ac.za>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4036521E.9070407@sun.ac.za>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ludwig Schwardt <schwardt@sun.ac.za>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Feb 2004, Ludwig Schwardt wrote:

> Hi again,
> 
> I've made some progress on the .asoundrc issue. I can now record 8 
> analog channels in JACK using a single Delta 1010LT piped through the 
> multi plugin. I cannot get playback to work yet. This is luckily not a 
> problem for my application, which only records sound. Any ideas on 
> getting playback to work?

This hardware has assymetric channel count - playback 10 and capture 12 
(you've already figured this value). The extra two channels for capture 
are for the digital stereo mixer output.

> I do notice a few extra warnings popping up which wasn't there when I 
> accessed the soundcard directly, namely "late driver wakeups" followed 
> by e.g. "delay of 46411.000 usecs exceeds estimated spare time of 
> 45230.000; restart ...". These delays are always very close to the 
> estimated spare time. Since I cannot playback within JACK, I cannot tell 
> whether this has an audible effect. Should I be worried?

It looks like that system for some reason has long scheduler gaps or 
something takes a lot of CPU time.

Personally, I don't think that you can use all three Delta's in one box at
maximum rate, because they have only limited DMA PCI buffers (max 256kB)
which is too small. If I compare this buffer with RME cards, then
one channel has space for 5461 samples (capture) with ICE1712 and
one channel with RME hardware has space for 16384 samples.

Anyway, it's true that route plugin - and basically all sample conversion 
and copy routines - in alsa-lib are not so much optimized for particular
streams, so there is still space to improve code.

> P.S. What is the rule regarding slaves.xxx.channels in multi plugins? It 
> seems you have to set this equal to the actual number of channels of the 
> soundcard (slaves.xxx.pcm) to prevent "invalid argument" and "broken 

Yes, this parameter must match with hardware.

> configuration" ALSA errors. What do you choose if the number of capture 
> and playback channels differ?

Use asym plugin which let's you specify two different stream configuration 
for playback and capture:

pcm.name {
        type asym               # Asym PCM
        playback STR            # Playback slave name
        # or
        playback {              # Playback slave definition
                pcm STR         # Slave PCM name
                # or
                pcm { }         # Slave PCM definition
        }
        capture STR             # Capture slave name
        # or
        capture {               # Capture slave definition
                pcm STR         # Slave PCM name
                # or
                pcm { }         # Slave PCM definition
        }
}

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

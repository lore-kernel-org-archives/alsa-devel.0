From: Luca <kronos@people.it>
Subject: Re: Re: [2.6.3] snd_intel8x0: playing to fast
Date: Thu, 11 Mar 2004 16:28:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040311152835.GA22576@dreamland.darkstar.lan>
References: <20040310212125.GA17864@dreamland.darkstar.lan> <yw1xfzcgxsmh.fsf@kth.se>
Reply-To: kronos@people.it
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <yw1xfzcgxsmh.fsf@kth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Il Wed, Mar 10, 2004 at 11:08:22PM +0100, M?ns Rullg?rd ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> Luca <kronos@people.it> writes:
> 
> > Hi,
> > I'm using linux 2.6.3 with alsalib 1.0.2c. When using alsa output plugin
> > of XMMS or mplayer the song is played too fast. Using OSS emulation
> > works fine.
> >
> > This is from bootlog:
> >
> > intel8x0_measure_ac97_clock: measured 49482 usecs
> > intel8x0: clocking to 48000
> 
> Make sure the programs are using device "default" or "plughw:0,0" (or
> whatever device numbers you like).  If the programs can't be persuaded
> to do that they are buggy.  

mplayer is using hw:0,0.

alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit (Little-Endian)
alsa-init: compiled for ALSA-1.0.3
alsa-init: soundcard set to hw:0
alsa-init: pcm opend in block-mode
alsa-init: chunksize set to 1024
alsa-init: current val=16, fragcount=16
alsa-init: got buffersize=65536
alsa9: 44100 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little Endian

It doens't like plugwh:0,0:

alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit (Little-Endian)
alsa-init: compiled for ALSA-1.0.3
alsa-init: soundcard set to plughw
alsa-init: pcm opend in block-mode
alsa-init: unable to set periodsize: Invalid argument

Also my .asoundrc was very minimal:

pcm.!default {
        type hw
        card 0
}

ctl.!default {
        type hw
        card 0
}

Now I added:

pcm_slave.sl2 {
        pcm "hw:0,0"
        rate 48000
}

pcm.foobar {
        type rate
        slave sl2
}

But, again, MPlayer refuse to work:

alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit (Little-Endian)
alsa-init: compiled for ALSA-1.0.3
alsa-init: soundcard set to foobar
alsa-init: pcm opend in block-mode
alsa-init: unable to set periodsize: Invalid argument

aplay does recognise -Dfoobar (and work even without it).

> Well, those two are buggy anyway.

Yep, it seems so :)
Btw, mplayer from CVS (checked out today) works nicely with -ao alsa1x:

alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit (Little-Endian)
alsa-init: compiled for ALSA-1.0.3
alsa-init: got device=0, subdevice=0
alsa-init: 1 soundcard found, using: hw:0,0
alsa-init: pcm opened in block-mode
alsa-init: chunksize set to 1024
alsa-init: fragcount=16
alsa-init: got buffersize=65536
alsa1x: 48000 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little Endian
...
[resample] Changing sample rate to 48000Hz
[resample] Changing sample rate to 48000Hz
[resample] Using linear interpolation.

So my sound card accept sound only at 48000Hz but old mplayer didn't
notice that alsa-lib doesn't accept its request for 44100Hz. Correct?

thanks,
Luca
-- 
Home: http://kronoz.cjb.net
La differenza fra l'intelligenza e la stupidita`?
All'intelligenza c'e` un limite.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

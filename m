From: Bernard Urban <Bernard.Urban@meteo.fr>
Subject: Re: Requested: CMI8330 testers?
Date: 09 Jan 2003 16:00:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87heci1i73.fsf@merceron.meteo.fr>
References: <s5hy96qro4i.wl@alsa2.suse.de> <87el83q0oh.fsf@merceron.meteo.fr>
	<s5h65szajak.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65szajak.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bernard Urban <Bernard.Urban@meteo.fr>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

[...]

>    echo "xquake 0 0 direct" > /proc/asound/card0/pcm0p/oss
> 
> please check alsa-kernel/Documentation/ALSA-Configuration.txt for
> details.
> 
> 
> > Now the AMD K6-II with a SB Vibra 16X PnP: runs with snd-sb16. In the
> > mixer I must force the 16 bit DMA to be allocated to Capture 
> > to have PCM sound for all kind of audio formats. If set to Auto, for instance
> > .au format is not recognized. Also, xquake runs and  produces sound only with
> > option 8bits sound.
> 
> perhaps this is also related with the above.

Yes, this works ! No more flag for 8 bits sound required.
I missed it the first time, as what you need
actually is:
echo "xquake.real 0 0 direct" > /proc/asound/card0/pcm0p/oss

(xquake is a shell wrapper for the real binary xquake.real)

> > quakeforge works well, but there is a time lag in
> > producing sound, which does not exist with the OSS driver. 
> > Tuning snd-mixahead does not help. 
>  
> this is not sure.  does the delay happen only on quake or do you mean
> it generally?  if it's general behavior, then it's easier to debug.
> anyway we need to trace at which point the delay occurs.

It is not general behaviour, alas. More specifically:
quakeforge with alsa sound output and alsa driver has the time lag
(nearly 0.5 second).
quakeforge with OSS sound output and OSS 'sb' driver works well.
quakeforge with OSS sound output and alsa OSS emulation driver 
works well, using:

echo "nq-glx 0 0 direct" > /proc/asound/card0/pcm0p/oss

but when you quit, the program locks itself (no machine crash, only
the program is blocked, you need to kill it).

Using quake2forge (a quake2 port, without alsa support) under alsa
OSS emulation driver with:

echo "quake2 0 0 direct" > /proc/asound/card0/pcm0p/oss

it works also well, but same program lock when quitting as with quakeforge.
I will try to investigate where it blocks (last message is about DMA
buffer release).

Regards.
 
-- 

Bernard Urban


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

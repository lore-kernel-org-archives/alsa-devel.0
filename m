From: Bernard Urban <Bernard.Urban@meteo.fr>
Subject: Re: SB 16 driver OSS emulation
Date: 10 Jan 2003 14:29:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87r8bl5e0w.fsf_-_@merceron.meteo.fr>
References: <s5hy96qro4i.wl@alsa2.suse.de> <87el83q0oh.fsf@merceron.meteo.fr>
	<s5h65szajak.wl@alsa2.suse.de> <87heci1i73.fsf@merceron.meteo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87heci1i73.fsf@merceron.meteo.fr>
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


This gives additional details about the blocking with the sb16 driver:

Bernard Urban <Bernard.Urban@meteo.fr> writes:

[...]

> quakeforge with alsa sound output and alsa driver has the time lag
> (nearly 0.5 second).
> quakeforge with OSS sound output and OSS 'sb' driver works well.
> quakeforge with OSS sound output and alsa OSS emulation driver 
> works well, using:
> 
> echo "nq-glx 0 0 direct" > /proc/asound/card0/pcm0p/oss
> 
> but when you quit, the program locks itself (no machine crash, only
> the program is blocked, you need to kill it).
> 
> Using quake2forge (a quake2 port, without alsa support) under alsa
> OSS emulation driver with:
> 
> echo "quake2 0 0 direct" > /proc/asound/card0/pcm0p/oss
> 
> it works also well, but same program lock when quitting as with quakeforge.
> I will try to investigate where it blocks (last message is about DMA
> buffer release).

quake2forge obtains an 'audio_fd' file descriptor by opening
"/dev/dsp". There is a DMA buffer mmaped associated.

At shutdown of the program, the DMA buffer is un-mmaped, and
the following close(audio_fd) blocks. This seems really weird !!! 
A 'close' system call cannot block ???

Actually, doing or not
echo "quake2 0 0 direct" > /proc/asound/card0/pcm0p/oss
makes no difference.

(By Monday, I hope I can send you the results of the CMI8330 patches.)

Regards.

-- 

Bernard Urban


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

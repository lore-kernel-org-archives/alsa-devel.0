From: Christian Esken <c.esken@cityweb.de>
Subject: Re: cs64xx distortion (GameTheater XP)
Date: Sat, 18 Jan 2003 12:15:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301181215.35808.c.esken@cityweb.de>
References: <200301162027.57458.c.esken@cityweb.de> <3E272320.2070008@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E272320.2070008@gmx.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Thursday 16 January 2003 22:24 schrieben Sie:
> Christian Esken wrote:
> >Takashi Iwai wrote:
> >>Christian Esken wrote:
> >>>I wonder what the status of the cs64xx distortion problem is.
> >>>I tested the 2003-01-14.tar.bz2 snapshot with my GameThaeter 7.1 XP
> >>>and it still shows those heavy distortions on analog output.
> >>
> >>well, it looks like you passed external_amp=1 option to the module,
> >>which you don't need usually.
> >>
> >>anyway, try the attached patch (and without external_amp=1 option).
> >>it will clean up the amplifier controls.
> >
> >Tried it. Unfortunately the patch does not help. Probably the distortion
> >is slightly less, but still the soundcard is basically unusable.
> >
> >I removed the external_amp=1 and reloaded the driver - and I sure that
> >actually the new driver got loaded.
>
> Does the sound quality improve if you lower the volume of PCM and/or
> master? If so, does reloading the cs46xx module (or restarting alsa) help?

Lowering helps, but the sound is still very very bad.


> Try
> /etc/init.d/alsa force-restart
> as root or
> modprobe -r snd-cs46xx
> modprobe snd-cs46xx
> as root.

Reloading the module does not help.
I also tried the "mute-unmute-CD-volume" thing, but this does not help at all.

Chris




-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en

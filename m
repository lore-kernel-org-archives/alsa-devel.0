From: Eduard Bloch <eb@zombie.inka.de>
Subject: [snd-intel8x0] distortion on PCM volume >> 50%
Date: Sun, 30 Nov 2003 11:03:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031130100343.GA12681@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello,

I have some problems with a ac97 based sound card (Notebook built-in)
where the kernel driver works fine (except of not beeing able to
resample on-the-fly).

When I set the PCM mixer volume to more then 50%, I hear few sound
fragments. If I go over 75% I hear them all the time and on 100% PCM,
the sound is full of scratching fragments. You can get an example
catched with microphone on
http://sites.inka.de/W1752/alsa-distortion.ogg and the original is on
www.vorbis.com/music/Mists_of_Time-4T.ogg . First I suspected a speaker
problem since it sounds very similar to overloud speaker setting, but it
is not!

Another problem is more complicated to describe. With programs that use
the native ALSA device access, I hear very quiet but annoying
crackling/ticking sound every 2-5 seconds. Only hearable with low volume
music. When I use programs that work over snd-pcm-oss emulation, the
repeating cracling is not there, but it comes every 3-5 minutes in
another form: I hear many sound ticks passing in 2-3 seconds, followed
by changed sound frequency for 3-5 seconds, then the out normalises
again.

The hardware part is claimed to be manufactured by Yamaha (AC-XG) but
lspci identifies it as:

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio =
Controller (rev 02)

Sharing the IRQ with other onboard components:

 11:    3489538          XT-PIC  usb-uhci, usb-uhci, eth0, Toshiba Americ=
a Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support, Toshiba Ame=
rica Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (#2), ohc=
i1394, Intel 82801CA-ICH3

The described problem appears with every ALSA version I can remember (>=3D=
 0.9).

MfG,
Eduard.
--=20
Hab ich mir selber ausgedacht.
F=FCr bl=F6de Spr=FCche brauch ich kein Programm.
		-- Anita Frieda Reimann


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

From: Erik Welander <erikwel@spray.se>
Subject: ES18xx Bug report and help on ES1878 NoPnP
Date: Thu, 30 Jan 2003 20:53:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1043956429015333@lycos-europe.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_NextPart_Lycos_0153331043956429_ID"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Lycos_0153331043956429_ID
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi there, I read your post requesting help of debugging the es18xx.c file that is apparently broken, and I have a Compaq armada 1550t, with an ES1878 NoPnP chip on the board and want to help your project in helping debugging and ironing out the bugs of the driver. I have retrieved all the working settings (i.e. DMA, IRQ) from Windows System Manager. Here is my current report on the subject: 
 
* all mixer controls seems to work in alsamixer, you can mute/unmute the following controls (visible MM goes away/comes back) Record, Hardware, Mic Boost, Master.

By modifying snd_es18xx_playback_trigger function I tested both dma
playback functions and here are my findings:

*dma1, i.e.snd_es18xx_playback2 function writeout kern.log:
(Produces no sound at all. When stopped playing an mp3 with mpg321 gives playback drain error)
**************************************************************************
Jan 30 19:30:34 cyberbob kernel: isapnp: Scanning for PnP cards...
Jan 30 19:30:34 cyberbob kernel: isapnp: No Plug & Play device found
Jan 30 19:30:35 cyberbob kernel: ALSA ../alsa-kernel/isa/es18xx.c:1569: [0x220] ESS1878 chip found
Jan 30 19:38:40 cyberbob kernel: ALSA ../alsa-kernel/core/pcm_native.c:1137: playback drain error (DMA or IRQ trouble?)
***************************************************************************

 
*dma16, i.e. snd_es18xx_playback1 function writeout: kern.log:
(gives a lot of background hizz/noise/garbled sound when playing a mp3 with mpg321 and the following printout):  
***************************************************************************
Jan 30 19:57:51 cyberbob kernel: isapnp: Scanning for PnP cards...
Jan 30 19:57:51 cyberbob kernel: isapnp: No Plug & Play device found
Jan 30 19:57:51 cyberbob kernel: ALSA ../alsa-kernel/isa/es18xx.c:1569: [0x220] ESS1878 chip found
Jan 30 19:58:24 cyberbob kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: BUG: stream =3D 0, pos =3D 0xffffffff, buffer size =3D 0x3c1e, period size =3D 0x402
Jan 30 19:58:24 cyberbob kernel: ALSA ../alsa-kernel/core/pcm_lib.c:187: Unexpected hw_pointer value (stream =3D 0, delta: -1, max jitter =3D 7695): wrong interrupt acknowledge?
***************************************************************************

Now I am running on Debian, custom compiled kernel 2.4.20. I was a bit worried about that compiling the source from the project pages and installing on Debian might be problematic due to the package system on Debian, however this seems to work without glitches.

Best Regards from Erik

_____________________________________________________________
H=E4r b=F6rjar internet!
Skaffa gratis e-mail och gratis internet p=E5 http://www.spray.se

Tr=E4ffa folk fr=E5n hela Sverige p=E5 ett och samma st=E4lle - http://chat.spray.se/



--=_NextPart_Lycos_0153331043956429_ID--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

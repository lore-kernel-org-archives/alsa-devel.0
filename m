From: "Webmaster Refstart.NL" <webmaster@refstart.nl>
Subject: Support for VIA8233A chipset
Date: Wed, 15 May 2002 15:54:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205151554.39013.webmaster@refstart.nl>
Reply-To: webmaster@refstart.nl
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi developers,

I've a Soltek DRV5 motherboard with a onboard VIA8233A/AC97 soundcard. I=20
downloaded the ALSA 0.9.0rc1 drivers, and tried to get the sound working =
with=20
the snd-via8233 module. The modules seems to be loading OK:

tussen root # modprobe snd-via8233
tussen root # modprobe snd-seq-oss
tussen root # modprobe snd-mixer-oss
tussen root # modprobe snd-pcm-oss
tussen root # lsmod
Module                  Size  Used by    Not tainted
snd-pcm-oss            36260   0  (unused)
snd-mixer-oss          10016   0  (unused)
snd-seq-oss            24576   0  (unused)
snd-seq-midi-event      3592   0  [snd-seq-oss]
snd-seq                42828   2  [snd-seq-oss snd-seq-midi-event]
snd-seq-device          4000   0  [snd-seq-oss snd-seq]
snd-via8233             5028   0  (unused)
snd-pcm                55104   0  [snd-pcm-oss snd-via8233]
snd-timer              11808   0  [snd-seq snd-pcm]
snd-ac97-codec         23844   0  [snd-via8233]
snd                    29416   0  [snd-pcm-oss snd-mixer-oss snd-seq-oss=20
snd-seq-midi-event snd-seq snd-seq-device snd-via8233 snd-pcm snd-timer=20
snd-ac97-codec]
8139too                14848   1=20
mii                     1168   0  [8139too]


But when I try to play a file I get this error:

tussen root # aplay /usr/kde/3/share/sounds/pop.wav=20
Playing WAVE '/usr/kde/3/share/sounds/pop.wav' : Signed 16 bit Little End=
ian,=20
Rate 44100 Hz, Mono
ALSA lib pcm_hw.c:411:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed:=20
Input/output error


My /proc/pci:

tussen root # cat /proc/pci
PCI devices found:
<rip>
  Bus  0, device  17, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio=
=20
Controller (rev 64).
      IRQ 11.
      I/O at 0xe000 [0xe0ff].
<rip>


My ALSA version:

tussen root # cat /proc/asound/version=20
Advanced Linux Sound Architecture Driver Version 0.9.0rc1.
Compiled on May 14 2002 for kernel 2.4.19-gentoo-r5 (SMP) with versioned=20
symbols.


Will the VIA8233A chipset be supported soon? There are more people with t=
he=20
same problem, see also=20
http://forums.viaarena.com/messageview.cfm?catid=3D28&threadid=3D13756
Please can you help us?

Thanks in advance,

Niek van der Maas.

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net

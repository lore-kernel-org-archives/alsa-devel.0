From: Mark Knecht <markknecht@attbi.com>
Subject: aplay: pcm_write:1025: write error &
 SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
Date: 18 May 2003 17:05:32 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053302732.1749.6.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   I brought up Alsa Friday on a Gentoo platform and used it for most of
Friday evening and Saturday in one form or another. Along the way I was
building some new kernels to fix some SCSI issues and a few other items,
which required that Alsa get rebuilt also as per the Gentoo Alsa
instructions. This process went on for most of the day. Later Saturday
evening, following who knows how many 'unrelated' changes, Alsa stopped
working. The error messages look like this:

Wizard root # aplay wave/sequen~1.wav 
Playing WAVE 'wave/sequen~1.wav' : Signed 16 bit Little Endian, Rate
44100 Hz, Mono
aplay: pcm_write:1025: write error: Input/output error
Wizard root # 

or when trying to play a game like frozen-bubble, that app locks up hard
and in my console I see:

ALSA Lib pcm_hw.c:467:(snd_pcm_hw_prepare)SNDRV_PCM_IOCTL_PREPARE
failed:device or resource busy

alsaplayer starts to run, sees the CD (I.e. - shows track length) and
then won't play the CD.

I'll attach a bit of data, but can anyone point me toward what might be
causing this? 

-- LSPCI

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235 AC97 Audio Controller (rev 50)
        Subsystem: Asustek Computer, Inc. A7V8X Motherboard (Realtek
ALC650 codec)
        Flags: medium devsel, IRQ 22
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2


-- LSMOD

Wizard modules.d # lsmod
Module                  Size  Used by    Not tainted
sr_mod                 14296   0  (autoclean)
ide-scsi                7536   0 
agpgart                11920   0  (autoclean) (unused)
ide-cd                 27080   0  (autoclean)
cdrom                  25984   0  (autoclean) [sr_mod ide-cd]
snd-via82xx            11692   0 
snd-ac97-codec         34624   0  [snd-via82xx]
snd-mpu401-uart         3456   0  [snd-via82xx]
snd-rawmidi            14432   0  [snd-mpu401-uart]
snd-seq-device          4192   0  [snd-rawmidi]
snd-pcm                60928   0  [snd-via82xx]
snd-timer              15240   0  [snd-pcm]
snd                    30852   0  [snd-via82xx snd-ac97-codec
snd-mpu401-uart snd-rawmidi snd-seq-device snd-pcm snd-timer]
snd-page-alloc          4908   0  [snd-via82xx snd-pcm]
Wizard modules.d # 



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge

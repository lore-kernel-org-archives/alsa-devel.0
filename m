From: Richard Cochran <cochran@cs.umass.edu>
Subject: i810 - no sound from cvs snapshot
Date: Thu, 10 Jul 2003 20:23:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030710202320.A25614@loki.cs.umass.edu>
References: <PM.9386.1053461408@pmweb11.uk1.bibliotech.net> <XFMail.20030521093456.pochini@shiny.it> <20030521104349.A793@loki.cs.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030521104349.A793@loki.cs.umass.edu>; from cochran@loki.cs.umass.edu on Wed, May 21, 2003 at 10:43:49AM -0400
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

I post this here because I _want_ to contribute to alsa development,
but I never can get alsa working to even begin. And no, I'm not a
moron (I hope). Here is what I did:

1. I got the 2003-06-29.tar file, and I was pleased and suprised when
it compiled without errors (except alsa-tools, but that looks
unimportant).

2. I ran alsa-driver/snddevices.

3. I loaded the modules:  lsmod |grep snd
snd-intel8x0           17888   0 
snd-mpu401-uart         3584   0  [snd-intel8x0]
snd-rawmidi            14304   0  [snd-mpu401-uart]
snd-seq                41580   0  (unused)
snd-seq-device          4212   0  [snd-rawmidi snd-seq]
snd-ac97-codec         36368   0  [snd-intel8x0]
snd-pcm                66080   0  [snd-intel8x0]
snd-page-alloc          6116   0  [snd-intel8x0 snd-pcm]
snd-hwdep               5280   0 
snd-timer              16448   0  [snd-seq snd-pcm]
snd                    35424   0  [snd-intel8x0 snd-mpu401-uart snd-rawmidi snd-seq snd-seq-device snd-ac97-codec snd-pcm snd-hwdep snd-timer]

4. Installed alsa-lib into /usr/local.

5. Ran 'aplay -D hw:0,0 alone.wav', this produces:

ALSA lib pcm_hw.c:1055:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Invalid argument
aplay: main:484: audio open error: Invalid argument

What am I doing wrong? Thanks,

Richard

Other diagnostics:

ls -l /dev/snd/pcmC0D0p
crw-rw----    1 root     audio    116,  16 Jul  5 07:34 /dev/snd/pcmC0D0p

tail syslog
Jul 10 20:10:59 muse kernel: PCI: Enabling device 00:1f.5 (0000 -> 0001)
Jul 10 20:10:59 muse kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Jul 10 20:10:59 muse kernel: intel8x0: clocking to 48000
Jul 10 20:11:36 muse kernel: ALSA pcm_native.c:1789: BUG? (err >= 0) (called from d8922afa)
Jul 10 20:11:36 muse kernel: ALSA pcm_native.c:1923: snd_pcm_hw_constraints_complete failed

cat /proc/asound/cards   
0 [I82801CAICH3   ]: ICH - Intel 82801CA-ICH3
                     Intel 82801CA-ICH3 at 0x1c00, irq 9

cat /proc/asound/pcm     
00-00: Intel ICH : Intel 82801CA-ICH3 : playback 1 : capture 1



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1

From: Dmitry Astapov <adept@umc.com.ua>
Subject: Sound freezes on Toshiba 5105 (snd-intel8x0) - I want to help
 debug/fix it
Date: Tue, 24 Dec 2002 18:14:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87n0mvpf70.fsf@dimail.umc.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


Hello,

Short summary: I have notebook with ALSA-compatible soundcard (supported by
snd-intel8x0 module). Once in a while sound just freezes (along with an
application which tries to issue it) and no sooner than I kiil that
application and restart it I am able to hear sound again. I want to help
debug/fix that problem. I have no knowledge whatsoever about ALSA
internals, but I can compile, run, strace, debug any kind of code for
anybody wanting to help.

Longer description:

First of all, sound playback is ... how to say it? scratchy, or something
like that. From time to time i head clicks and micro-pauses. But, even
worth, sometimes programs just get stuck trying to do some sound, all I
hear is last sample repeating endlessly, and I have to kill that program
and restart it. Programs that use ALSA hang rarely, programs try to use
/dev/dsp (OSS emulation) hang more often, though i cannot reliably
reproduce that. Quake3 either complains about "unable to open /dev/dsp,
Broken pipe", or always freezes at start of the game if I do echo
'quake3.x86 0 0 direct' > /proc/asound/card0/pcm0p/oss, and quake3 is the
only thing that hangs every time I use it. Can I use it to gather some
valuable debugging data?


Background info:

Notebook: Toshiba 5105

Sound card:
Windows reports it as "Yamaha AC-XG", lcpsi shows:

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
        Subsystem: Toshiba America Info Systems: Unknown device 0002
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1400 [disabled] [size=256]
        Region 1: I/O ports at 1040 [disabled] [size=64]

Kernel: 2.4.20 (from Debian, package 2.4.20-686-3. Almost patchless)

ALSA: 0.9.0rc6, built from sources


-- 
Dmitry Astapov //ADEpt                               E-mail: adept@umc.com.ua
GPG KeyID/fprint: F5D7639D/CA36 E6C4 815D 434D 0498  2B08 7867 4860 F5D7 639D


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

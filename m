From: Brix <brix82@libero.it>
Subject: SBLive midi synth + ALSA doesn't work.
Date: Sun, 31 Aug 2003 18:04:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030831180443.10bba610.brix82@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!
I'm an (italian, so my english is not very good..)  debian woody user, I'm interested in developing an "ear trainer" using MIDI under ALSA but i'm unsuccessfully trying to get my SBLive 1024 midi synth to work.
I installed ALSA-0.9.2 and ALSA-0.9.6 on my linux-2.4.18, 2.4.19 and 2.4.20 system following instructions on the alsa page:
http://www.alsa-project.org/alsa-doc/doc-php/template.php3?company=Creative+Labs&card=Soundblaster+Live&chip=EMU10K1&module=emu10k1.
After loading modules: snd-emu10k1, snd-pcm-oss, snd-mixer-oss, snd-seq-oss i can listen to CDs, play music etc. but not use the MIDI synth device.
I then followed instructions on http://www.ibiblio.org/mdw/linuxfocus/English/September2002/article259.shtml#259lfindex4 about midi on SBLive.
I installed sfxload, loaded soundfonts from the SBLive CD without errors, but the command `pmidi -l` returns me nothing, and `playmidi` tells me:

	jazz:~$ playmidi ~brix/test.mid 
	Playmidi 2.4 Copyright (C) 1994-1997 Nathan I. Laredo, AWE32 by Takashi Iwai
	This is free software with ABSOLUTELY NO WARRANTY.
	For details please see the file COPYING.
	playmidi: No playback device found.

Doing a `strace pmidi -l` gives me, in particular, this:

	open("/dev/snd/seq", O_RDWR)            = 3

and then a bunch off

	ioctl(3, 0xc0dc5310, 0xbffff91c)        = -1 ENOTTY (Inappropriate ioctl for device)

It seems the driver doesn't accept the ioctl().
However, the midi editor "rosegarden" works pretty fine.

Here is the list of the modules i loaded, obtained with `lsmod | grep snd`:

snd-seq-midi            3328   0  (autoclean)
snd-emu10k1-synth       3712   0  (autoclean)
snd-emux-synth         23228   0  (autoclean) [snd-emu10k1-synth]
snd-seq-midi-emul       4432   0  (autoclean) [snd-emux-synth]
snd-seq-virmidi         2648   0  (autoclean) [snd-emux-synth]
snd-emu10k1            59204   0  (autoclean) [snd-emu10k1-synth]
snd-rawmidi            12384   0  (autoclean) [snd-seq-midi snd-seq-virmidi snd-emu10k1]
snd-ac97-codec         34400   0  (autoclean) [snd-emu10k1]
snd-hwdep               4384   0  (autoclean) [snd-emu10k1]
snd-util-mem            1200   0  (autoclean) [snd-emux-synth snd-emu10k1]
snd-seq-oss            23104   0 
snd-seq-midi-event      3232   0  [snd-seq-midi snd-seq-virmidi snd-seq-oss]
snd-seq                36396   2  [snd-seq-midi snd-emux-synth snd-seq-midi-emul snd-seq-virmidi snd-seq-oss snd-seq-midi-event]
snd-seq-device          3764   0  [snd-seq-midi snd-emu10k1-synth snd-emux-synth snd-emu10k1 snd-rawmidi snd-seq-oss snd-seq]
snd-pcm-oss            35876   0 
snd-pcm                55904   0  [snd-emu10k1 snd-pcm-oss]
snd-page-alloc          5572   0  [snd-emu10k1 snd-pcm]
snd-timer              13888   0  [snd-seq snd-pcm]
snd-mixer-oss          11232   0  [snd-pcm-oss]
snd                    27744   0  [snd-seq-midi snd-emux-synth snd-seq-virmidi snd-emu10k1 snd-rawmidi snd-ac97-codec snd-hwdep snd-util-mem 
snd-seq-oss snd-seq-midi-event snd-seq snd-seq-device snd-pcm-oss snd-pcm snd-timer snd-mixer-oss]
soundcore               3492  10  [snd]

And here is my card in `lspci` :

00:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs: Unknown device 8061
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at b400 [size=32]
        Capabilities: [dc] Power Management version 1

00:07.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at b000 [size=8]
        Capabilities: [dc] Power Management version 1

Every person i talk with is telling me that this card works fine... i hope you can help me!
Thanks in advance,

	Marco

-- 

	Hardware is never old.
	People just choose the wrong OS.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

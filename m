From: Han-Solo <serge.najdyk@laposte.net>
Subject: -- no soundcards --
Date: Tue, 09 Apr 2002 23:16:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CB35A3C.2090103@laposte.net>
Reply-To: serge.najdyk@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.laposte.net (nposte09.axime.com [160.92.113.114])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA00430
	for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2002 00:08:44 +0200
Received: from laposte.net (80.13.231.166) by mail.laposte.net (5.5.044)
        id 3CB2AF0B00018502 for alsa-devel@alsa-project.org; Tue, 9 Apr 2002 23:16:42 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,

I could not make my audigy work with the 5.12a driver. The following
message shows up in /var/log/messages :

snd: EMU10K1 soundcard #1 not found or device busy

My kernel is compiled with CONFIG_SOUND=m and CONFIG_SOUND_OSS=m

The driver was compiled with these options :
./configure --with-oss=yes --with-cards=emu10k1 --with-debug=detect

I disabled devfsd in lilo.conf (yes, it is a Mandrake) and launched
snddevices after installation, changed the perms of /dev/mixer,
/dev/dsp, /dev/audio, put the following lines into modules.conf :

alias char-major-116 snd
alias snd-card-0 snd-card-emu10k1
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

lspci -v gives :
...
00:0f.0 Multimedia audio controller: Creative Labs: Unknown device 0004
(rev 03)	Subsystem: Creative Labs: Unknown device 0053
	Flags: bus master, medium devsel, latency 32, IRQ 4
	I/O ports at c400 [size=32]
	Capabilities: [dc] Power Management version 2

cat /proc/interrupts
     0:     228061          XT-PIC  timer
     1:       2688          XT-PIC  keyboard
     2:          0          XT-PIC  cascade
     5:       1290          XT-PIC  usb-uhci
     8:          1          XT-PIC  rtc
    10:     167420          XT-PIC  nvidia
    11:       9658          XT-PIC  ide2
    12:      74372          XT-PIC  PS/2 Mouse
    14:         35          XT-PIC  ide0
    15:         40          XT-PIC  ide1
NMI:          0
LOC:     228026
ERR:          0
MIS:          0
(dont't know if this is OK. Should I see a line for IRQ 4 ?)

cat /proc/ioports
...
c400-c41f : PCI device 1102:0004 (Creative Labs)
c800-c807 : PCI device 1102:7003 (Creative Labs)

cat /proc/asound/cards gives : "-- no soundcards --" (hence the subject)

I read lots of stuff using google, tried a few things. My last attempt
was to replace snd-emu10k1 by snd-card-emu10k1, though I got no errors
(and still -- no soundcards -- ) with snd-emu10k1.
The alsaconf script could not detect my card.

The card works with the OSS module in the kernel, and under Windows.

Did I forget something ? Please, tell me what's wrong !

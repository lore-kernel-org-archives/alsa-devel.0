From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Fri, 13 Dec 2002 12:15:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF9C14C.4010204@gmx.de>
References: <3DF8A109.2030206@gmx.de>	<s5hel8nuvee.wl@alsa2.suse.de>	<3DF8B8FA.3040009@gmx.de> <s5h3cp3uorz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

 >you can check this also via lspci command.
 >in the output of lspci in your last mail, the i/o ports and irq are
 >missing.  please check again?
 >
here we go...

00:0b.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A
[FM801] (rev a0)
        Subsystem: Fortemedia, Inc: Unknown device 1319
        Flags: bus master, medium devsel, latency 40, IRQ 10
        I/O ports at ec00 [size=128]
        Capabilities: [dc] Power Management version 1

00:0b.1 Input device controller: Fortemedia, Inc Xwave QS3000A [FM801]
(rev a0)
        Subsystem: Fortemedia, Inc: Unknown device 1319
        Flags: bus master, medium devsel, latency 40, IRQ 11
        Capabilities: [dc] Power Management version 1

the first entry seems to be the audio functionality, the second one must
be the game port.
IRQ 10 is shared with USB controller, IRQ 11 is shared with VGA controller.

 >>The soundcard is working correctly under win98 without the need to
 >>change any hardware or bios settings.
 >>win98 reports:
 >>fm801 pci audio, IRQ 10, I/O: EC00-EC7F
 >>plus
 >>fm801 pci audio, IRQ 11
 >>and 'no conflicts'. I.e. win98 shows up the same IRQs used as lspci,
 >>that should be correct, then. But lspci doesn't name any memory regions
 >>used by this card. Do you have any idea what I could try? (I'll test
 >>some other bios settings, mounting the card in another slot when I find
 >>some spare time).
 >>   
 >>
 >
 >what is the bios configuration?  pnp os is yes?  then set it to no.
 >is ACPI enabled on kernel?
 >
 >
pnp was set to 'yes' in bios. I set it to 'no', but the system still
locks after loading alsa driver. To be more precisely: I did modprobe
snd-fm801, started aplay, stopped aplay, started arecord and after some
seconds the system hang. But the system hang just some seconds after
modprobing without using the audio device in a try before.
Here's the /var/log/messages output before(after) the system hangs:
Dec 12 19:13:27 localhost kernel: PCI: Found IRQ 10 for device 00:0b.0
Dec 12 19:13:27 localhost kernel: PCI: Sharing IRQ 10 with 00:07.2
Dec 12 19:13:27 localhost kernel: PCI: Sharing IRQ 10 with 00:07.3
Dec 12 19:13:27 localhost kernel: PCI: Found IRQ 11 for device 00:0b.1
Dec 12 19:13:27 localhost kernel: ALSA ../alsa-kernel/pci/fm801.c:922:
unable to grab region 0x0-0x7f
Dec 12 19:14:56 localhost syslogd 1.4.1: restart.

ACPI is not enabled in kernel (but APM is, which should not be a
problem, I think).
Any further hints? I just don't want to crash my filesystems too often.
Hopefully, ext3 does its job.
Ahh! Perhaps I should remount read-only next time :-)
fe




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

From: Eric Benson <eric_a_benson@yahoo.com>
Subject: Analog Devices AD1887 support
Date: Mon, 01 Jul 2002 12:13:05 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D20A9C1.2080608@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, eric_a_benson@yahoo.com
List-Id: alsa-devel@alsa-project.org



I'm trying to get sound working on an IBM NetVista X41 model 2283, an Intel P4 all-in-one computer with limited expansion capability (no full-size PCI slots). I built Alsa from CVS on Red Hat 7.3, kernel 2.4.18-5. This unit has the Analog Devices AD1887 chip on the motherboard. I specified snd-intel8x0 in /etc/modules.conf. The module loads, I unmuted and set levels in the mixer, audio applications appear to work, but no sound comes out. I suspect this is very close to working, but I don't know where to proceed from here. The soundcard matrix mentions the AD1885 and AD1886 but not the AD1887. Has anyone got this chipset working yet?

If someone can guide me in the right direction I can probably get this working myself, assuming the changes are small relative to the existing AD188x chips.

This message shows up in /var/log/messages:
Jun 22 13:52:14 xp2 kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Jun 22 13:52:16 xp2 kernel: intel8x0: clocking to 41138

And this is from /proc/pci:
Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 18).
      IRQ 5.
      I/O at 0x1c00 [0x1cff].
      I/O at 0x1880 [0x18bf].






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

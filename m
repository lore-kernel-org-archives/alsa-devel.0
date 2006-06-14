From: CARON Dominique <d.caron@LPTA.univ-montp2.fr>
Subject: Sound Card On Dell Precision 380 (Intel ICH7)
Date: Wed, 14 Jun 2006 20:41:35 +0200
Message-ID: <20060614204135.i1iikwsok80kwwgw@www.lpta.univ-montp2.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
Thank's to you for your wonderfull work...
I've some problem to have sound on My Dell Precision 380.
Here are some infos:

lspci : (just sound card)
00:1b.0 Class 0403: Intel Corp. 82801G (ICH7 Family) High Definition  =

Audio Controller (rev 01)
         Subsystem: Dell: Unknown device 01a8
         Flags: fast devsel, IRQ 169
         Memory at febfc000 (64-bit, non-prefetchable) [size=3D16K]
         Capabilities: [50] Power Management version 2
         Capabilities: [60] Message Signalled Interrupts: 64bit+  =

Queue=3D0/0 Enable-
         Capabilities: [70] Express Unknown type IRQ 0
         Capabilities: [100] Virtual Channel
         Capabilities: [130] Unknown (5)


The true identifier of the pci chipset is : 27d8 (but I add it to the  =

pci.ids file to be more clear)...

I'm Running on RHEL4 (aka Scientific Linux 4) with 2.6.9-34.0.1.ELsmp
After make some changes (only one) in include/adriver.h about gft_p to  =

turn around the bad RHEL kernel version number, I was able to compile  =

your last alsa-driver release (alsa-driver-1.0.11-1)...
But Still My sound card want sound !!

When i modprobe snd-hda-intel, dmesg show me :

ACPI: PCI interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA  =

/var/tmp/bach-build/BUILD/alsa-driver-1.0.11/pci/hda/../../alsa-kernel/pci/=
hda/hda_intel.c:1539: hda-intel: no codecs  =

found!


I'd (average) the same message with the Dell snd-hda-intel driver  =

(snd-hda-intel-1.0.6p-8)
which is probably anything but an alsa-driver in a previous release),  =

and also with the original snd-azx from RHEL (which is also an alsa  =

driver!)...

It sound like the chip attached to the ICH7 hub (the famous Dell:  =

Unknown device 01a8) is not recognize .. is'nt it ?

May this can help you ...if you can't help me ;-).

Best regards and sorry for my frenglish


-- =

CARON Dominique         UNIVERSITE DE MONTPELLIER II
http://www.lpta.univ-montp2.fr/caron/
  ---- PLEASE NO WORD ATTACHMENTS:
http://www.gnu.org/philosophy/no-word-attachments.fr.html

----------------------------------------------------------------
Ce message vous a =E9t=E9 transmis gr=E2ce =E0 IMP, le WebMail de HORDE
(www.horde.org).

From: Pavel Kysilka <goldenfish@bsys.cz>
Subject: nonstandart ENS1370 - bug
Date: Sun, 6 Feb 2005 02:07:15 +0100
Message-ID: <20050206010714.GA2149@prog3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

	Hi all,

i have ensoniq1370 based pci sound card.

this card have bad pci identification.

0000:00:0a.0 Non-VGA unclassified device: Unknown device 0001:0400 (prog-if 20)
	Subsystem: Unknown device 4942:4c4c

card looks as:

X	4C4C4942	Creative Sound Blaster AudioPCI 64


i found some error with this card.

1) i load module snd-ens1370.

driver is loaded, but in /proc/asound no data about this card.
i cannot play any sound file.

2) i look in the source code file ens1370.c and i add this code.
/* ******************************************************************** */

--- linux-2.6.11-rc3/sound/pci/ens1370.c	2005-02-03 02:56:33.000000000 +0100
+++ /usr/src/linux-2.6.11-rc3/sound/pci/ens1370.c	2005-02-06 01:24:34.000000000 +0100
@@ -439,6 +439,7 @@
 static struct pci_device_id snd_audiopci_ids[] = {
 #ifdef CHIP1370
 	{ 0x1274, 0x5000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* ES1370 */
+	{ 0x0001, 0x0400, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* bogus ES1370 */
 #endif
 #ifdef CHIP1371
 	{ 0x1274, 0x1371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* ES1371 */

/* ****************************************************************** */

modules are loaded. in directory /proc/asound are data about this card.
alsamixer working with playback (F3). with recording (F4) not working - it is
not possible manupulate with volume indicator.

sound: input - Line-In or Microphone not working (tested with radio card).
	pcm - i play mp3 file.
console show this 3-times repeated message and computer totally freeze.

Feb  5 02:08:31 prog3 kernel: ALSA sound/core/pcm_lib.c:158: BUG: stream = 0, pos = 0xffff, buffer size = 0x4000, period size = 0x800

Environment:
Linux - 2.6.11-rc3 vanilla kernel
distro: Debian testing
alsa - 1.0.8 from this distro

in the .bz2 attachment:
lspci -vvv about this card
lspci -xxx about this card
/proc/asound
lsmod output

thanks for your time.
sorry for my bad english.

  bye
    pavel kysilka
     programmer http://www.bsys.cz/


________ Information from NOD32 ________
This message was checked by NOD32 Antivirus System for Linux Mail Server.

http://www.nod32.com

--HlL+5n6rz5pIUxbD
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ens1370_bug.tar.bz2"
Content-Transfer-Encoding: base64

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

--HlL+5n6rz5pIUxbD--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

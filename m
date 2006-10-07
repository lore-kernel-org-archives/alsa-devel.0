From: albox@free.fr
Subject: Re: Issue with Intel HDA Sound card 82801G
	(laptop	Medion)
Date: Sun, 08 Oct 2006 01:00:39 +0200
Message-ID: <1160262039.45283197cf7cd@imp5-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: tdavis@dsl-only.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"Is this ALSA 1.0.13-rc3, or a patched ALSA from Realtek?"
=> It ALSA, not a patched version.

It's weird because now, I get this error :
[17179588.420000] ALSA
/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:680:
codec_mask = 0x3
[17179588.596000] hda_codec: Unknown model for ALC883, trying auto-probe from
BIOS...
[17179588.644000] ALSA
/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:2164:
autoconfig: line_outs=3 (0x14/0x15/0x16/0x0/0x0)
[17179588.644000] ALSA
/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:2168:
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[17179588.644000] ALSA
/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:2172:
   hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[17179588.644000] ALSA
/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/hda_codec.c:2180:
   inputs: mic=0x0, fmic=0x18, line=0x1a, fline=0x0, cd=0x0, aux=0x0
[17179589.092000] NET: Registered protocol family 17
[17179589.392000] ALSA
/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.13/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245:
si3054: cannot initialize. EXT MID = 0000
[17179589.392000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[17179589.392000] HDA Intel: probe of 0000:00:1b.0 failed with error -13

$ aplay -l
aplay: device_list:218: no soundcards found...

$ alsamixer
alsamixer: function snd_ctl_open failed for default: No such file or directory

I don't understand why I get this error :-(

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

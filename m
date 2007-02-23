From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Question regarding Sigmatel STAC 9202 and alsa
	1.0.14rc2 (latest development release)
Date: Fri, 23 Feb 2007 09:50:06 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB54194859F673C@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

Hello:
 
I am trying to run the latest Alsa development release (1.0.14rc2) on a
system
that has a Sigmatel STAC 9202 Codec in it.

The Codec is wired in the system as follows:

	1. There is a digital microphone (DMIC) connected to DMIC_L,
DMIC_R, and DMIC_CLK
	2. There are internal speakers (and amplifier) connected to
PORTA_R and PORTA_L
	3. There is a headphone jack connected to PORTD_R and PORTD_L as
well as GPIO_1
	4. PORTB and PORTC are not being used at this time.

Essentially, there is a digital microphone for input, but no analog
inputs are used.

After I run alsaconf, I notice there are no cards listed in
/proc/asound/cards and 
alsamixer does not start (it says that it cannot open the device.

I also get the following output from the dmesg command:

============================================================

 [17179585.428000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/hda_intel.c:696: codec_mask = 0x1
[17179585.536000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:1802: hda_codec: Unknown model for STAC925x,
using BIOS defaults
[17179585.540000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 07 bios pin config
01c10014
[17179585.544000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 08 bios pin config
01410013
[17179585.548000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0a bios pin config
01210011
[17179585.552000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0b bios pin config
01a10021
[17179585.556000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0c bios pin config
01810022
[17179585.560000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0d bios pin config
01010012
[17179585.564000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 10 bios pin config
01010031
[17179585.568000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/
pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 11 bios pin config
01310023
[17179585.608000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:2171:
autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
[17179585.608000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:2175:
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[17179585.608000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:2179:
hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[17179585.608000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:2187:
inputs: mic=0xb, fmic=0x0, line=0xc, fline=0x0, cd=0x11, aux=0x0
[17179585.696000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/acore/control.c:333:
control 2:0:0:Master Playback Volume:0 is already present
[17179585.696000] HDA Intel: probe of 0000:00:1b.0 failed with error -16

========================================================================
===

Looking at this, as well as looking at the code in patch_sigmatel.c, it
appears that the
STAC 9202 is considered part of the STAC 925x family. It seems to find
the pin configs
from the BIOS okay, but there are two error messages at the end. 

Do any of you know what those error messages mean? 

Is there any later development version of the code that might have a
solution to this?

Thank you very much

Mark Allyn

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

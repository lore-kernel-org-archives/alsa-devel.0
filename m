From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Re: Digital Microphones (DMICS) on Intel HD Audiowith
	Sigmatel Codecs
Date: Fri, 23 Feb 2007 18:19:39 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB54194859F6C08@fmsmsx411.amr.corp.intel.com>
References: <1172274852.1575.34.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
In-Reply-To: <1172274852.1575.34.camel@razman.gruemaster.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: mporter@embeddedalley.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tobin:
 
I was unable to load the driver on this system. There was an error
message from ALSA 
(which I sent an earlier email on the list.
 
The lspci entry for the device is:
 
00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High
Definition Audio
 Controller (rev 02)
 
Here is the dmesg output from alsa when I attempted to get at the
device. Because of 
this, there is nothing in /proc/asound/card0 as /proc/asound/cards shows
no cards.

========================================================================
===

[17179585.428000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/hda_intel.c:696: codec_mask = 0x1
[17179585.536000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:1802: hda_codec: Unknown model
for STAC9
25x, using BIOS defaults
[17179585.540000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 07 bios
pin conf
ig 01c10014
[17179585.544000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 08 bios
pin conf
ig 01410013
[17179585.548000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0a bios
pin conf
ig 01210011
[17179585.552000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0b bios
pin conf
ig 01a10021
[17179585.556000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0c bios
pin conf
ig 01810022
[17179585.560000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 0d bios
pin conf
ig 01010012
[17179585.564000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 10 bios
pin conf
ig 01010031
[17179585.568000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/../
../alsa-kernel/pci/hda/patch_sigmatel.c:704: hda_codec: pin nid 11 bios
pin conf
ig 01310023
[17179585.608000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda
_codec.c:2171: autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
[17179585.608000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda
_codec.c:2175:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[17179585.608000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda
_codec.c:2179:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[17179585.608000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/pci/hda/hda
_codec.c:2187:    inputs: mic=0xb, fmic=0x0, line=0xc, fline=0x0,
cd=0x11, aux=0
x0
[17179585.696000] ALSA
/mnt1/src/asianux/BUILD/alsa-driver-1.0.14rc2/acore/contr
ol.c:333: control 2:0:0:Master Playback Volume:0 is already present
[17179585.696000] HDA Intel: probe of 0000:00:1b.0 failed with error -16

Mark

________________________________

From: Tobin Davis [mailto:tdavis@dsl-only.net] 
Sent: Friday, February 23, 2007 3:54 PM
To: Allyn, Mark A
Cc: alsa-devel@lists.sourceforge.net; mporter@embeddedalley.com
Subject: Re: [Alsa-devel] Digital Microphones (DMICS) on Intel HD
Audiowith Sigmatel Codecs


I think Matt Porter was working on some systems with that last year.
Not sure what happened to him, as I haven't seen any patches since early
January.  He submitted some digital mic patches against the 9205 codec
code.

I could probably whip something together for you next week.  Send me the
system specs (lspci -s 0:1b -vn and cat /proc/asound/card0/codec*) and
I'll get on it.

Tobin

On Fri, 2007-02-23 at 15:37 -0800, Allyn, Mark A wrote: 

	Hello:
	 
	Do any of you know if anyone has ever had alsa working with a
digital
	microphone
	on a Sigmatel Codec within the Intel HAD device working; ie; a
digital
	microphone
	only, that does not go through the normal analog input and mux?
	
	Thank you
	
	Mark Allyn
	
	
------------------------------------------------------------------------
-
	Take Surveys. Earn Cash. Influence the Future of IT
	Join SourceForge.net's Techsay panel and you'll get the chance
to share your
	opinions on IT & business topics through brief surveys-and earn
cash
	
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
	_______________________________________________
	Alsa-devel mailing list
	Alsa-devel@lists.sourceforge.net
	https://lists.sourceforge.net/lists/listinfo/alsa-devel
	

-- 
Tobin Davis <tdavis@dsl-only.net> 	

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

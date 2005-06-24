From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001209]: Headphone and Front Mic are switched
Date: Fri, 24 Jun 2005 21:54:26 +0200
Message-ID: <3569d91a93282fa6c4c76f21450328ee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E231222
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 21:54:27 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1209> 
======================================================================
Reported By:                alfred-ganz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1209
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-23-2005 20:02 CEST
Last Modified:              06-24-2005 21:54 CEST
======================================================================
Summary:                    Headphone and Front Mic are switched
Description: 
I installed alsa-driver-1.0.9b.tar.bz2, and the back panel
assignments that I can test seem to be assigned properly.
However, there is some sound coming out of the front mike jack,
and input is accepted through the headphone jack. Since these
jacks work as expected with Windows XP, I suspect that they are
misassigned in the driver.
Hardware: RealTek ALC655 AC'97 with ALC880(D)

Please let me know if there is anything else that you need from
me.

Thank you, AG

======================================================================

----------------------------------------------------------------------
 alfred-ganz - 06-24-05 21:12 
----------------------------------------------------------------------
Here is what I get in the kernel logs:
kernel: ACPI: PCI interrupt 0000:00:1b.0[A] -> GSI 10 (level, low) -> IRQ
10
kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
kernel: ALSA /home/fedora-3/cvs/alsa-driver/pci/hda/hda_codec.c:1549:
hda_codec: model 'test' is selected
kernel: ALSA /home/fedora-3/cvs/alsa-driver/acore/control.c:325: control
2:0:0:CLFE Playback Volume:0 is already present
kernel: HDA Intel: probe of 0000:00:1b.0 failed with error -16

What do I do now??

----------------------------------------------------------------------
 alfred-ganz - 06-24-05 21:54 
----------------------------------------------------------------------
When I rebuilt with --with-debug=full, but then loaded snd-hda-intel
with model=5stack, Front/LineOut, SideSurround, RearSurround, and 
CenterSurround work all fine, I don't understand why it is different
with the debug enabled code?? Also, Front panel Headphone and Front
panel Mic don't work right yet.
Questions:
Why did things change between the vailla build and the debug build?
Note that alsamixer shows different channels than before, there are now
three Capture channels, and the Headphone channel no longer has volume
control.
Why do I have to use a different order of mod=probe's in order to
avoid error messages (currently snd, snd-page-alloc, snd-pcm,
snd-hda-codec,
and finally snd-hda-intel)?
How do I find out how to change assignments for the Front panel jacks,
and how is this information saved to carry it over reboot?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-05 20:02 alfred-ganz    New Issue                                    
06-23-05 22:35 alfred-ganz    Note Added: 0005195                          
06-23-05 23:21 alfred-ganz    Note Added: 0005197                          
06-23-05 23:29 erik           Note Added: 0005198                          
06-23-05 23:55 alfred-ganz    Note Added: 0005201                          
06-24-05 11:13 tiwai          Note Added: 0005211                          
06-24-05 15:42 alfred-ganz    Note Added: 0005229                          
06-24-05 15:46 tiwai          Note Added: 0005230                          
06-24-05 16:07 alfred-ganz    Note Added: 0005231                          
06-24-05 16:34 tiwai          Note Added: 0005234                          
06-24-05 16:42 alfred-ganz    Note Added: 0005235                          
06-24-05 16:54 alfred-ganz    Note Added: 0005236                          
06-24-05 17:26 alfred-ganz    Note Added: 0005240                          
06-24-05 17:48 tiwai          Note Added: 0005243                          
06-24-05 19:14 alfred-ganz    Note Added: 0005250                          
06-24-05 20:01 alfred-ganz    Note Added: 0005251                          
06-24-05 20:07 tiwai          Note Added: 0005252                          
06-24-05 21:12 alfred-ganz    Note Added: 0005253                          
06-24-05 21:54 alfred-ganz    Note Added: 0005254                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

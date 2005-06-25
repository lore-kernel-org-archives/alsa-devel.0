From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001209]: Headphone and Front Mic are switched
Date: Sat, 25 Jun 2005 21:28:21 +0200
Message-ID: <d7ffaa73ccf3dcf8cf4737cffe83e88f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BC8401CF
	for <alsa-devel@alsa-project.org>; Sat, 25 Jun 2005 21:28:21 +0200 (MEST)
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
Last Modified:              06-25-2005 21:28 CEST
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

----------------------------------------------------------------------
 alfred-ganz - 06-25-05 21:28 
----------------------------------------------------------------------
In order to avoid the failure of snd-hda-intel with model=test, I have
selectively eliminated entries in alc880_test_mixer[] = {} in
alsa-kernel/pci/hda/patch_realtek.c. By deleting the entries for 
"CLFE Playback Volume", "Side Playback Volume", "Capture Volume",
"Capture Switch", "Capture Volume 1", "Capture Switch 1", and
"Input Source", I can build a module that loads without error, and
I can identify the 3 input sources, including the FrontMic, but I
have also eliminated a lot of stuff.

How can I get the missing stuff to work??

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
06-25-05 21:28 alfred-ganz    Note Added: 0005258                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

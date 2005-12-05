From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001618]: No Sound on Acer with Intel ICH6 HDA and Realtek ALC260
Date: Mon, 5 Dec 2005 19:35:22 +0100
Message-ID: <5a163a1ce8c1d1a0df938d78fbf9d646@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B668A169
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2005 19:35:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618> 
======================================================================
Reported By:                robertw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1618
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12-10-686
======================================================================
Date Submitted:             12-04-2005 21:24 CET
Last Modified:              12-05-2005 19:35 CET
======================================================================
Summary:                    No Sound on Acer with Intel ICH6 HDA and Realtek
ALC260
Description: 
I can load the snd-hda-intel module and play a file via aplay or xmms or
play a cd without any error, but I cannot hear anything neither via the
build-in speakers nor via headphones. All volume controllers are at 70%
and unmuted, except for PCM, because there is no mute/unmute-button.
======================================================================

----------------------------------------------------------------------
 jwoithe - 12-05-05 07:12 
----------------------------------------------------------------------
This sounds exactly like what I saw with a Fujitsu S7020 laptop earlier
this year.  The ALC260 sound chip has about a dozen identical audio I/O
pins which are somewhat arbitarily labeled as "CD" and "Line" (etc) by the
manufacturer.  While some system integrators go along with these labels,
others do not.  To fix the problem one must deduce which chip pins are
physically connected to the various I/O plugs on the laptop and then
define a mapping for that laptop in patch_realtek.c.  Once this is done
alsa mixer application (alsamixer for example) will do the right thing.

I went through this process by trial and error for the S7020 earlier this
year.  Essentially I defined a large number of mixer controls and hooked
one to each of the output widgets on the ALC260 (having the ALC260
datasheet is very helpful here).  When the resulting driver was loaded I
then used alsamixer to work out what each control/widget did (if
anything).  Finally I used the resultant information to define mixer
layout and initialisation details for the S7020.
  
There may be a better (streamlined) way of doing this but the above was
quick and worked for me.  Takashi may well have an easier way. :)

If you want more details contact me via the ALSA mailing list.

----------------------------------------------------------------------
 timmy - 12-05-05 19:35 
----------------------------------------------------------------------
I have exactly the same problem, with an Acer Travelmate 4064WLMi,
unfortunately. I even tried with the driver Realtek have, with no luck.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 21:24 robertw        New Issue                                    
12-04-05 21:24 robertw        Distribution              => Ubuntu 5.10     
12-04-05 21:24 robertw        Kernel Version            => 2.6.12-10-686   
12-05-05 07:12 jwoithe        Note Added: 0006908                          
12-05-05 19:35 timmy          Note Added: 0006914                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

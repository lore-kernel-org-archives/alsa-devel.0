From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001033]: hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Date: Thu, 29 Sep 2005 21:59:48 +0200
Message-ID: <63159e738c6b5e72a34fdec457100295@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B79D168
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 21:59:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1033> 
======================================================================
Reported By:                sjankie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1033
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             04-03-2005 15:07 CEST
Last Modified:              09-29-2005 21:59 CEST
======================================================================
Summary:                    hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Description: 
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

azx driver compliens about: NO AFG found.

alsmixer starts, but no sound.
======================================================================

----------------------------------------------------------------------
 Thomas - 04-08-05 21:08 
----------------------------------------------------------------------
After some tweakings (don't ask me exactly what I did, I changed lots of
stuff), I've got it working.

Some problems though. Headphone and my laptop speaker are not working.
"Front" output works but there is lot of noise.
"Surround" "Center/LFE" don't work. It might be normal as "Front" is not
plugged.

I can't test inputs.

----------------------------------------------------------------------
 slack_kid - 09-29-05 21:59 
----------------------------------------------------------------------
I am currently haveing the same issue wiht my Intel HDA Azalia Hardware. I
purchased a Sager NP 3880 SUPRA recently, and sound is the only problem i
have had thus far.  

The modules compiles, and loads without any errors except:

ALSA sound/pci/hda/hda_codec.c:511: hda_codec: no AFG node found

in dmesg output.  XMMS and all sound programs see the card and act as
though nothing is wrong, but there is  no sound at all. I unmuted all the
channels and turned them up so that if anythign was working i could hear
it, but nothing worked.  I am curently running the 2.6.12 kernel, i
believe it is the vanilla sources, just standard 2.6.12 from kernel.org



Any help is much appreciated

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-05 15:07 sjankie        New Issue                                    
04-03-05 15:07 sjankie        Kernel Version            => 2.6.11.6        
04-03-05 15:08 sjankie        Issue Monitored: sjankie                     
04-03-05 15:08 sjankie        Issue End Monitor: sjankie                    
04-03-05 15:08 sjankie        Issue Monitored: sjankie                     
04-04-05 17:09 1g0R           Note Added: 0004328                          
04-05-05 14:52 sjankie        Note Added: 0004337                          
04-05-05 18:48 Thomas         Issue Monitored: Thomas                      
04-05-05 19:50 Thomas         Note Added: 0004339                          
04-08-05 21:08 Thomas         Note Added: 0004373                          
04-15-05 09:06 Thomas         Issue End Monitor: Thomas                    
09-29-05 21:59 slack_kid      Note Added: 0006424                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

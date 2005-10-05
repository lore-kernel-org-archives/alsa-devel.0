From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001033]: hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Date: Wed, 5 Oct 2005 04:48:50 +0200
Message-ID: <4067308fc7a2cbf39ba08c816252bcff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 32EAE198
	for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2005 04:48:51 +0200 (MEST)
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
Last Modified:              10-05-2005 04:48 CEST
======================================================================
Summary:                    hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Description: 
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

azx driver compliens about: NO AFG found.

alsmixer starts, but no sound.
======================================================================

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

----------------------------------------------------------------------
 crimsunkg - 10-05-05 04:48 
----------------------------------------------------------------------
slack_kid, have you tried a cvs checkout of alsa-kernel and alsa-driver?

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
09-29-05 22:13 slack_kid      Issue Monitored: slack_kid                    
10-05-05 04:48 crimsunkg      Note Added: 0006429                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000172]: Master volume control only controls front speakers
Date: Fri, 22 Oct 2004 16:44:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <c64f048202b24977ab3d5607079b8f0f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B72E729A
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2004 16:44:06 +0200 (MEST)
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


A new RELATIONSHIP has been added to the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=172> 
======================================================================
Reported By:                gruberroland
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   172
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.25
======================================================================
Date Submitted:             03-31-2004 11:50 CEST
Last Modified:              10-22-2004 16:44 CEST
======================================================================
Summary:                    Master volume control only controls front speakers
Description: 
The master volume control has no effect on the rear speakers.
The rear speakers can be controlled by "Sigmatel Surround" but not
completly muted.

I use "Sigmatel 4-Speaker Stereo" to get sound on all 4 speakers. The
speakers are plugged into both output plugs on the soundcard.

I tried all volume controls that are provided, there seems to be no master
control.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000154 Master volume only controls front outpu...
======================================================================

----------------------------------------------------------------------
 perex - 03-31-04 16:35 
----------------------------------------------------------------------
It's feature request. We haven't designed abstract mixer layer at the
moment,
but you are allowed to control fully hardware anyway. If you cannot mute
completely the rear speakers, then it's probably hardware problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-04 11:50 gruberroland   New Issue                                    
03-31-04 11:50 gruberroland   Kernel Version            => 2.4.25          
03-31-04 16:33 perex          Assigned To               => perex           
03-31-04 16:33 perex          Severity                 major => feature    
03-31-04 16:33 perex          Status                   new => assigned     
03-31-04 16:35 perex          Note Added: 0000725                          
10-22-04 16:44 perex          Relationship added       related to 0000154  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

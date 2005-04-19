From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001051]: Master <--> PCM
Date: Tue, 19 Apr 2005 18:26:50 +0200
Message-ID: <f578d83ca96cee239f7ebb99f5634209@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0F961204
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 18:26:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1051> 
======================================================================
Reported By:                kayandus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1051
Category:                   PCI - via82xx
Reproducibility:            N/A
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.10-5-k7
======================================================================
Date Submitted:             04-13-2005 21:16 CEST
Last Modified:              04-19-2005 18:26 CEST
======================================================================
Summary:                    Master <--> PCM
Description: 
Hello,

I bought a Targa Traveller 811 laptop a couple of months ago with an
onboard 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50) audio controller. It
works fine with the via82xx driver, but there's only one minor problem.
Let me explain my problem.

There are 3 major volume controls for me,
Master: Controls the volume of the internal laptop speaker, so when there
is a plug/earphones in my LINE IN, it changes nothing. (!!)
Headphones: Controls volume of the LINE IN, so does nothing when there is
nothing my LINE IN.
PCM: Controls both interal speaker and LINE IN, so volume goes up and down
whether im using the internal speaker or not.

Probably the problem is clear already to u, most programs control only
Master, so when I have my laptop attached to my stereo, those programs
don't change my volume =(
I hope u guys can fix this, I suggest by making an option to change Master
with PCM.

Thanks in advance, Harm te Hennepe
======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 18:26 
----------------------------------------------------------------------
Try ac97_quirk=hp_only module option (with the latest ALSA).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 21:16 kayandus       New Issue                                    
04-13-05 21:16 kayandus       Distribution              => Ubuntu          
04-13-05 21:16 kayandus       Kernel Version            => 2.6.10-5-k7     
04-13-05 21:20 kayandus       Issue Monitored: kayandus                    
04-19-05 17:46 kayandus       Issue End Monitor: kayandus                    
04-19-05 18:26 tiwai          Note Added: 0004535                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000569]: Software mixing to rear channel
Date: Thu, 13 Jan 2005 17:03:15 +0100
Message-ID: <d3a8024456839c661f767be9caa1c55f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E05B1272
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 17:03:15 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=569> 
======================================================================
Reported By:                pmatil
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   569
Category:                   PCI - cs46xx
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Debian GNU/Linux
Kernel Version:             2.4.22
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-06-2004 15:22 CEST
Last Modified:              01-13-2005 17:03 CET
======================================================================
Summary:                    Software mixing to rear channel
Description: 
I don't know how to explain it, but since Terratec DMX Xfire 1024 has two
stereo outputs (front and rear), it would be nice if there was a
slider/button/etc. from which I could set same output to front and rear
(eg. same signal), so my 4-channel amp. gets all 4-channels in and I get
sound from all 4 speakers instead of the amp. mixing front to rear.
Separated volume sliders for front and rear would be nice too.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000579 multi+route distort sound
======================================================================

----------------------------------------------------------------------
 tiwai - 10-12-04 14:50 
----------------------------------------------------------------------
You can do this by creating a new pcm in ~/.asoundrc.
See an example in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=579.

----------------------------------------------------------------------
 tiwai - 01-13-05 17:03 
----------------------------------------------------------------------
4-channel output is enabled in the recent version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-06-04 15:22 pmatil         New Issue                                    
10-06-04 15:22 pmatil         Distribution              => Debian GNU/Linux
10-06-04 15:22 pmatil         Kernel Version            => 2.4.22          
10-12-04 14:50 tiwai          Note Added: 0002098                          
10-22-04 16:56 perex          Relationship added       related to 0000579  
01-13-05 17:03 tiwai          Status                   new => resolved     
01-13-05 17:03 tiwai          Resolution               open => fixed       
01-13-05 17:03 tiwai          Assigned To               => tiwai           
01-13-05 17:03 tiwai          Note Added: 0003186                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

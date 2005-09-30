From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001465]: left and right volumes unbalanced when adjusted with xmms slider running under aoss
Date: Fri, 30 Sep 2005 11:13:21 +0200
Message-ID: <27b884c0622e9949af5f7284fbfb4e6b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8F86D160
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2005 11:13:22 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1465> 
======================================================================
Reported By:                xolsonalsa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1465
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-27-2005 11:33 CEST
Last Modified:              09-30-2005 11:13 CEST
======================================================================
Summary:                    left and right volumes unbalanced when adjusted with
xmms slider running under aoss
Description: 
When I run xmms its built-in volume slider works normally, with OSS volume
ranges 0 to 31.  When I run aoss xmms, the volume slider seems to have
different ranges for the left and right channels.  When you turn it all
the way up and look at the values with amixer or alsamixer the left
channel is set to 31 and the right is set to 15.  Also the sound out the
speakers agrees with this (left much louder).  The same problem happens
with the master control if you tell xmms to use the master instead of the
pcm volume.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-27-05 11:33 xolsonalsa     New Issue                                    
09-30-05 11:13 jdthood        Summary                  xmms volume slider
malfunction in aoss => left and right volumes unbalanced when adjusted with xmms
slider running under aoss
09-30-05 11:13 jdthood        Description Updated                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

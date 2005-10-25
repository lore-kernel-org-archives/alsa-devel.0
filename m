From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001500]: Dell Inspiron 8600 needs AC97_TUNE_HP_ONLY quirk
Date: Tue, 25 Oct 2005 12:50:38 +0200
Message-ID: <79d3d1ab188dee8ab7df681298745fa6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F0938173
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 12:50:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1500> 
======================================================================
Reported By:                lorentey
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1500
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.14pre3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-25-2005 12:32 CEST
Last Modified:              10-25-2005 12:50 CEST
======================================================================
Summary:                    Dell Inspiron 8600 needs AC97_TUNE_HP_ONLY quirk
Description: 
On my Dell Inspiron 8600c laptop, the master control does not affect the
headphone volume.  Adding hp_only to the module parameters fixes this.

I suggest including this setting as a predefined quirk.  The attached
patch works fine for me.
======================================================================

----------------------------------------------------------------------
 lorentey - 10-25-05 12:45 
----------------------------------------------------------------------
But of course:

Add AC97_TUNE_HP_ONLY quirk for Dell Inspiron 8600.

Signed-off-by: Karoly Lorentey <lorentey@elte.hu>

----------------------------------------------------------------------
 tiwai - 10-25-05 12:50 
----------------------------------------------------------------------
Thanks, now committed to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 12:32 lorentey       New Issue                                    
10-25-05 12:32 lorentey       File Added:
dell-inspiron-8600.intel8x0.quirk.patch                    
10-25-05 12:32 lorentey       Distribution              => Debian GNU/Linux
10-25-05 12:32 lorentey       Kernel Version            => 2.6.14pre3      
10-25-05 12:37 tiwai          Note Added: 0006535                          
10-25-05 12:45 lorentey       Note Added: 0006536                          
10-25-05 12:50 tiwai          Status                   new => resolved     
10-25-05 12:50 tiwai          Resolution               open => fixed       
10-25-05 12:50 tiwai          Assigned To               => tiwai           
10-25-05 12:50 tiwai          Note Added: 0006537                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information

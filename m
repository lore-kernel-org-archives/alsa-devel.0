From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001450]: SPDIF out is limited with 48KHz
Date: Tue, 11 Oct 2005 17:22:40 +0200
Message-ID: <b800b5591fd19711e4f78fe07b97d40f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85503189
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2005 17:22:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1450> 
======================================================================
Reported By:                anli
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1450
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-24-2005 15:33 CEST
Last Modified:              10-11-2005 17:22 CEST
======================================================================
Summary:                    SPDIF out is limited with 48KHz
Description: 
Last the driver version which worked perfectly (i.e. with 96KHz SPDIF out
sample rate) is 1.04. And I was able to use SPDIF out with JACK at
96KHz/32bit mode _without_ any problems.

Now SPDIF out is limited with 48KHz srate. Long time ago developers
argumented 48KHz limit as it is SPDIF standard. On the other hand all
(semi)pro DACs suuport 96KHz. This is true for all ice1724 cards too.
Moreover, we are in the open source world at last :-)

Please, revert this limit back. I'm ready to test the driver from CVS
tree.

Andrew

======================================================================

----------------------------------------------------------------------
 anli - 10-06-05 20:40 
----------------------------------------------------------------------
Tiwai,

Sorry, have not uderstood your comment. The WM8770 codec hasn't such
limitations. And, again, few the driver versions ago I used 96KHz with
JACK server without noticed problems (and used DAC showed explicitly 96KHz
sample rate).



----------------------------------------------------------------------
 tiwai - 10-11-05 17:22 
----------------------------------------------------------------------
Ah sorry, I misunerdstood the topic about ice1712.
Could you try the attached patch?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-05 15:33 anli           New Issue                                    
10-05-05 19:07 tiwai          Note Added: 0006441                          
10-06-05 16:36 anli           Note Added: 0006443                          
10-06-05 16:40 anli           Note Added: 0006444                          
10-06-05 17:14 anli           Note Edited: 0006443                         
10-06-05 17:25 anli           Issue Monitored: anli                        
10-06-05 20:40 anli           Note Edited: 0006444                         
10-07-05 11:16 anli           Note Edited: 0006443                         
10-11-05 17:22 tiwai          Note Added: 0006455                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

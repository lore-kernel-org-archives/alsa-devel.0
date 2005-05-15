From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000557]: SNDCTL_DSP_GETOPTR not working correctly in specific situation
Date: Sun, 15 May 2005 15:50:49 +0200
Message-ID: <adfc79f47d28a30ba39a3bd4c9931a52@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EF751356
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2005 15:50:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=557> 
======================================================================
Reported By:                minmax
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   557
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.7
======================================================================
Date Submitted:             10-01-2004 16:18 CEST
Last Modified:              05-15-2005 15:50 CEST
======================================================================
Summary:                    SNDCTL_DSP_GETOPTR not working correctly in specific
situation
Description: 
When the first few writes to the oss emulation device are done in specific
way, SNDCTL_DSP_GETOPTR returns wrongly huge results in info.bytes
======================================================================

----------------------------------------------------------------------
 gk4 - 05-13-05 19:48 
----------------------------------------------------------------------
I'm running FC3 with the 2.6.10-1.766_FC3 kernel.  How can I determine
which level of ALSA the kernel is using?

----------------------------------------------------------------------
 tiwai - 05-15-05 15:50 
----------------------------------------------------------------------
Check /proc/asound/version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-01-04 16:18 minmax         New Issue                                    
10-01-04 16:18 minmax         Distribution              => Debian unstable 
10-01-04 16:18 minmax         Kernel Version            => vanilla 2.6.7   
10-02-04 10:52 minmax         Issue Monitored: minmax                      
04-09-05 16:09 jdthood        Note Added: 0004406                          
04-09-05 16:22 minmax         Note Added: 0004410                          
05-13-05 15:20 gk4            Note Added: 0004646                          
05-13-05 15:24 perex          Note Added: 0004647                          
05-13-05 15:26 tiwai          Note Added: 0004648                          
05-13-05 19:35 gk4            Note Added: 0004651                          
05-13-05 19:38 tiwai          Note Added: 0004652                          
05-13-05 19:48 gk4            Note Added: 0004655                          
05-15-05 15:50 tiwai          Note Added: 0004663                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click

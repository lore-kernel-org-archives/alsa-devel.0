From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000880]: ALSA lib pcm_hw.c:370:(snd_pcm_hw_hw_free) SNDRV_PCM_IOCTL_HW_FREE failed: File descriptor in bad state
Date: Sat, 5 Feb 2005 11:20:49 +0100
Message-ID: <304a5d2f5d78c6a8843bd92a605d4989@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 874721C8
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2005 11:20:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=880> 
======================================================================
Reported By:                runtema
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   880
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2005 09:20 CET
Last Modified:              02-05-2005 11:20 CET
======================================================================
Summary:                    ALSA lib pcm_hw.c:370:(snd_pcm_hw_hw_free)
SNDRV_PCM_IOCTL_HW_FREE failed: File descriptor in bad state
Description: 
When accesing ALSA lib/module pcm trough application ogle (see
http://www.dtek.chalmers.se/groups/dvd/) it breaks down to the error given
in the summary.

Details for system/version/error:

see http://forums.gentoo.org/viewtopic.php?p=2050504
======================================================================

----------------------------------------------------------------------
 runtema - 02-05-05 10:58 
----------------------------------------------------------------------
other poeple have problems with using audiodevices together when running
parallel artsd: http://forums.gentoo.org/viewtopic.php?t=287079

----------------------------------------------------------------------
 runtema - 02-05-05 11:20 
----------------------------------------------------------------------
OK, the cause of the problem is really the parallel running artsd, there
seems to be a problem there with auto-suspend.

see new entries in the gentoo threads!

Please change Severity to 'block'!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 09:20 runtema        New Issue                                    
02-05-05 10:58 runtema        Note Added: 0003519                          
02-05-05 11:20 runtema        Note Added: 0003520                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

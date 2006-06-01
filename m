From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002173]: alsamixer ignores errors from
	setting mixer controls
Date: Thu, 1 Jun 2006 03:53:58 +0200
Message-ID: <652acba81a880006a12126f39258b365@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CCC46149
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jun 2006 03:53:58 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2173> 
======================================================================
Reported By:                Johannes Berg
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2173
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-30-2006 16:06 CEST
Last Modified:              06-01-2006 03:53 CEST
======================================================================
Summary:                    alsamixer ignores errors from setting mixer controls
Description: 
I have a driver that, under special circumstances, returns -EBUSY from a
_put call for a control.
alsamixer, however, ignores that and displays the control as toggled
anyway, which is misleading.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-01-06 03:53 
----------------------------------------------------------------------
If the control is specific to a PCM stream, the control should use 
SNDRV_CTL_ELEM_IFACE_PCM instead of SNDRV_CTL_ELEM_IFACE_MIXER.

The value will save/restore by alsactl but the control will not appear in
alsamixer

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-06 16:06 Johannes Berg  New Issue                                    
06-01-06 03:53 Raymond        Note Added: 0010039                          
======================================================================

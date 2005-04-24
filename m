From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001075]: IEC958 Capture Switch cannot be set with alsamixer
Date: Sun, 24 Apr 2005 16:44:20 +0200
Message-ID: <5c8fc4ed67d9c82977afcdf82902c451@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1A67E231
	for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2005 16:44:21 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1075> 
======================================================================
Reported By:                vsu
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1075
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-24-2005 16:44 CEST
Last Modified:              04-24-2005 16:44 CEST
======================================================================
Summary:                    IEC958 Capture Switch cannot be set with alsamixer
Description: 
alsamixer (both 1.0.8 and CVS snapshot from 2005-04-23) is not able to
control IEC958 Capture Switch of the ALC850 codec:

- When alsamixer is started, IEC958 Capture Switch is always displayed as
turned on, regardless of the actual state.

- When pressing Space, the switch seems to be toggled on screen, however,
the actual mixer state does not change.

The switch can be controlled with amixer:

$ amixer cset numid=40,iface=MIXER,name='IEC958 Capture Switch' on
numid=40,iface=MIXER,name='IEC958 Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
$ amixer cset numid=40,iface=MIXER,name='IEC958 Capture Switch' off
numid=40,iface=MIXER,name='IEC958 Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off

When the switch state is changed this way while alsamixer is running, the
alsamixer screen is updated, and the switch is drawn as if turned on.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-24-05 16:44 vsu            New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

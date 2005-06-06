From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001161]: Midi in still does not work for Hoontech/STAudio DSP2000 C-Port
Date: Mon, 6 Jun 2005 15:29:52 +0200
Message-ID: <d2a531f79fd10c10d94ae3d0b61771ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64FD21D8
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 15:29:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1161> 
======================================================================
Reported By:                vandongen2
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1161
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               linux from scratch
Kernel Version:             2.6.12-rc4-RT-V0.7.47-03
======================================================================
Date Submitted:             06-06-2005 15:29 CEST
Last Modified:              06-06-2005 15:29 CEST
======================================================================
Summary:                    Midi in still does not work for Hoontech/STAudio
DSP2000 C-Port
Description: 
As reported before in bug 000055 that is now marked resolved.
It has not been resolved.
The problem seems to be related to hardware specific registers on the card
that need to be set.

I will be happy to spend a couple of days trying different flags/bits with
the initialisation code, if somebody gives me an idea of where to start.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 15:29 vandongen2     New Issue                                    
06-06-05 15:29 vandongen2     Distribution              => linux from scratch
06-06-05 15:29 vandongen2     Kernel Version            =>
2.6.12-rc4-RT-V0.7.47-03
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

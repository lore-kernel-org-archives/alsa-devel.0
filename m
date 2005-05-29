From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001144]: alsamixer 1.0.9 crashes when browsing through emu10kx mixer controls
Date: Sun, 29 May 2005 23:58:03 +0200
Message-ID: <50a4e7a86d449c917b0c55371a8ef883@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B12DB1A4
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 23:58:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1144> 
======================================================================
Reported By:                ajs1984
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1144
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-29-2005 20:03 CEST
Last Modified:              05-29-2005 23:58 CEST
======================================================================
Summary:                    alsamixer 1.0.9 crashes when browsing through
emu10kx mixer controls
Description: 
What it says on the tin. When going through Audigy 2 Platinum's mixer
controls, alsamixer (but not kmix) crashes with the following assertion:

alsamixer: simple.c:1975: snd_mixer_selem_get_enum_item: Assertion `helem'
failed.
Aborted
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001131 Alsamixer crashing - using Audigy Plati...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-05 20:03 ajs1984        New Issue                                    
05-29-05 23:22 rlrevell       Relationship added       duplicate of 0001131
05-29-05 23:58 rlrevell       Note Added: 0004793                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

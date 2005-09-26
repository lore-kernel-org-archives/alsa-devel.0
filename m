From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001429]: hda_codec: Unknown model for ALC880
Date: Mon, 26 Sep 2005 19:14:42 +0200
Message-ID: <4aa4a44316e8068a2de2a6cd30addf6e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C6CDE185
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 19:14:42 +0200 (MEST)
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


The issue 0001460 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1429> 
======================================================================
Reported By:                crimsunkg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1429
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.12-8-686
======================================================================
Date Submitted:             09-17-2005 00:54 CEST
Last Modified:              09-24-2005 20:55 CEST
======================================================================
Summary:                    hda_codec: Unknown model for ALC880
Description: 
Please refer to http://bugzilla.ubuntu.com/show_bug.cgi?id=15031

Using ALSA shipped with kernel 2.6.12 (~1.0.9+cvs), a kernel OOPS occurs.

Using ALSA 1.0.10rc1 and cvs (with alsa-lib 1.0.9), no OOPS occurs, but
hda_codec does not recognize the model with the ALC880 codec
(http://bugzilla.ubuntu.com/attachment.cgi?id=3808).

''lspci -nvv'' output is at
http://bugzilla.ubuntu.com/attachment.cgi?id=3848
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001453 2.6.14-rc2 &quot;Unknown model for ALC8...
has duplicate       0001316 can't run mixer to adjusting volumes / ...
has duplicate       0001460 no sound on Clevo 400a
======================================================================

----------------------------------------------------------------------
 crimsunkg - 09-24-05 20:55 
----------------------------------------------------------------------
This issue is duplicated in bug #1453.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-17-05 00:54 crimsunkg      New Issue                                    
09-17-05 00:54 crimsunkg      Distribution              => Ubuntu Breezy   
09-17-05 00:54 crimsunkg      Kernel Version            => 2.6.12-8-686    
09-24-05 20:55 crimsunkg      Note Added: 0006377                          
09-24-05 22:06 rlrevell       Relationship added       has duplicate 0001453
09-26-05 19:14 rlrevell       Relationship added       has duplicate 0001316
09-26-05 19:14 rlrevell       Relationship added       has duplicate 0001460
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

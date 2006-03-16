From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001932]: snd_mixer_handle_events() documentation doesn't explain the return value correctly
Date: Thu, 16 Mar 2006 23:05:56 +0100
Message-ID: <22a30380fc57062b9698efa41c0bd8ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 865881A9
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 23:05:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1932> 
======================================================================
Reported By:                tilman
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1932
Category:                   2_mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-16-2006 23:05 CET
Last Modified:              03-16-2006 23:05 CET
======================================================================
Summary:                    snd_mixer_handle_events() documentation doesn't
explain the return value correctly
Description: 
The docs for snd_mixer_handle_events() say the return value is:

"0 otherwise a negative error code on failure"

which suggests that 0 is the only valid return value that represents
success.

In fact, the function returns the number of mixer events that occurred on
success, which makes any return value >=0 represent success.

I suggest to apply the attached patch to actually document the return
value correctly (applies to CVS HEAD).
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-16-06 23:05 tilman         New Issue                                    
03-16-06 23:05 tilman         File Added:
alsalib-snd_mixer_handle_events_documentation.diff                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

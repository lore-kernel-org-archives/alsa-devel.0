From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001446]: snd_mixer_set_compare() is useless unless the structure of snd_mixer_elem_t is exposed in a public header file
Date: Fri, 23 Sep 2005 17:29:47 +0200
Message-ID: <578b0edf8ab9aa21c35cc3f40bd3c227@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 069F4148
	for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2005 17:29:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1446> 
======================================================================
Reported By:                mikewhit
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1446
Category:                   0_general
Reproducibility:            N/A
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-23-2005 17:29 CEST
Last Modified:              09-23-2005 17:29 CEST
======================================================================
Summary:                    snd_mixer_set_compare() is useless unless the
structure of snd_mixer_elem_t is exposed in a public header file
Description: 
Unless you can write a snd_mixer_compare_t compliant function, there is no
use for snd_mixer_set_compare() [Unless ALSA also provides a library of
such functions.]

However, this requires knowledge of the fields of snd_mixer_elem_t in
order to sensibly compare elements.

snd_mixer_elem_t is only documented in mixer_local.h, which is not part of
the public API.

Or do I misunderstand something ?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 17:29 mikewhit       New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

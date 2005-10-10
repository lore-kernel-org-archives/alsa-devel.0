From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001470]: Hdspmixer resets all levels at startup, does not remeber levels at closing
Date: Mon, 10 Oct 2005 15:10:19 +0200
Message-ID: <cb76f2d0783e736f27f78f3c3e6f6ddf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E121D1B4
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2005 15:10:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1470> 
======================================================================
Reported By:                plessas
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   1470
Category:                   hdsp progs
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             10-10-2005 15:10 CEST
Last Modified:              10-10-2005 15:10 CEST
======================================================================
Summary:                    Hdspmixer resets all levels at startup, does not
remeber levels at closing
Description: 
After system boot i have to start the hdspmixer once to get audio output.
It loads then the "default preset" which means full 0dB on all channels.

After adjusting the levels, and saving them to a file, and even making
this file the "default", at next application startup hdspmixer gives the
full 0dB again.

More useful behavior IMHO would be to restore exactly the levels i did set
when i closed the hdspmixer. And these settings should then be resored
after a reboot.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-10-05 15:10 plessas        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

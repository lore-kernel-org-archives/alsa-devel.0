From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001483]: PCM.C errors: Using modem drivers.
Date: Tue, 18 Oct 2005 13:01:39 +0200
Message-ID: <d34c9ac162a3f328dcf1a8d7425f9ce6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07A731A0
	for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2005 13:01:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1483> 
======================================================================
Reported By:                GPLed
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1483
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-18-2005 13:01 CEST
Last Modified:              10-18-2005 13:01 CEST
======================================================================
Summary:                    PCM.C errors: Using modem drivers.
Description: 
snd-intel-8x0m driver. I have successfully loaded the driver and ran
slmodemd --alsa but it gives me the following output:

error: mixer setup: attach hw:1 error: No such file or directory
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM modem:1
definition (id: modem, value: cards.pcm.modem)
error: alsa setup: cannot open playback device 'modem:1': Invalid
argument
error: cannot setup device `modem:1'

Some other people also get the very same problem on FC4. Is there anything
that can be done? Please help.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-18-05 13:01 GPLed          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

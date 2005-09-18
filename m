From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001434]: Java plugin sound not working in OSS emulation
Date: Sun, 18 Sep 2005 22:40:06 +0200
Message-ID: <ee35b07190de5069186b7b9c97609a7e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 20D1E176
	for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2005 22:40:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1434> 
======================================================================
Reported By:                xolsonalsa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1434
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-18-2005 22:40 CEST
Last Modified:              09-18-2005 22:40 CEST
======================================================================
Summary:                    Java plugin sound not working in OSS emulation
Description: 
Tried 2 different soundblaster 16 cards, and ISA and a pnp isa vibra 16. 
PCM sounds won't play if the Java Sound Audio Engine (software mixer that
opens /dev/dsp) is in use. Tried it with the JavaSoundDemo and also pogo
games. The symptom is it seems to play one sound and then io through
/dev/dsp becomes blocked. The only workaround is to start the web browser
using aoss so that it opens the native alsa pcm device instead of
/dev/dsp.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-18-05 22:40 xolsonalsa     New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000219]: Only pcm-2 (headphone) volume control works, others muted(?)
Date: Thu, 29 Sep 2005 12:13:56 +0200
Message-ID: <d54ccb3bd3e6c37a4d64d1a80513dcdb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B78AC191
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 12:13:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=219> 
======================================================================
Reported By:                JonB
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   219
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 9.1
Kernel Version:             2.4.24
======================================================================
Date Submitted:             04-17-2004 12:23 CEST
Last Modified:              09-29-2005 12:13 CEST
======================================================================
Summary:                    Only pcm-2 (headphone) volume control works, others
muted(?)
Description: 
Tried various applications from CLI and Dropline GNOME 2.6.0 to get sound
output. Dell Inspiron 5150 laptop with 82801DBICH4.

Master volume control, PCM, CD, Video have no effect on sound volume - no
sound output from external speakers. Plugin headphones and can vary sound
through headphones using the headphone control (also known as pcm-2 in
aumix).

Playing any CD with the GNOME CD Player does not produce any sound through
headphones or speakers.

Playing through headphones - only the headphone control has any effect.
The master control has no effect.

Have included output from various parts of the system including lspci,
asound.state and some information in /proc/asound/card0.

Sound was working in 1.0.2 (except PCM control was intermittent) -
internal speakers worked, master volume control worked, etc.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 16:06 
----------------------------------------------------------------------
Try switching on 'External Amplifier'.

----------------------------------------------------------------------
 jdthood - 09-29-05 12:13 
----------------------------------------------------------------------
Submitter: Does switching on 'External Amplifier' fix the problem?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-04 12:23 JonB           New Issue                                    
04-17-04 12:23 JonB           File Added: intel8x0                         
04-17-04 12:23 JonB           Distribution              => Slackware 9.1   
04-17-04 12:23 JonB           Kernel Version            => 2.4.24          
03-23-05 16:06 jdthood        Note Added: 0004171                          
09-29-05 12:13 jdthood        Note Added: 0006418                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

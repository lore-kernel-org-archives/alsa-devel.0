From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000747]: Sample rate issue with Audiotrak OPTOPlay (usbaudio)
Date: Sat, 25 Dec 2004 19:07:02 +0100
Message-ID: <a1f15a9be56df08614f0e7647fc6d227@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 053052AB
	for <alsa-devel@alsa-project.org>; Sat, 25 Dec 2004 19:07:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=747> 
======================================================================
Reported By:                JonLech
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   747
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora
Kernel Version:             2.6.10-rc3
======================================================================
Date Submitted:             12-25-2004 19:07 CET
Last Modified:              12-25-2004 19:07 CET
======================================================================
Summary:                    Sample rate issue with Audiotrak OPTOPlay (usbaudio)
Description: 
The Audiotrak OPTOPlay supports setting the sample rate, but not getting
it. However, the current usbaudio code disables both for the device. This
results in stuttering when I output e.g 48000Hz samples because the device
is never set to 48000Hz.

Attached is a patch which fixes this.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-25-04 19:07 JonLech        New Issue                                    
12-25-04 19:07 JonLech        File Added: usbaudio-optoplay.patch               
    
12-25-04 19:07 JonLech        Distribution              => Fedora          
12-25-04 19:07 JonLech        Kernel Version            => 2.6.10-rc3      
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

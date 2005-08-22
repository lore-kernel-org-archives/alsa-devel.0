From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001354]: Mixer problem on Logitech Quickcam Zoom with Integrated mic
Date: Mon, 22 Aug 2005 13:11:43 +0200
Message-ID: <76fda46b8459a51004da712094357ec2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF74B20D
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2005 13:11:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1354> 
======================================================================
Reported By:                Bourrindebase
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1354
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrivalinux
Kernel Version:             2.6.12-10mdk
======================================================================
Date Submitted:             08-21-2005 18:17 CEST
Last Modified:              08-22-2005 13:11 CEST
======================================================================
Summary:                    Mixer problem on Logitech Quickcam Zoom with
Integrated mic
Description: 
When I plug the webcam I get an error on mixer settings. Then the mic
integrated on the webcam is not usable. There is no sound available from
the webcam. I get the same error with Cooker Mandrivalinux and 10.2 (2005
Limited Edition) Mandrivalinux. So mixer settings for the cam are note
available under alsamixer.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 08-22-05 13:11 
----------------------------------------------------------------------
What do you mean with "error on mixer settings"?

What are the contents of /proc/asound/cards?
What is the output of "amixer -c <cardnumber> contents"?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-21-05 18:17 Bourrindebase  New Issue                                    
08-21-05 18:17 Bourrindebase  Distribution              => Mandrivalinux   
08-21-05 18:17 Bourrindebase  Kernel Version            => 2.6.12-10mdk    
08-22-05 13:11 Clemens LadischNote Added: 0005896                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

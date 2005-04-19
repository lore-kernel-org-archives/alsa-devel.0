From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001061]: can't test audio with aplay using 16-bit signed LE format; 1.0.7 however works
Date: Tue, 19 Apr 2005 17:52:42 +0200
Message-ID: <fe52b4bb5f7075d8fb08db9a30630c28@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0C7ED1C2
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 17:52:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1061> 
======================================================================
Reported By:                ukr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1061
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             Linux 2.6.11
======================================================================
Date Submitted:             04-18-2005 03:24 CEST
Last Modified:              04-19-2005 17:52 CEST
======================================================================
Summary:                    can't test audio with aplay using 16-bit signed LE
format; 1.0.7 however works
Description: 
I usually test my speakers with aplay using

aplay -t raw -f S16_LE -c 6 -r 48000 -Dsurround51

With 1.0.8, when I do this, nothing goes to any of the speakers. However,
when I revert to alsa-driver 1.0.7, it works correctly. I have Intel ICH5
audio with Realtek ALC650F chip with 5.1 channel audio.

Thanks,
            Uday.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 17:39 
----------------------------------------------------------------------
Try 1.0.9rc2.  The mixer configuration is OK?

----------------------------------------------------------------------
 ukr - 04-19-05 17:52 
----------------------------------------------------------------------
The mixer configuration is okay. I actually reverted to alsa 1.0.7 (the
driver) and then tried, and it worked perfectly. aplay gives the usual
noise. Also, with alsa 1.0.8, I can play music with xmms or any other
player correctly but the rear right channel stops working after some time.
Output to all other channels works fine. I also confirmed this with
speaker-test.

I tried 1.0.9rc2. After installing 1.0.9rc2 versions of the driver and
lib, when I tried to play music (with xmms), some kind of strange repeated
noise comes out of the speakers instead of the music. The culprit seems to
be alsa-lib 1.0.9rc2; when I reverted to alsa-lib 1.0.8 with 1.0.9rc2
driver and utils, it worked correctly; but still aplay doesn't send output
on S16_LE in any of these cases except when I have alsa-driver-1.0.7.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-05 03:24 ukr            New Issue                                    
04-18-05 03:24 ukr            Distribution              => Fedora Core 3   
04-18-05 03:24 ukr            Kernel Version            => Linux 2.6.11    
04-19-05 02:30 ukr            Issue Monitored: ukr                         
04-19-05 17:39 tiwai          Note Added: 0004524                          
04-19-05 17:52 ukr            Note Added: 0004530                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728

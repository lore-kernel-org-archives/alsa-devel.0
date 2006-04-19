From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002038]: Microphone is not working on Sigmatel STAC9200
Date: Wed, 19 Apr 2006 22:09:12 +0200
Message-ID: <742419b83d0918050f701d7473ca7fd2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1D1418A
	for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2006 22:09:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2038> 
======================================================================
Reported By:                telles
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2038
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva 2006
Kernel Version:             2.6.12-18mdk
======================================================================
Date Submitted:             04-19-2006 20:58 CEST
Last Modified:              04-19-2006 22:09 CEST
======================================================================
Summary:                    Microphone is not working on Sigmatel STAC9200
Description: 
I have a laptop Dell Latitude 120L with a HDA Intel Sound Board:
Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition
Audio Controller (rev 03)
that is recognized as Sigmatel STAC9200.
Sound is working great but the microphone is not working at all.
I think that is missing some control on alsamixer about Mic, because there
is no Mic's volume or sound control, only "Input Source" is present
(Line|Mic) and seems that it doesn't change anything about Microphone.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-19-06 22:09 
----------------------------------------------------------------------
What is the output of "amixer"

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-06 20:58 telles         New Issue                                    
04-19-06 20:58 telles         Distribution              => Mandriva 2006   
04-19-06 20:58 telles         Kernel Version            => 2.6.12-18mdk    
04-19-06 22:09 rlrevell       Note Added: 0009358                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002130]: PCI 128 (en1370) second channel does not work
Date: Wed, 17 May 2006 22:23:59 +0200
Message-ID: <ba39894a70172caf462fd6c6f13a7c22@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 429E6160
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 22:23:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2130> 
======================================================================
Reported By:                ipartola
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2130
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-17-2006 03:40 CEST
Last Modified:              05-17-2006 22:23 CEST
======================================================================
Summary:                    PCI 128 (en1370) second channel does not work
Description: 
I'm using an EN1370 based card (PCI 128 CT4700). The card has two jacks
labeled as outputs on it. cat /proc/asound/devices says that there are two
digital audio devices and one control device on this card. when I try to
do 
$ aplay -Dsurround40 -c 4 some.wav I get the following message:

ALSA lib setup.c:555:(add_elem) Cannot obtain info for CTL elem
(MIXER,'PCM 0 Output also on Line-In Jack',0,0,0): No such file or
directory
aplay: main:547: audio open error: No such file or directory


======================================================================

----------------------------------------------------------------------
 tiwai - 05-17-06 13:12 
----------------------------------------------------------------------
Try the uploaded patch.

----------------------------------------------------------------------
 ipartola - 05-17-06 22:23 
----------------------------------------------------------------------
That helped. Now I have beautiful surround sound output. For example:

$ speaker-test -c 4 -D surround40 -r 44100

This works perfectly as expected. Mplayer works just fine too. Thank you
very much.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-17-06 03:40 ipartola       New Issue                                    
05-17-06 13:12 tiwai          Note Added: 0009848                          
05-17-06 13:12 tiwai          File Added: ens1370-surround40-fix.diff           
        
05-17-06 22:23 ipartola       Note Added: 0009858                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

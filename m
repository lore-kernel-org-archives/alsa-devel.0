From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002264]: Multi-streaming with Intel HDA
Date: Fri, 7 Jul 2006 12:50:11 +0200
Message-ID: <d7d23b3cd3328288f2a128dd48c3bbef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 87EC3273
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 12:50:11 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2264> 
======================================================================
Reported By:                chetan13
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2264
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-07-2006 12:43 CEST
Last Modified:              07-07-2006 12:50 CEST
======================================================================
Summary:                    Multi-streaming with Intel HDA
Description: 
Hi, i have the intel D915GAV motherboard. The snd-hda-intel driver supports
it. 
Currently, i have a headphone switch in alsamixer which enables the
headphone jack on the front panel of my cabinet. But this audio is always
the same as the audio that goes to the speakers. Intel HDA supports
sending different streams to the speakers and the headset.
I'll quote http://www.intel.com/design/chipsets/hdaudio.htm 
"Consumers also want the ability to play back two different audio tracks.
Intel HD Audio features multi-streaming capabilities that give users the
ability to send two or more different audio streams to different locations
at the same time, from the same PC. Send a game's sound through 5.1
speakers while the Internet chatting audio is sent through your headset."

Essentially, it's like having two soundcards. Does alsa support sending
the game audio through the speakers and chat audio through the headset? If
so, how do i do it?

======================================================================

----------------------------------------------------------------------
 tiwai - 07-07-06 12:50 
----------------------------------------------------------------------
The feature is not supported yet.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-06 12:43 chetan13       New Issue                                    
07-07-06 12:50 tiwai          Note Added: 0010907                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000090]: US-244 > us428control
Date: Tue, 9 Aug 2005 13:08:33 +0200
Message-ID: <3634baf7a22d1eff1ddc0c0282b17abd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB6DF1BD
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:08:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=90> 
======================================================================
Reported By:                4tm
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   90
Category:                   firmware loaders
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-26-2004 13:13 CET
Last Modified:              08-09-2005 13:08 CEST
======================================================================
Summary:                    US-244 > us428control
Description: 
Hi again,
now my firmare on us-244 is running an USB-Led is Burning!
- When I start us428control it hangs up.
- When I use: aplay -v -D plug:hw:USX2Y any.wav
I sometimes here a short Sound, an then the following Error occured:
"aplay: pcm_write:1083: write error: Input/output error"
- If I do it often, the the whole Sytem hangs up :-(
Could ist be related with:
http://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000051
I use a OHCI-USB!

ToM
======================================================================

----------------------------------------------------------------------
 4tm - 03-09-04 17:55 
----------------------------------------------------------------------
"modprobe snd-seq-device" brings nothing new :-(

"lsmod |grep snd" Output is always:                      
snd-usb-usx2y          14596   0 
snd-usb-audio          47488   0  [snd-usb-usx2y]
snd-rawmidi            12608   0  [snd-usb-audio]
snd-seq-device          4336   0  [snd-rawmidi]
snd-pcm                59556   0  [snd-usb-usx2y snd-usb-audio]
snd-timer              14692   0  [snd-pcm]
snd-hwdep               4864   0  [snd-usb-usx2y]
snd-page-alloc          6804   0  [snd-usb-usx2y snd-pcm]
snd                    29144   0  [snd-usb-usx2y snd-usb-audio snd-rawmidi
snd-seq-device snd-pcm snd-timer snd-hwdep]
usbcore                62828   1  [snd-usb-usx2y snd-usb-audio usbmouse
hid usbkbd usb-ohci]

bearbeitet am: 03-09-04 17:55

----------------------------------------------------------------------
 perex - 08-09-05 13:08 
----------------------------------------------------------------------
reporter: any news for this issue? does the latest 2.4 kernel and ALSA
packages help?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-04 13:13 4tm            New Issue                                    
02-26-04 13:16 4tm            Issue Monitored: 4tm                         
02-26-04 17:20 martin         Note Added: 0000357                          
02-26-04 19:57 4tm            Note Added: 0000368                          
02-26-04 20:54 martin         Note Added: 0000371                          
02-27-04 09:43 4tm            Note Added: 0000379                          
02-27-04 20:06 martin         File Added: usx2y-seq-device.patch                
   
02-27-04 20:07 martin         Note Added: 0000382                          
02-28-04 11:53 4tm            Note Added: 0000386                          
02-28-04 17:58 karsten        Note Added: 0000387                          
02-28-04 18:30 martin         Note Added: 0000388                          
03-09-04 17:52 4tm            Note Added: 0000550                          
03-09-04 17:55 4tm            Note Edited: 0000550                         
08-09-05 13:08 perex          Note Added: 0005727                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

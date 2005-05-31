From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000846]: Can't hear sound from one of the surround speaker, while other is working (speakers are functional).
Date: Tue, 31 May 2005 18:05:07 +0200
Message-ID: <b3cf7bebee36ca83dc2afc61d30fb416@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 43BE71B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:05:08 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=846> 
======================================================================
Reported By:                Envel
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   846
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-24-2005 13:44 CET
Last Modified:              05-31-2005 18:05 CEST
======================================================================
Summary:                    Can't hear sound from one of the surround speaker,
while other is working (speakers are functional).
Description: 
With options "Line-In as surround" and "Duplicate front" the right surround
speaker is not working, while others are functional. After uninstalling
ALSA 1.0.8 and installing againg ALSA 1.0.7 with the same mixer
configuration the error is not occures. SoundCard: nForce2 Audio Codec,
Driver: snd-intel8x0, 4 speakers.
p.s. sorry for my English.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000902 Some channels not working
======================================================================

----------------------------------------------------------------------
 jor - 03-20-05 14:47 
----------------------------------------------------------------------
When you try alsa driver 1.0.9rc1, make sure its not still using your old
kernel module, look at /proc/asound/version to make sure it's 1.0.9rc1.

Or you could upgrade the whole kernel, but plain 2.6.11 still has the bug.
Try 2.6.11.5 (note the .5 at the end, new kernel versioning for 'stable'
kernel with only small bugfixes, can be downloaded at normal kernel
sources like kernel.org).

----------------------------------------------------------------------
 stephenv - 03-20-05 19:58 
----------------------------------------------------------------------
It's working now, looks like an overnight rest did the trick. Went and
checked back in 2.6.10. Still not working there with same modules. so
2.6.11 and the new version do the trick. Wonder what the difference is in
the 2.6.10. I hate that because I need to roll some of my drivers by hand
under this kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-24-05 13:44 Envel          New Issue                                    
01-24-05 13:44 Envel          Kernel Version            => 2.6.8.1         
01-25-05 15:18 tiwai          Note Added: 0003402                          
01-28-05 08:17 ivantheviking  Issue Monitored: ivantheviking                    
01-28-05 08:19 ivantheviking  File Added: asound.state                     
01-28-05 08:20 ivantheviking  File Added: ac97#0-0                         
01-28-05 08:21 ivantheviking  File Added: ac97#0-0+regs                    
01-28-05 08:30 ivantheviking  Note Added: 0003424                          
01-29-05 17:13 ivantheviking  Note Added: 0003438                          
03-01-05 00:03 stephenv       Issue Monitored: stephenv                    
03-01-05 00:06 stephenv       Note Added: 0003752                          
03-02-05 01:19 ivantheviking  Note Edited: 0003438                         
03-04-05 22:53 slammer        Note Added: 0003802                          
03-04-05 22:55 slammer        Issue Monitored: slammer                     
03-07-05 00:12 stephenv       File Added: svs.tar                          
03-08-05 18:43 jor            Issue Monitored: jor                         
03-08-05 19:03 jor            Note Added: 0003816                          
03-09-05 18:43 tiwai          Note Added: 0003834                          
03-09-05 18:43 tiwai          Note Added: 0003835                          
03-09-05 19:24 jor            Note Added: 0003845                          
03-10-05 03:27 stephenv       Note Added: 0003847                          
03-10-05 11:55 slammer        Note Added: 0003848                          
03-10-05 13:17 slammer        Note Added: 0003850                          
03-10-05 14:36 tiwai          Relationship added       has duplicate 0000902
03-10-05 18:03 stephenv       Note Added: 0003869                          
03-10-05 23:28 slammer        Note Added: 0003875                          
03-16-05 14:49 tiwai          Note Added: 0003959                          
03-16-05 16:41 stephenv       Note Added: 0003962                          
03-19-05 18:06 jor            Note Added: 0004059                          
03-20-05 04:03 stephenv       Note Added: 0004071                          
03-20-05 04:53 stephenv       Note Added: 0004072                          
03-20-05 14:47 jor            Note Added: 0004089                          
03-20-05 19:58 stephenv       Note Added: 0004098                          
03-22-05 20:56 stephenv       Issue End Monitor: stephenv                    
03-22-05 22:35 jdthood        Status                   new => resolved     
03-22-05 22:35 jdthood        Resolution               open => fixed       
03-23-05 22:19 slammer        Issue End Monitor: slammer                    
04-02-05 19:54 jor            Issue End Monitor: jor                       
05-31-05 18:05 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

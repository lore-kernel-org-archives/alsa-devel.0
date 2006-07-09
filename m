From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001958]: /proc/asound/card0/codec#0
	missing
Date: Sun, 9 Jul 2006 12:15:28 +0200
Message-ID: <f426b8eee58e73f37e5d4ffc7653d432@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F7C726E
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 12:15:28 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1958> 
======================================================================
Reported By:                chibo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1958
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu (Breezy)
Kernel Version:             2.6.12-10-386
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2006 13:28 CET
Last Modified:              07-09-2006 12:15 CEST
======================================================================
Summary:                    /proc/asound/card0/codec#0 missing
Description: 
The file /proc/asound/card0/codec#0 doesn't exist and /proc/asound/cards
has only a single line: --- no soundcards ---

lsmod | grep snd
snd_hda_intel          18196  0
snd_hda_codec         139056  1 snd_hda_intel
snd_pcm_oss            45984  0
snd_mixer_oss          16640  1 snd_pcm_oss
snd_pcm                85768  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              23044  1 snd_pcm
snd                    56904  7
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9184  1 snd
snd_page_alloc         10632  2 snd_hda_intel,snd_pcm

lspci | grep Audio
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)

======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 19:08 
----------------------------------------------------------------------
There must be related kernel error messages.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-06 13:28 chibo          New Issue                                    
03-24-06 13:28 chibo          Distribution              => Ubuntu (Breezy) 
03-24-06 13:28 chibo          Kernel Version            => 2.6.12-10-386   
03-24-06 14:22 chibo          Issue Monitored: chibo                       
03-29-06 19:08 tiwai          Note Added: 0009009                          
03-29-06 22:32 palcolor       Issue Monitored: palcolor                    
07-09-06 12:15 Adrian Bunk    Status                   new => closed       
07-09-06 12:15 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

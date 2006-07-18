From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001693]: Alsaconf (iguration) failed :
	snd_ctl_open error: Invalid argument
Date: Tue, 18 Jul 2006 14:43:03 +0200
Message-ID: <20cca5ef7806b1ae549089571f0e1395@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D6C8176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:43:03 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1693> 
======================================================================
Reported By:                Smat
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1693
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian sarge
Kernel Version:             2.6.8-11-amd64-k8
======================================================================
Date Submitted:             12-29-2005 16:20 CET
Last Modified:              07-18-2006 14:43 CEST
======================================================================
Summary:                    Alsaconf (iguration) failed : snd_ctl_open error:
Invalid argument
Description: 
I have a Soundblaster live!
alsa-base and alsa-utils installed
1)launchin alsaconf:
Unloading ALSA sound driver modules: snd-emu10k1 snd-rawmidi snd-pcm-oss
snd-mixer-oss snd-pcm snd-timer snd-seq-device snd-ac97-codec
snd-page-alloc snd-util-mem snd-hwdep.
Building card database...

2)i chooose my soundcard emu10k1 Creative Labs SB Live! EMU10k1 (rev 08)
3)Configuring snd-emu10k1 Do you want to modify /etc/modprobe.d/sound (and
                  
  /etc/modprobe.conf if present)?  yes


4)
Running update-modules...
Architecture-specific modutils configuration not found, using defaults
Loading driver...
Setting default volumes...
Saving the mixer setup used for this in /var/lib/alsa/asound.state.
/usr/sbin/alsactl: get_controls:492: snd_ctl_open error: Invalid argument


===============================================================================

 Now ALSA is ready to use.
 For adjustment of volumes, use your favorite mixer.

 Have a lot of fun!  (but no fun for me!)

no sound reproduced
I have no solutions
This happened for the first time after i tried to compile
alsa-driver-1.0.9rc4a
 (./configure --with-cards=usb-audio --with-sequencer=yes) for my new 
(not supported i think) edirol PCR-A30 (usb audio interface and midi
keyboard)

thanks and sorry for bad english
Matteo

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-05 16:20 Smat           New Issue                                    
12-29-05 16:20 Smat           Distribution              => Debian sarge    
12-29-05 16:20 Smat           Kernel Version            => 2.6.8-11-amd64-k8
12-30-05 14:25 Smat           Issue Monitored: Smat                        
12-30-05 14:25 Smat           Issue End Monitor: Smat                      
07-18-06 14:43 jcdutton       Status                   new => assigned     
07-18-06 14:43 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

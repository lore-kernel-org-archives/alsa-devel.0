From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001946]: cs46xx in Thinkapad A21m
	after suspend/resume doesn't play
Date: Thu, 29 Jun 2006 05:38:39 +0200
Message-ID: <b577f16009009f8a32c2941f7cdd4ecb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C722118F
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 05:38:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1946> 
======================================================================
Reported By:                marvin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1946
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.16-RC6
======================================================================
Date Submitted:             03-20-2006 20:15 CET
Last Modified:              06-29-2006 05:38 CEST
======================================================================
Summary:                    cs46xx in Thinkapad A21m after suspend/resume
doesn't play
Description: 
When I suspend to Ram and resume cs46xx stop working. If I rmmod modprobe
snd_cs46xx sound start working, but If I do this often comp sometime
freeze when I try suspend to RAM.




======================================================================

----------------------------------------------------------------------
 Raymond - 06-29-06 03:14 
----------------------------------------------------------------------
cat /proc/asound/pcm

How do you configure cs46xx ? with/without  cs46xx-new-dsp

It seem that supsend routine only suspend one device 

	snd_pcm_suspend_all(chip->pcm);

----------------------------------------------------------------------
 dottedmag - 06-29-06 05:38 
----------------------------------------------------------------------
>cat /proc/asound/pcm

00-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
00-01: CS46xx - Rear : CS46xx - Rear : playback 31
00-00: CS46xx : CS46xx : playback 31 : capture 1

>How do you configure cs46xx ? with/without cs46xx-new-dsp

with cs46xx-new-dsp

FYU: OSS driver works fine with suspend/resume, but it does more work in
resume handler.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-20-06 20:15 marvin         New Issue                                    
03-20-06 20:15 marvin         Distribution              => Debian Sarge    
03-20-06 20:15 marvin         Kernel Version            => 2.6.16-RC6      
03-22-06 00:42 marvin         Note Added: 0008765                          
03-25-06 21:03 marvin         Issue Monitored: marvin                      
03-30-06 20:43 philstopford   Note Added: 0009037                          
03-30-06 21:24 marvin         Note Added: 0009039                          
03-31-06 21:25 philstopford   Issue Monitored: philstopford                    
04-21-06 18:20 fizban         Issue Monitored: fizban                      
04-23-06 02:08 cull           Note Added: 0009439                          
06-20-06 16:25 dottedmag      Note Added: 0010337                          
06-20-06 16:25 dottedmag      Issue Monitored: dottedmag                    
06-29-06 03:14 Raymond        Note Added: 0010637                          
06-29-06 05:38 dottedmag      Note Added: 0010640                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

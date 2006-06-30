From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002221]: Volume entirely too faint on
	82801g ich7
Date: Fri, 30 Jun 2006 10:00:14 +0200
Message-ID: <63de48a02f2057e9e50ffb7dcd69d64e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 93D8E294
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 10:00:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2221> 
======================================================================
Reported By:                mlfarrell
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2221
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Suse 10.1
Kernel Version:             2.6.16.13-4-smp
======================================================================
Date Submitted:             06-19-2006 02:19 CEST
Last Modified:              06-30-2006 10:00 CEST
======================================================================
Summary:                    Volume entirely too faint on 82801g ich7
Description: 
I've seen this bug online many times with a resolution of upgrading to alsa
1.0.11, but I upgaded and am still having the issue.

I'm using an hp pavilion dv8000 laptop with built-in altec lansing
speakers.

Windows reports the soundcard as conexant high definition audio, linux as
82801g (ich7).  I've tried setting every model I know in the
/etc/modprobe.d/sound file for the hda-intel driver and am still having a
lack of useful volume sliders.  The key ones that I need are "pc speaker"
to turn it down cause its way too loud and "external amplifier" to turn up
the laptop's altec lansing speakers (sound volume is decent out of the
headphone jack).

Even with the volume all the way up (both master and pcm) I'm getting
sound thats almost too faint to hear.  


======================================================================

----------------------------------------------------------------------
 mlfarrell - 06-25-06 01:53 
----------------------------------------------------------------------
yea, I've never been as frustrated in my life as I have been in the last
hour.

I'm just gonna leave it alone and get external speakers.  Conexant blows

----------------------------------------------------------------------
 mlfarrell - 06-30-06 10:00 
----------------------------------------------------------------------
So I bought external speakers and they are working well in linux.  I do
notice that anything played through alsa is extremely scratchy though
(skips and pops galore).  Alsa through xmms actually stops playing and
locks up the program sometimes.  I've gotten around it by using oss
whenever possible (ie export SDL_AUDIODRIVER=dsp for games and such).  Any
ideas why the audio quality in alsa is so poor?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-19-06 02:19 mlfarrell      New Issue                                    
06-19-06 02:19 mlfarrell      Distribution              => Suse 10.1       
06-19-06 02:19 mlfarrell      Kernel Version            => 2.6.16.13-4-smp 
06-19-06 21:59 mlfarrell      Issue Monitored: mlfarrell                    
06-20-06 19:49 tiwai          Note Added: 0010347                          
06-20-06 23:38 mlfarrell      Note Added: 0010358                          
06-20-06 23:42 rlrevell       Note Added: 0010360                          
06-21-06 00:46 mlfarrell      Note Added: 0010368                          
06-21-06 00:58 rlrevell       Note Added: 0010371                          
06-21-06 01:06 mlfarrell      Note Added: 0010372                          
06-21-06 01:23 rlrevell       Note Added: 0010373                          
06-22-06 05:01 mlfarrell      Note Added: 0010414                          
06-22-06 05:38 rlrevell       Note Added: 0010416                          
06-22-06 08:34 nellson        Note Added: 0010418                          
06-22-06 09:00 nellson        Note Added: 0010419                          
06-22-06 20:58 mlfarrell      Note Added: 0010428                          
06-23-06 10:15 sockenschuss   Note Added: 0010446                          
06-23-06 10:21 sockenschuss   Issue Monitored: sockenschuss                    
06-23-06 18:28 nellson        Note Added: 0010459                          
06-24-06 09:12 mlfarrell      Note Added: 0010468                          
06-24-06 16:59 rlrevell       Note Added: 0010475                          
06-24-06 21:35 sockenschuss   Note Added: 0010488                          
06-24-06 22:28 mlfarrell      Note Added: 0010490                          
06-24-06 23:26 rlrevell       Note Added: 0010491                          
06-25-06 00:08 mlfarrell      Note Added: 0010492                          
06-25-06 00:22 rlrevell       Note Added: 0010493                          
06-25-06 01:53 mlfarrell      Note Added: 0010496                          
06-30-06 10:00 mlfarrell      Note Added: 0010721                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

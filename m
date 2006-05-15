From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002122]: DMIX crashes Ekiga
Date: Mon, 15 May 2006 22:46:12 +0200
Message-ID: <7ccefb55cc12030acd3475d2fc0b4cc4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 35FC623C
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2006 22:46:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2122> 
======================================================================
Reported By:                dsandras
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   2122
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             05-13-2006 17:35 CEST
Last Modified:              05-15-2006 22:46 CEST
======================================================================
Summary:                    DMIX crashes Ekiga
Description: 
This problem is probably related to problem #2095 that was closed. 
Unfortunately, I can not reopen it, so I'm posting a new bug report.

When using DMIX, Ekiga crashes. This problem was not present with earlier
versions of libasound2. I applied all patches from CVS.
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-15-06 22:42 
----------------------------------------------------------------------
What are the contents of:

/proc/asound/cardX/pcmXp/subX/hw_params and
/proc/asound/cardX/pcmXp/subX/status

(replace X with the card/stream in use)

for the non-working (default) and working configs?

You have the latest alsa-lib and alsa-driver installed?

----------------------------------------------------------------------
 dsandras - 05-15-06 22:46 
----------------------------------------------------------------------
Not working:

cat /proc/asound/card0/pcm0p/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 16384
tick_time: 1000

cat /proc/asound/card0/pcm0p/sub0/status
state: RUNNING
trigger_time: 1147725878.542749000
tstamp      : 1147725923.490961000
delay       : -2149046
avail       : 2165430
avail_max   : 2165430
-----
hw_ptr      : 2149046
appl_ptr    : 0


Working :
cat /proc/asound/card0/pcm0p/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 256
buffer_size: 2048
tick_time: 1000

cat /proc/asound/card0/pcm0p/sub0/status
state: RUNNING
trigger_time: 1147725951.007094000
tstamp      : 1147725977.194283000
delay       : -1151388
avail       : 1153436
avail_max   : 1153436
-----
hw_ptr      : 1151388
appl_ptr    : 0

libasound 1.0.11 patches to fix the problems with latest "HG".
But not the latest drivers, but we can not impose our users to use latest
drivers anyway.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 17:35 dsandras       New Issue                                    
05-13-06 17:39 dsandras       Note Added: 0009795                          
05-13-06 17:41 dsandras       Note Added: 0009796                          
05-13-06 18:29 rlrevell       Note Added: 0009799                          
05-13-06 18:36 dsandras       Note Added: 0009800                          
05-13-06 18:37 dsandras       File Added: busytone.wav                     
05-15-06 10:35 tiwai          Status                   assigned => resolved
05-15-06 10:35 tiwai          Resolution               open => fixed       
05-15-06 10:35 tiwai          Note Added: 0009814                          
05-15-06 11:01 dsandras       Status                   resolved => feedback
05-15-06 11:01 dsandras       Resolution               fixed => reopened   
05-15-06 11:01 dsandras       Note Added: 0009816                          
05-15-06 11:07 tiwai          Note Added: 0009818                          
05-15-06 22:33 dsandras       Note Added: 0009828                          
05-15-06 22:42 rlrevell       Note Added: 0009829                          
05-15-06 22:46 dsandras       Note Added: 0009830                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

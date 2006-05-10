From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002087]: Audio still broken for Asus A8V-MX
Date: Wed, 10 May 2006 23:55:46 +0200
Message-ID: <61c5c5c6ec23d6eeaf5d57378bf13f45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10AC21A3
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 23:55:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2087> 
======================================================================
Reported By:                myxie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2087
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-30-2006 23:33 CEST
Last Modified:              05-10-2006 23:55 CEST
======================================================================
Summary:                    Audio still broken for Asus A8V-MX
Description: 
The patches integrated (see issue 0001622) into the latest release of ALSA
make the on-board audio more usuable, but there are still significant
issues.

Playing an audio file results in a freeze for 10 seconds, followed by a
write error and then the audio continues normally. I noticed a second
write error later on in the stream.

I am happy to try patches, turn on debugging flags etc. Let me know.

======================================================================

----------------------------------------------------------------------
 tiwai - 05-10-06 18:20 
----------------------------------------------------------------------
Try to get register dumps from /proc/asound/card0/via82xx during playback
in various states.

----------------------------------------------------------------------
 myxie - 05-10-06 23:55 
----------------------------------------------------------------------
I'm attaching a series of register dumps gathered with

i=0; while true; do { date '+%Y%m%dT%H%M%S.%N'; cat
/proc/asound/card0/via82xx; } >/tmp/regdump_$(printf %06d $i); i=$[$i+1];
done

starting before and ending after an ogg123 run. I let this play for a
little while after the 10 second pause.

regdumps

0000-0499 silence
0500-0576 first burst of playback
0577-2668 10 seconds silence
2669-3193 continuous audio
3193-3656 silence

regdumps in a compressed tar archive.

Myxie.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-30-06 23:33 myxie          New Issue                                    
04-30-06 23:33 myxie          Distribution              => Debian          
04-30-06 23:33 myxie          Kernel Version            => 2.6.16          
05-02-06 17:57 tiwai          Note Added: 0009562                          
05-05-06 18:40 myxie          Note Added: 0009628                          
05-05-06 19:58 myxie          File Added: lsof.ogg123                      
05-05-06 19:58 myxie          File Added: lsof.mplayer                     
05-05-06 19:59 myxie          Note Added: 0009629                          
05-05-06 20:59 karsten        Note Added: 0009630                          
05-05-06 21:29 myxie          File Added: lspci.txt                        
05-05-06 21:30 myxie          Note Added: 0009631                          
05-08-06 18:09 myxie          Note Added: 0009646                          
05-08-06 18:10 myxie          File Added: aadebug.txt                      
05-08-06 18:31 myxie          Note Added: 0009647                          
05-08-06 21:31 myxie          Note Added: 0009648                          
05-10-06 16:14 tiwai          Note Added: 0009721                          
05-10-06 17:13 myxie          Note Added: 0009736                          
05-10-06 17:18 tiwai          Note Added: 0009737                          
05-10-06 17:38 myxie          Note Added: 0009742                          
05-10-06 18:20 tiwai          Note Added: 0009747                          
05-10-06 23:55 myxie          Note Added: 0009752                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

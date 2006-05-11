From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002087]: Audio still broken for Asus A8V-MX
Date: Thu, 11 May 2006 20:47:28 +0200
Message-ID: <7923455d7da700939507c38d57f97163@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DCF60198
	for <alsa-devel@alsa-project.org>; Thu, 11 May 2006 20:47:28 +0200 (MEST)
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
Last Modified:              05-11-2006 20:47 CEST
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
 myxie - 05-11-06 19:53 
----------------------------------------------------------------------
HG latest seems to work fine. I'm a bit too for away to hear anything, but
there are no 10 second pauses with aplay, ogg123 (or mplayer).

I could not find much on the patch that referred to "some ALSA clients"
but it looks like someone else (Andrew Daviel?) ran into the same problem
and determined the fix.

I'll confirm whether the audio is fine in a couple of hours.

Sorry for the wild goose chase.

Myxie.

----------------------------------------------------------------------
 myxie - 05-11-06 20:47 
----------------------------------------------------------------------
Audio is fine with this patch.

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=915a0d954915;style=gitweb

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
05-10-06 23:56 myxie          File Added: regdumps.tgz                     
05-11-06 00:10 myxie          Note Added: 0009754                          
05-11-06 18:31 tiwai          Note Added: 0009765                          
05-11-06 18:32 tiwai          File Added: via8251-more-fix.diff                 
  
05-11-06 18:47 myxie          Note Added: 0009766                          
05-11-06 18:51 tiwai          Note Added: 0009767                          
05-11-06 19:53 myxie          Note Added: 0009768                          
05-11-06 20:47 myxie          Note Added: 0009769                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

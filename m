From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002087]: Audio still broken for Asus A8V-MX
Date: Mon, 8 May 2006 18:31:49 +0200
Message-ID: <8d5ad86bec739832949774b4c0492226@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F490186
	for <alsa-devel@alsa-project.org>; Mon,  8 May 2006 18:31:49 +0200 (MEST)
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
Last Modified:              05-08-2006 18:31 CEST
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
 myxie - 05-08-06 18:09 
----------------------------------------------------------------------
I'm adding the full aadebug output as well.

Only error was "cat: /proc/asound/hwdep: No such file or directory".

Myxie.

----------------------------------------------------------------------
 myxie - 05-08-06 18:31 
----------------------------------------------------------------------
The Wiki also suggests using CONFIG_SND_DEBUG=y and turning on xrun_debug.

I'll give this a go later today. Is there anything particular I should be
looking for?

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

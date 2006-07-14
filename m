From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001044]: Heavily distorted audio
Date: Sat, 15 Jul 2006 01:58:48 +0200
Message-ID: <b8b8134431d080f83d048649a964b0aa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3378321E
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Jul 2006 01:58:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1044> 
======================================================================
Reported By:                jefferai
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1044
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.15
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             04-11-2005 17:41 CEST
Last Modified:              07-15-2006 01:58 CEST
======================================================================
Summary:                    Heavily distorted audio
Description: 
I have a laptop that is fine by itself, but when plugged into my docking
station I get heavily distorted audio when something plays either
directly to hw0:0 or through the OSS emulation. The problem seems to be
with sample rate conversion -- if I create my own dmix-based device that
resamples audio to 48KHz and then plays it to hw0:0, and I have an
ALSA-aware app that lets me define which device to use and set it to
that device, the audio is beautiful both on and off of the docking
station.  Unfortunately, not all apps allow these settings, so things such
as RealPlayer and Flash (in Firefox) sound horrid if I'm on my docking
station, which is most of the time.

I've seen this same problem through three Linux distributions now
(Gentoo, SuSE, and Fedora Core 3) on the same laptop so I know it's an
ALSA issue (or configuration issue) and not distribution-specific.

I've hard-set the ac97 clock option in the snd-intel8x0 module to 48000
but this
doesn't help, and my clock is detected as being 48000Hz anyways.  I
don't know what to do.  Some people have said to point OSS apps to
/dev/adsp but apps complain it's not a valid device, and anyways pointing
to anything but /dev/dsp doesn't seem to be an option for all apps. 
Besides, I'd still have the ALSA issues for apps that don't let you define
which device to use.

Following are relevant snippets of files.  I'm on up-to-date Gentoo
linux using the Gentoo alsa-driver, alsa-tools, alsa-headers, alsa-lib,
and alsa-oss ebuilds, all 1.0.8.  Configuration files are the defaults
(I added the extra device with a .asoundrc).

TIA,
Jeff
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-01-06 01:34 
----------------------------------------------------------------------
Hmm, with alsa-lib 1.0.9b or later, dmix should be used by default with
this device - can you double check that disabling the .asoundrc and using
the "default" device (aplay file.wav) does not work?

----------------------------------------------------------------------
 rlrevell - 03-01-06 01:35 
----------------------------------------------------------------------
Also what's the exact model of the laptop?

This might be hard to fix (lack of documentation)...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-11-05 17:41 jefferai       New Issue                                    
04-11-05 17:41 jefferai       Distribution              => Gentoo          
04-11-05 17:41 jefferai       Kernel Version            => 2.6.11-ck3      
04-12-05 16:32 tiwai          Note Added: 0004448                          
04-12-05 18:13 jefferai       Note Added: 0004457                          
04-12-05 18:39 tiwai          Note Added: 0004458                          
12-30-05 04:42 rlrevell       Note Added: 0007219                          
03-01-06 01:02 rlrevell       Status                   new => closed       
03-01-06 01:29 jefferai       Kernel Version           2.6.11-ck3 => 2.6.15
03-01-06 01:29 jefferai       Status                   closed => feedback  
03-01-06 01:29 jefferai       Resolution               open => reopened    
03-01-06 01:29 jefferai       Note Added: 0008258                          
03-01-06 01:34 rlrevell       Note Added: 0008260                          
03-01-06 01:35 rlrevell       Note Added: 0008261                          
04-14-06 03:31 Ensnared       Issue Monitored: Ensnared                    
07-15-06 01:58 Adrian Bunk    Status                   feedback => closed  
07-15-06 01:58 Adrian Bunk    Resolution               reopened => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001044]: Heavily distorted audio
Date: Fri, 30 Dec 2005 04:42:13 +0100
Message-ID: <b656164b4e8efc3d9ba8a809dc087c86@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C30191A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:42:13 +0100 (MET)
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
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11-ck3
======================================================================
Date Submitted:             04-11-2005 17:41 CEST
Last Modified:              12-30-2005 04:42 CET
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
 tiwai - 04-12-05 18:39 
----------------------------------------------------------------------
Both alsa-driver and alsa-lib must be updated to the same version.
Especially, 1.0.9rc2 alsa-lib might lead to a kernel Oops with the older
alsa-driver.  alsa-utils can be kept old, though.

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:42 
----------------------------------------------------------------------
Any improvement with later releases?

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

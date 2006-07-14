From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000130]: Realtek ALC202 rev 0: hanging
	playback on plughw:0, 4
Date: Fri, 14 Jul 2006 21:01:56 +0200
Message-ID: <fa38b8b14d4d3b178adb3a44a15951fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 55485197
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 21:01:56 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=130> 
======================================================================
Reported By:                Csan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   130
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Debian GNU/Linux sid
Kernel Version:             2.6.3-1-686
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-13-2004 07:32 CET
Last Modified:              07-14-2006 21:01 CEST
======================================================================
Summary:                    Realtek ALC202 rev 0: hanging playback on plughw:0,4
Description: 
while 'aplay -D plughw:0,0 test.wav' works, when I try to use the other
playback device playback hangs

======================================================================

----------------------------------------------------------------------
 Csan - 07-01-04 17:00 
----------------------------------------------------------------------
Yes it does work:

# aplay -Dspdif foo.wav
Playing WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo

as also does:

# aplay -D plughw:0,0 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo

but plughw:0,4 hangs (also in xmms - xmms doesn't list 'spdif'):

# aplay -D plughw:0,4 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
Aborted by signal Interrupt...

# cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.5a.
Compiled on Jun 22 2004 for kernel 2.6.6-2-686.
csanote:~# alsactl --version
alsactl version 1.0.5

----------------------------------------------------------------------
 rlrevell - 12-30-05 03:52 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-04 07:32 Csan           New Issue                                    
03-13-04 07:32 Csan           Distribution              => Debian GNU/Linux sid
03-13-04 07:32 Csan           Kernel Version            => 2.6.3-1-686     
03-13-04 07:43 Csan           Note Added: 0000590                          
03-13-04 07:48 Csan           Note Added: 0000591                          
03-13-04 17:47 perex          Severity                 major => feature    
03-13-04 17:49 perex          Note Added: 0000595                          
05-18-04 16:47 Csan           Note Added: 0001142                          
05-25-04 15:09 tiwai          Note Added: 0001214                          
07-01-04 17:00 Csan           Note Added: 0001372                          
12-30-05 03:52 rlrevell       Note Added: 0007191                          
07-14-06 21:01 Adrian Bunk    Status                   new => resolved     
07-14-06 21:01 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

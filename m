From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002170]: No S/PDIF controls on STAC
	9200
Date: Fri, 7 Jul 2006 16:19:04 +0200
Message-ID: <232c0699c1b1cb84d760ffd3cb574da2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6241E165
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 16:19:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2170> 
======================================================================
Reported By:                mini
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2170
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-29-2006 12:34 CEST
Last Modified:              07-07-2006 16:19 CEST
======================================================================
Summary:                    No S/PDIF controls on STAC 9200
Description: 
I know this laptop (Dell XPS M1710) has S/PDIF out, but there is no ALSA
control for it in alsamixer.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-07-06 14:42 
----------------------------------------------------------------------
Did you test it with AC, i.e. AC on the whole time from boot to test ?

Anyway, you should use a different program for testing.  For example, you
can use aplay like:

  % aplay -Dspdif foo.wav

for playing a WAV over SPDIF.  First try a WAV file with 48kHz/2ch/16bit. 
There might be a problem with another sample rate.

----------------------------------------------------------------------
 mini - 07-07-06 16:19 
----------------------------------------------------------------------
I tried a wav-file with "RIFF (little-endian) data, WAVE audio, Microsoft
PCM, 16 bit, stereo 48000 Hz" and aplay -D spdif.

No sound.... even though the alsamixer control is enabled.

Booting on AC or not does not seem to make any difference.

Oh well...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-06 12:34 mini           New Issue                                    
05-29-06 12:34 mini           Distribution              => Ubuntu Dapper   
05-29-06 12:34 mini           Kernel Version            => 2.6.15          
07-02-06 23:54 mini           Note Added: 0010795                          
07-06-06 19:46 tiwai          Note Added: 0010873                          
07-06-06 23:12 mini           Note Added: 0010884                          
07-06-06 23:22 mini           Note Added: 0010885                          
07-07-06 12:48 tiwai          Note Added: 0010906                          
07-07-06 13:59 mini           Note Added: 0010909                          
07-07-06 14:42 tiwai          Note Added: 0010912                          
07-07-06 16:19 mini           Note Added: 0010914                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

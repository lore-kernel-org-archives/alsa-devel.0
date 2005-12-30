From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000130]: Realtek ALC202 rev 0: hanging playback on plughw:0,4
Date: Fri, 30 Dec 2005 03:52:40 +0100
Message-ID: <81a8812789752f9bf4a1b9cfb358e55e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE1FD1A6
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 03:52:40 +0100 (MET)
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
Status:                     new
Distribution:               Debian GNU/Linux sid
Kernel Version:             2.6.3-1-686
======================================================================
Date Submitted:             03-13-2004 07:32 CET
Last Modified:              12-30-2005 03:52 CET
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

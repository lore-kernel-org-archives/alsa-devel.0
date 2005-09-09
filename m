From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001378]: Surround Channel and Surround mixer doesn't work with a CM9761chip
Date: Fri, 9 Sep 2005 20:14:22 +0200
Message-ID: <6dda5e1bfb31ace5a847b955e8d15c72@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DAC53189
	for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2005 20:14:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1378> 
======================================================================
Reported By:                midnight
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1378
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sid
Kernel Version:             2.6.12.5
======================================================================
Date Submitted:             08-30-2005 11:33 CEST
Last Modified:              09-09-2005 20:14 CEST
======================================================================
Summary:                    Surround Channel and Surround mixer doesn't work
with a CM9761chip
Description: 
The sound works fine on the center, LFE an front channels but I have no
sound on the rear channel. also, I can't change the volume of the surround
mixer in alsamixer (I can juste mute/unmute it).

I use the surround51 device to play my test sound and my test sound is a 6
channels one.

I use the via82xx module

thanks
======================================================================

----------------------------------------------------------------------
 midnight - 09-09-05 19:50 
----------------------------------------------------------------------
I have uninstalled the CVS version (because I have no sound on center and
LFE) and installed the 1.09 version.

with "speaker-test -c6 -Dsurround51" I have sound on the front Right and
left, the front speakers and LFE don't work very well. 
if I mute /unmute each channels individualy in alsamixer while speaker
test is running it works fine but the sound is always on the center
speaker (for center and LFE). 
also, the sound in the center speaker crackle. I have no sound on the
rears speakers.

after running "echo 64 1cb8 > /proc/asound/card0/codec97#0/ac97#0-0+regs"


with "speaker-test -c6 -Dsurround51" , the rear right and left speakers
and the rears right and left speakers works fine but it 's the same for
the center and LFE speakers.

I will try another version because the center and LFE speakers has already
worked fine with another version.

with speaker-test -c6, I have sound only on the front speakers.

----------------------------------------------------------------------
 tiwai - 09-09-05 20:14 
----------------------------------------------------------------------
Forget 1.0.9b.  There were known bugs regarding surrounds there.

For testing, you should use "hw:0,1" instead of "surround51".  The latter
may reset the register value.

Try to flip other bits of the register 0x64 on/off.
The relevant bits are: Bit 12 (0x1000) should be CLFE on/off, bit 11
(0x0800) Mic/Center share, 7 (0x0080) Mic/LFE share.
The bit 3 (0x0008) is the surround control, bit 10 the line/surround
share.

Also, don't forget to unmute 'Surround', 'Center' and 'LFE' mixer volumes.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 11:33 midnight       New Issue                                    
08-30-05 11:33 midnight       Distribution              => Debian Sid      
08-30-05 11:33 midnight       Kernel Version            => 2.6.12.5        
09-07-05 11:20 midnight       Note Added: 0006053                          
09-07-05 15:32 tiwai          Note Added: 0006054                          
09-08-05 01:10 midnight       Note Added: 0006069                          
09-08-05 18:58 tiwai          Note Added: 0006076                          
09-08-05 19:00 midnight       Note Added: 0006077                          
09-08-05 19:12 tiwai          Note Added: 0006080                          
09-08-05 19:58 midnight       Note Added: 0006081                          
09-08-05 20:42 tiwai          Note Added: 0006082                          
09-08-05 20:44 tiwai          Note Added: 0006083                          
09-08-05 23:20 midnight       Note Added: 0006084                          
09-09-05 12:47 tiwai          Note Added: 0006096                          
09-09-05 14:16 midnight       File Added: ac97#0-0                         
09-09-05 14:16 midnight       File Added: asound.state                     
09-09-05 14:21 midnight       Note Added: 0006097                          
09-09-05 14:29 tiwai          Note Added: 0006098                          
09-09-05 14:54 midnight       Note Added: 0006099                          
09-09-05 16:32 tiwai          Note Added: 0006100                          
09-09-05 19:50 midnight       Note Added: 0006104                          
09-09-05 20:14 tiwai          Note Added: 0006105                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001183]: Details about known bug "Capture doesn't work"
Date: Wed, 22 Mar 2006 00:37:08 +0100
Message-ID: <ef413b8aa540859ba30c0078a87a26ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 661731DE
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 00:37:08 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0000895.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1183> 
======================================================================
Reported By:                Jochen
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1183
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-11-2005 20:34 CEST
Last Modified:              03-22-2006 00:37 CET
======================================================================
Summary:                    Details about known bug "Capture doesn't work"
Description: 
I'm experiencing the problem with es1968 not supporting capture described
in various places. This bug keeps me from using skype: the second it tries
to read from the OSS compatibility device it receives and EINVAL

using the old OSS maestro driver works thou.

apparently this is the known bug "capture doesn't work"

I'd like to ask for a little more information on this bug, and whether
it's possible to contribute here.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000895 Es1968 driver seems not to support &quo...
======================================================================

----------------------------------------------------------------------
 tiwai - 06-13-05 13:07 
----------------------------------------------------------------------
Could you describe more "details" about the bug?
What exactly skype tells?

----------------------------------------------------------------------
 Jochen - 06-13-05 15:53 
----------------------------------------------------------------------
Skype just tells me

read error, res = -1, handle = 28

handle 28 is the fd of /dev/dsp, here some excerpts from strace

[pid  4552] open("/dev/dsp", O_RDWR)    = 28
[pid  4552] ioctl(28, SNDCTL_DSP_GETCAPS, 0xb7a90d2c) = 0
[pid  4552] fcntl64(28, F_GETFL)        = 0x2 (flags O_RDWR)
[pid  4552] fcntl64(28, F_SETFL, O_RDWR) = 0
[pid  4552] ioctl(28, SNDCTL_DSP_SETFRAGMENT, 0x86f83e8) = 0
[pid  4552] ioctl(28, SNDCTL_DSP_STEREO, 0x86f83ec) = 0
[pid  4552] ioctl(28, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS, 0x86f83f0)
= 0
[pid  4552] ioctl(28, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE, 0x86f8404)
= 0
[pid  4552] ioctl(28, SNDCTL_DSP_GETOSPACE, 0xb7a90d30) = 0
[pid  4552] clone(Process 4559 attached
...
[pid  4559] read(28, 0xb790e060, 960) = -1 EINVAL (Invalid argument)
[pid  4559] fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1),
...}) = 0
[pid  4559] mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e12000
[pid  4559] write(1, "read error, res = -1 , handle = "..., 35) = 35

all previous accesses to fd 28 are of type write() (and result in various
sounds)

----------------------------------------------------------------------
 tiwai - 06-15-05 14:42 
----------------------------------------------------------------------
Compile ALSA drivers with debug option and see the kernel message whether
any relevant message appears.

----------------------------------------------------------------------
 LawrenceG - 09-26-05 10:20 
----------------------------------------------------------------------
I can confirm this behaviour on a Toshiba Satellite 4030cdt laptop. lspci
shows the sound chip as an ESS Technology ES1978 Maestro 2E rev 10.
Playback is working fine but attempts to read from /dev/dsp result in
consistant returned errors on the read call of Invalid Argument. An ioctl
(SNDCTL_DSP_GETISPACE) right before the read shows available 64k of buffer
space, but always returns 0 available bytes and 0 available fragments.
This problem is specific to the es1968 driver as the same application code
runs fine on another sound card (ensoniq) in another pc. Any chance of
getting this fixed? The laptop runs fine with the oss free drivers that
came with rh8... perhaps the recording code can be ported?

----------------------------------------------------------------------
 LawrenceG - 09-26-05 10:43 
----------------------------------------------------------------------
Another note... I can confirm that recording in stereo with audacity works
and recording in mono with audacity does not (some distorted wave that
looks like an undersampled sine offset by about 1/2 scale is the result).
This is using the latest ubuntu breezy preview with 2.6.12 kernel and alsa
1.0.9a.

----------------------------------------------------------------------
 rlrevell - 03-22-06 00:35 
----------------------------------------------------------------------
Was this fixed in later ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 20:34 Jochen         New Issue                                    
06-13-05 13:07 tiwai          Note Added: 0005007                          
06-13-05 15:53 Jochen         Note Added: 0005011                          
06-15-05 14:42 tiwai          Note Added: 0005028                          
09-26-05 10:04 LawrenceG      Issue Monitored: LawrenceG                    
09-26-05 10:20 LawrenceG      Note Added: 0006390                          
09-26-05 10:43 LawrenceG      Note Added: 0006391                          
03-22-06 00:35 rlrevell       Note Added: 0008763                          
03-22-06 00:37 rlrevell       Relationship added       related to 0000895  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

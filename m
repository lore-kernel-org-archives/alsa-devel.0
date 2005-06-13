From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001183]: Details about known bug "Capture doesn't work"
Date: Mon, 13 Jun 2005 15:53:05 +0200
Message-ID: <c5cd3c979c21c16e1854402518289e64@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0D1B01CA
	for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2005 15:53:05 +0200 (MEST)
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
Last Modified:              06-13-2005 15:53 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 20:34 Jochen         New Issue                                    
06-13-05 13:07 tiwai          Note Added: 0005007                          
06-13-05 15:53 Jochen         Note Added: 0005011                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

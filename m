From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3890] New: entry in dmesg log triggered via
 userspace
Date: Sun, 12 Dec 2004 17:36:16 -0800
Message-ID: <20041212173616.2541119f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Begin forwarded message:

Date: Sun, 12 Dec 2004 13:11:43 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3890] New: entry in dmesg log triggered via userspace


http://bugme.osdl.org/show_bug.cgi?id=3890

           Summary: entry in dmesg log triggered via userspace
    Kernel Version: 2.6.10-rc3 i686 AMD Athlon(tm) XP 2600+ AuthenticAMD -
                    vanilla,
            Status: NEW
          Severity: normal
             Owner: perex@perex.cz
         Submitter: bug-kernel@leroutier.net


Distribution: Gentoo
Hardware Environment: NForce2 onboard (in chipset)
Software Environment: gcc 3.4.3, PREMPT
Problem Description:

from time to time, i look to what dmesg has to say.
once, i found :

scheduling while atomic: totem/0x00000001/6529
 [<c02c5786>] schedule+0x4d6/0x590
 [<c02c5cdd>] schedule_timeout+0x5d/0xb0
 [<c0120550>] process_timeout+0x0/0x10
 [<c012093f>] msleep+0x2f/0x40
 [<e0e5718c>] snd_intel8x0_setup_pcm_out+0xec/0x1b0 [snd_intel8x0]
 [<e0e572e4>] snd_intel8x0_pcm_prepare+0x94/0xb0 [snd_intel8x0]
 [<e0dd9a11>] snd_pcm_do_prepare+0x11/0x40 [snd_pcm]
 [<e0dd8ce8>] snd_pcm_action_single+0x38/0xa0 [snd_pcm]
 [<e0dd8f00>] snd_pcm_action_nonatomic+0x80/0x90 [snd_pcm]
 [<e0dd9ac7>] snd_pcm_prepare+0x57/0x80 [snd_pcm]
 [<e0ddc2c6>] snd_pcm_playback_ioctl1+0x56/0x320 [snd_pcm]
 [<e0ddc8a0>] snd_pcm_playback_ioctl+0x40/0x60 [snd_pcm]
 [<c0166db1>] sys_ioctl+0x1e1/0x250
 [<c0102719>] sysenter_past_esp+0x52/0x71

it is not an oops, but i suppose it has a purpose (other than filling logs)

Steps to reproduce:
sorry, i really don't know. it looks like i was using totem (with gstreamer
backend) when i triggered it

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

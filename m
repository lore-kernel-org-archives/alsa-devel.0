From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: kernel reboots and possible silencing bug
Date: Wed, 14 May 2003 14:03:16 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305141351430.20199-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

ALSA driver 0.9.2 rebuilt from freshrpms.net (fr1) packages results in
kernel oops and subsequent reboot. Anyone else sees this? Few notes:

- happens on both cs4281 and usb-audio drivers so
  shouldn't be a driver specific issue
- triggered on every application run, and only after
  a few minutes of operation
- increase of load makes the bug more likely to occur
  (-> possibly related to xrun and/or silencing code)
- happens both on IBM X20 and X21 thinkpads (tested
  multiple machines) 
- redhat kernel 2.4.18-27.8.0
- so far only happens with applications that utilize ALSA's 
  silencing

I've rebuilt 0.9.3a from sources and with full debug enabled,
and I so far no oops... Still, I do get the following 
assert failure:

ALSA ../alsa-kernel/core/pcm_lib.c:89: BUG? (frames >= runtime->silenced_size) (called from d4910db3)
ALSA ../alsa-kernel/core/pcm_lib.c:89: BUG? (frames >= runtime->silenced_size) (called from d4910db3)
ALSA ../alsa-kernel/core/pcm_lib.c:89: BUG? (frames >= runtime->silenced_size) (called from d4910db3)
ALSA ../alsa-kernel/core/pcm_lib.c:89: BUG? (frames >= runtime->silenced_size) (called from d4910db3)
ALSA ../alsa-kernel/core/pcm_lib.c:89: BUG? (frames >= runtime->silenced_size) (called from d4910db3)
ALSA ../alsa-kernel/core/pcm_lib.c:89: BUG? (frames >= runtime->silenced_size) (called from d4910db3)
ALSA ../alsa-kernel/core/pcm_lib.c:89: BUG? (frames >= runtime->silenced_size) (called from d4910db3)

[demo@localhost src]$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 0.9.3a.
Compiled on May 13 2003 for kernel 2.4.18-27.8.0 with versioned symbols.

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

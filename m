From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: ice1712 halts completely
Date: Wed, 5 Feb 2003 01:29:46 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302050112240.920-100000@ecabase.localdomain>
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

Has anyone else seen this?

In the middle of playback my midiman-44 stops processing completely (no
interrupts, no activity, tried with multiple apps).  Reloading modules
succeeds, but still no sound. Dmesg shows:

ALSA ../alsa-kernel/core/pcm_lib.c:187: Unexpected hw_pointer value (stream = 0, delta: -629, max jitter = 3276): wrong interrupt acknowledge?
ALSA ../alsa-kernel/core/pcm_lib.c:2117: playback write error (DMA or IRQ trouble?)

ALSA is a recent version from CVS:

/proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.0rc6.
Compiled on Jan 22 2003 for kernel 2.4.19 (SMP) with versioned symbols.

... I'll continue debugging. Next I'll reboot into non-SMP mode 
and see if I can reproduce the problem.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

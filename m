From: drclaw@dogsolitude.org
Subject: VT8233/A/8235 Clock Problem
Date: Sun, 7 Dec 2003 14:01:19 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031207190119.GA10931@dogsolitude.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi, I've got a motherboard with a builtin soundcard, proc/pci says:
VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 80)
(The Mobo is a Gigabyte GA-7VAX, a VIA KT400 chipset with a VT8235)

and I find that (on Line 83 in alsa-kernel/pci/via82xx.c) the:
static int ac97_clock[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 48000};

...works better for me when the 48000 is changed to 44100.  For some
reason whenever I try to play old Loki games, it'll basically play
cycles of samples (too fast) with pops in the middle unless I change the
file in this manner.  I'm specifically doing this through the oss driver
to an old Loki game.  Thought you might want to know and possibly modify
the file or, more likely, find a better solution.  

784 - Michael C. Piantedosi - drclaw@dogsolitude.org


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

From: "thewade" <pdman@aproximation.org>
Subject: hdsploader causes Ooops in kernel 2.6.8.1 and AMD64
Date: Fri, 10 Sep 2004 19:51:13 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409110151.i8B1pDfb003976@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

Im trying to solve my own problem, which is getting the hammerfall to 
work on my AMD64 laptop running Fedora Core 3 test 1 and the standard 
kernel 2.6.8.1.

On boot I get Found hammerfall dsp: no multiface or digiface connected: 
waiting for firmware even when the multiface is connected. If I run 
hdsploader I get a kernel Ooops (Ive posted it here before so Ill safe 
you the lines to look at).

When looking at the code I obviously get as far as:
printf(\"Upload firmware for card %s\\n\", card_name);
in hdsploader.c but to look further I need to know something about:
snd_hwdep_t *hw;
as the error either happens in:
-snd_hwdep_open
-snd_hwdep_ioctl
-read_bin_file

snd_hwdep_type_t is:
/** HwDep handle type */
typedef enum _snd_hwdep_type {
        /** Kernel level HwDep */
        SND_HWDEP_TYPE_HW,
        /** Shared memory client HwDep (not yet implemented) */
        SND_HWDEP_TYPE_SHM,
        /** INET client HwDep (not yet implemented) */
        SND_HWDEP_TYPE_INET
} snd_hwdep_type_t;
But I dont know what any of the values are.

I havent programmed c in a LONG time so I dont know how effective I 
will be. i thank you for whatever help you can give me.

-thewade


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php

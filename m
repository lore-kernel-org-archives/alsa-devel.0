From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Fix compiler warnings and magic numbers in
 sscape
Date: Sun, 12 Oct 2003 10:43:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310121042210.6682@pnote.perex-int.cz>
References: <200310112251.h9BMp8ie014756@wittsend.radionet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310112251.h9BMp8ie014756@wittsend.radionet>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Oct 2003, Chris Rankin wrote:

> Hi,
>
> I'm not entirely sure why this change was made because the microcode
> structure was never being copied onto the kernel stack. However, there

The problem is with _IO*() macros. The size of passed structure can be
at maximum 8192 bytes while 65536 is much greater than this limit.

> is certainly no need for the magic number of 65536 to be included
> everywhere. There was also a compiler warning in the sscape_ctl tool.

Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php

From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [2.5 patch] ALSA: remove #if'd kernel 2.2 code
Date: Tue, 21 Jan 2003 11:54:19 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301211152470.2009-100000@pnote.perex-int.cz>
References: <20030119103350.GB10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA22142
	for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2003 11:54:22 +0100
In-Reply-To: <20030119103350.GB10647@fs.tum.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 19 Jan 2003, Adrian Bunk wrote:

> On Sat, Jan 18, 2003 at 09:32:50PM +0100, Jaroslav Kysela wrote:
> > 
> > Nice patch, but we turn in the maintaince nightmare, because our CVS tree
> > contains shared sources among all kernels. I'll give a look what I can do
> > to remove this code.
> 
> This code is still shared and used with 2.2 kernels?

Yes, we share the code in our build system (outside kernel) with 2.2 and
2.4 kernels. Perhaps, we can use some own preprocessor to cleanup the
sources for 2.5 tree.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

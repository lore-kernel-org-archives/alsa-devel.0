From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [2.5 patch] ALSA: remove #if'd kernel 2.2 code
Date: Sat, 18 Jan 2003 21:32:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301182128590.1425-100000@pnote.perex-int.cz>
References: <20030117155655.GE2333@fs.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA29481
	for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2003 21:32:57 +0100
In-Reply-To: <20030117155655.GE2333@fs.tum.de>
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

On Fri, 17 Jan 2003, Adrian Bunk wrote:

> Hi Jaroslav,
>
> the patch below removes #if'd code for kernel 2.2 (and in one place for
> kernel < 2.4.18) from ALSA.
>
> I've tested the compilation with 2.5.59.
>
> Please apply

Nice patch, but we turn in the maintaince nightmare, because our CVS tree
contains shared sources among all kernels. I'll give a look what I can do
to remove this code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en

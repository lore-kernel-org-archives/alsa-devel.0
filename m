From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: also does not compile if only using module drivers
Date: Fri, 8 Mar 2002 12:26:13 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203081225180.541-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA23642
	for <alsa-devel@alsa-project.org>; Fri, 8 Mar 2002 12:27:08 +0100
In-Reply-To: <20020308121317.A28974@outpost.ds9a.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: bert hubert <ahu@ds9a.nl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Mar 2002, bert hubert wrote:

> With ALSA in kernel 2.5.6 and all sound cards compiled as modules,
> sound/core/pcm.c & friends are not built into snd-pcm.o and linked into the
> main kernel, leading to a lot of unresolved symbols.

Could you explain your more problem more? I don't see it clearly. You may 
send me your linux/.config (ALSA section) as well. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

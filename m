From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: devfs OSS /dev/sound/* problem.
Date: Mon, 10 Mar 2003 15:08:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303101507470.1303-100000@pnote.perex-int.cz>
References: <200303101057.AA55640994@embedded.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA05721
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2003 15:08:22 +0100
In-Reply-To: <200303101057.AA55640994@embedded.cl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander <mjander@embedded.cl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Mar 2003, mjander wrote:

> Hello,
> 
> I noticed the  following bug:
> 
> If i load more than one soundcard driver  (example ens1371 and
> intel8x0),
> with OSS support i  get a error message  from "devfs", that it 
> "could not append
> to /dev/sound", and the second  soundcard is  unable to create its
> OSS /dev/sound/*
> file nodes.
> 
> I noticed similar bugs in other OSS sound drivers before, but it
> semes that very few people  use devfs. Yesterday i checked with
> 0.9rc8d (previous tests with 0.9rc7) and the problem is  still there.
> 
> I semes to me that the file node index passes to the corresponding
> devfs_register() calls is static rather incremental or -1 for
> automatic allocation as it should be.
> 
> Does this behave the same with any 2.5 kernel? I'm to much a
> coward to try 2.5, last time i did, i lost very important data.

Try apply alsa-driver/utils/patches/soundcore.2.4.20.patch to your 
kernel.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

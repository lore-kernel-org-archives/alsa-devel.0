From: Paul Barton-Davis <pbd@Op.Net>
Subject: Re: rme9652 locks up my computer
Date: Wed, 20 Feb 2002 09:15:37 -0500 (EST)
Message-ID: <200202201415.JAA08796@monet.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA17947
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2002 15:15:59 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: robert@musicalica.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

robert

i don't have very good mail access right now, because i just lost
2 motherboards (i'm writing this from an ssh session from my
girlfriends windows box. however, 2 things:

your question about lockups doesn't really contain enough information.
are you running with SCHED_FIFO? are you accessing both playback and
capture streams? what else does your code do?

about memory allocation: yes, after running fsck, even with 512MB,
there is normally/frequently not enough *contiguous* RAM for the
hammerfalls. you need to ensure that the memory allocation module
(snd-rme9652-mem in the latest alsa) is installed *very* early in your
system's startup. how best to do that varies depending on which linux
system you have; on my RH-derived systems, i load that module from
rc.sysinit, before anything else happens, and then i never get
failures.

on windows/macos, the driver gets loaded at an equivalently early
point; under linux, with modular drivers, its an extra step to make
sure the memory allocation happens "early" - this is the tradeoff with
modular drivers. if you compile the rme9652 driver (and alsa) into the
kernel, this problem would go away, but i don't like building anything
but the core drivers into my kernels.

oh, and that "defective" hammerfall almost certainly had an M52 EPROM
rather than an W52 EPROM, hence the reversed byte-order (its for big
endian systems like the macs).

my email access will continue to be poor for several days.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

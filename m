From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 8 Sep 2010 10:19:45 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009080954530.10278@eeebox2.perex-int.cz>
References: <1282640988.3053.43.camel@odin>
	<alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<20100907155355.GE25830@sirena.org.uk>
	<alpine.LNX.2.00.1009072001580.10278@eeebox2.perex-int.cz>
	<20100907185358.GA1125@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 23FD8243F5
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 10:19:46 +0200 (CEST)
In-Reply-To: <20100907185358.GA1125@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


Creating another thread .... state locking ...

I understand the motivation to create a layer for phone or similar 
embedded devices which uses usually all streams from the one process.

But what about more concurrent processes? The state handling in the 
current implementation is per process, so another process just 
overwrite blindly the control values set by the first process.

I think that the layer should have some locking mechanism and state 
persistency (IPC semaphores / IPC shared memory) or a file and inotify?

Another question is how to handle collisions.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

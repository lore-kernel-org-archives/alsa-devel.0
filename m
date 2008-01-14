From: maximilian attems <max@stro.at>
Subject: Re: Bug#436723: Playing sound hands on powerbook3,
	5 with 2.6.21-2 kernel
Date: Mon, 14 Jan 2008 01:06:41 +0100
Message-ID: <20080114000640.GO9040@baikonur.stro.at>
References: <20080114002111.2ef21467@phineus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from baikonur.stro.at (baikonur.stro.at [213.239.196.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 24AA124407
	for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 01:35:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080114002111.2ef21467@phineus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: th.huth@googlemail.com, 436723@bugs.debian.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[ adding alsa upstream on cc ]

On Mon, Jan 14, 2008 at 12:21:11AM +0100, th.huth@googlemail.com wrote:
> 
> Please have a look at
> https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/87652/comments/48
> and the corresponding patch to see wether this patch solves this sound
> issue.

woow, i thought to fire up "try newer kernel", but your patch still
applies to current linus git:
 ~/src/linux-2.6$ patch -p0 --dry-run < ~/pmac.c.diff 
 patching file sound/ppc/pmac.c
 Hunk #5 succeeded at 868 (offset -24 lines).
 Hunk #6 succeeded at 1207 (offset -47 lines).

so bringing that to upstream alsa radar.

-- 
maks

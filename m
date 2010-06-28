From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] sis7019: increase reset delays
Date: Mon, 28 Jun 2010 09:44:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006280943520.15497@eeebox2.perex-int.cz>
References: <1277590077.2438.9.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D669D10387F
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 09:44:16 +0200 (CEST)
In-Reply-To: <1277590077.2438.9.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, michael.goeke@icachip.de
List-Id: alsa-devel@alsa-project.org

On Sat, 26 Jun 2010, David Dillow wrote:

> A few boards using this controller are reported to need a little extra
> time during their reset cycle.
>
> Reported-by: Michael Goeke <michael.goeke@icachip.de>
> Signed-off-by: Dave Dillow <dave@thedillows.org>

I applied your patch to my GIT tree.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

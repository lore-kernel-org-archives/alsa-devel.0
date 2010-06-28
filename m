From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] sis7019: fix capture issues with multiple
 periods per buffer
Date: Mon, 28 Jun 2010 09:43:45 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006280942580.15497@eeebox2.perex-int.cz>
References: <1277589872.2438.5.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BCC810387F
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 09:43:46 +0200 (CEST)
In-Reply-To: <1277589872.2438.5.camel@obelisk.thedillows.org>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

On Sat, 26 Jun 2010, David Dillow wrote:

> When using a timing voice to clock out periods during capture, the
> driver would slowly loose synchronization and never catch up, eventually
> reaching a point where it no longer generated interrupts. To avoid
> this situation, the virtual period clocking was changed to shorten the
> next timing period when our timing voice falls too far behind the
> capture voice. In addition, the first virtual period for the timing
> voice was slightly too short, causing the timing voice to initially be
> ahead of the capture voice.
>
> While tracking down this problem, I noticed that the expected sample
> offset was being incorrectly initialized, causing an overrun to be
> incorrectly reported when the timing voice happened to be perfectly
> synchronized.
>
> Reported-by: Hans Schou <linux@schou.dk>
> Signed-off-by: Dave Dillow <dave@thedillows.org>

Thanks for the patch. I applied it to my GIT tree.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

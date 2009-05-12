From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] control, hw,
 rawmidi: accept control device node as card identifier when opening
Date: Tue, 12 May 2009 14:42:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905121433510.25064@eeebox2.perex-int.cz>
References: <20090511224130.GA10955@omega>
	<alpine.LNX.2.00.0905120744260.25064@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0905121336130.25064@eeebox2.perex-int.cz>
	<20090512123229.GB29607@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E3C9103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 14:42:55 +0200 (CEST)
In-Reply-To: <20090512123229.GB29607@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 12 May 2009, Lennart Poettering wrote:

> With my original patch there are no superfluous opens.

If application uses more *open() calls from alsa-lib for one card (for 
example to open ctl handle and pcm handle), it's better to obtain card 
index at first, because each conversion requires one or more (card id) 
open/close sequence for control device to get card_info. Providing direct 
card index eliminates this conversion. It's just suggested optimization.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

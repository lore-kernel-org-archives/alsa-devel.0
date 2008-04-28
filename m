From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] speaker-test.c - fix pink noise generator
 on big-endian archs
Date: Mon, 28 Apr 2008 09:17:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804280916300.7882@tm8103.perex-int.cz>
References: <20080427225304.ba000bcb.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DB638245A9
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Apr 2008 09:17:05 +0200 (CEST)
In-Reply-To: <20080427225304.ba000bcb.pochini@shiny.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 27 Apr 2008, Giuliano Pochini wrote:

> This patch makes speaker-test fill the buffers with properly coded data on
> both big- and little-endian processors.
> 
> 
> Signed-off-by: Giuliano Pochini <pochini@shiny.it>

Thanks. The patch was applied to ALSA repository.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

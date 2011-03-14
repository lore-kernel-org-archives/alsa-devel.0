From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsamixer: fix build on uClibc
Date: Mon, 14 Mar 2011 10:32:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103141031440.4805@eeebox2.perex-int.cz>
References: <1300092493-7414-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 45DCC1037F3
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 10:32:01 +0100 (CET)
In-Reply-To: <1300092493-7414-1-git-send-email-jacmet@sunsite.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Mar 2011, Peter Korsgaard wrote:

> exp10 is a glibc extension, which isn't supported on uClibc. Luckily,
> exp10() is trivial to compute based on exp(), so add a wrapper for
> the uClibc case.
>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Applied. Thanks.

 				Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

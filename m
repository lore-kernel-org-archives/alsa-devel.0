From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Bug 0002542
Date: Mon, 24 Jan 2011 21:25:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101242124160.6272@eeebox2.perex-int.cz>
References: <AANLkTina57s0fxMtGriV+5-BH9XsJcT4Z_cGvsF44UHF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E0AE2103848
	for <Alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 21:25:26 +0100 (CET)
In-Reply-To: <AANLkTina57s0fxMtGriV+5-BH9XsJcT4Z_cGvsF44UHF@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: George Morgan <gm.swdev@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Jan 2011, George Morgan wrote:

> Looking at the notes for Bug 0002542 (as a guest) it looks like there is an
> issue in the file:
>
> alsa-oss-1.0.17/alsa/aoss.in
>
> I think line 10 should be:
>
>  LD_PRELOAD=@libdir@/libaoss.so${LD_PRELOAD:+:LD_PRELOAD} exec "$@"
>
> instead of:
>
>  LD_PRELOAD=${exec_prefix}/\$LIB/libaoss.so${LD_PRELOAD:+:LD_PRELOAD} exec
> "$@"
>
> Let me know if I need to create an account in bugtrack and submit a patch.

See this:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1390

and this..

http://git.alsa-project.org/?p=alsa-oss.git;a=commitdiff;h=9916731b29f07a52451d9d663a7d365ead8e9dfe

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

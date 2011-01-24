From: George Morgan <gm.swdev@gmail.com>
Subject: Bug 0002542
Date: Mon, 24 Jan 2011 15:10:46 -0500
Message-ID: <AANLkTina57s0fxMtGriV+5-BH9XsJcT4Z_cGvsF44UHF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DF78C103848
	for <Alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 21:10:51 +0100 (CET)
Received: by bwz10 with SMTP id 10so4000072bwz.38
	for <Alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 12:10:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Looking at the notes for Bug 0002542 (as a guest) it looks like there is an
issue in the file:

alsa-oss-1.0.17/alsa/aoss.in

I think line 10 should be:

  LD_PRELOAD=@libdir@/libaoss.so${LD_PRELOAD:+:LD_PRELOAD} exec "$@"

instead of:

  LD_PRELOAD=${exec_prefix}/\$LIB/libaoss.so${LD_PRELOAD:+:LD_PRELOAD} exec
"$@"

Let me know if I need to create an account in bugtrack and submit a patch.

Thanks.

George Morgan

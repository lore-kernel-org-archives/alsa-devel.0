From: Miro Hodak <mhodak127@gmail.com>
Subject: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Sun, 13 Jan 2013 13:05:50 -0500
Message-ID: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f172.google.com (mail-ia0-f172.google.com
 [209.85.210.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A3B2826163C
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 19:05:52 +0100 (CET)
Received: by mail-ia0-f172.google.com with SMTP id u8so3033908iag.31
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 10:05:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: diaz.manolo@gmail.com
List-Id: alsa-devel@alsa-project.org

Commit identified in the subject (ALSA: HDA - Add Independent Headphone for
all models of ad1988/ad1989) causes problem with audio on at least two Asus
boards and is still present in current kernel. The boards on which this
problem is seen are Asus M3A79-T DELUXE and Asus Rampage II Gene (actually
a slightly modified version used in Asus CG5290 desktop).

The symptoms:
1. XFCE and Gnome2 audio mixers crash whenever sound is started or stopped.
The error message is:
simple_none.c:1350: get_enum_item_ops: Assertion `helem' failed.

2. On one of the boards (Asus M3A79-T DELUXE) the mixer control labels are
misconfigured since muting the Master channel does not turn the sound off.
Either Master is mislabeled or it does not work correctly.

Other than that, the sound actually works fine, but it is very annoying
when mixer keeps crashing. Reverting to kernel just before the commit fixes
these issues. Thus it appears that the commit
34588709af61be1550b4e2bcee5c85d0ac4f34d4 breaks autodetect for these
boards. A workaround is to force the 6stack-dig model and this fixes
problems on both boards, but, of course, it would be preferred if things
work out of the box.

We do not understand enough of alsa in kernel to propose a patch, but hope
that we have provided enough information that it will be easy to write. We
are happy to provide more information and test any proposed patches.

Alsa-info for both boards can be found below.

Best regards,
Miro Hodak and Manolo Diaz



Results of alsa-info

Asus Rampage II Gene:

Before the commit: http://pastebin.com/gCZurk6D
After the commit (autodetect): http://pastebin.com/3hNX2g1c
After the commit (6stack_dig model): http://pastebin.com/dL0UGeTW

More recent kernel:
3.6.11-gentoo (autodetect): http://pastebin.com/0gjnhYA2
3.6.11-gentoo (6stack_dig model): http://pastebin.com/K9bsWBWW

Asus M3A79-T DELUXE

Before the commit: http://pastebin.com/hyUBmpDL
After the commit (autodetect) : http://pastebin.com/gzGg60bM
After the commit (6stack_dig model): http://pastebin.com/y88jCMhM

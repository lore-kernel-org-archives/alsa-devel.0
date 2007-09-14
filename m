From: Rene Herman <rene.herman@gmail.com>
Subject: Per option CFLAGS?
Date: Sat, 15 Sep 2007 01:07:06 +0200
Message-ID: <46EB141A.7090200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id C9D5D245DA
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Sep 2007 01:07:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kai Germaschewski <kai@germaschewski.name>, Sam Ravnborg <sam@ravnborg.org>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Kai, Sam.

I have a single file foo.c that I want to generate two (ALSA) modules from, 
snd-foo2000.ko and snd-foo2001.ko, by compiling with either FOO2000 or 
FOO2001 defined.

I can do this, and ALSA does this a few times, by providing dummy foo2000.c 
and foo2001.c files, like:

=== foo2000.c
#define FOO2000
#include "foo.c"
===

and a regular Makefile

===
foo2000-objs := foo2000.o
foo2001-objs := foo2001.o

obj-$(CONFIG_SND_FOO2000) += snd-foo2000.o
obj-$(CONFIG_SND_F002001) += snd-foo2001.o
===

That #include is a little lame though. Is there a nicer way? I noticed the 
per-file CFLAGS, but given that it's one source file for both, that doesn't fit.

Rene.

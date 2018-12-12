From: GitHub pull_request - opened <github@alsa-project.org>
Subject: [PATCH] alsa-oss: fix FTBFS with glibc v2.28
Date: Wed, 12 Dec 2018 23:23:28 +0100 (CET)
Message-ID: <20181212222328.081CF267C48@alsa0.perex.cz>
References: <1544653404436039925-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id BBBDD267B8E
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 23:23:24 +0100 (CET)
In-Reply-To: <1544653404436039925-webhooks-bot@alsa-project.org>
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
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-oss pull request #1 was opened from takaswie:

In glibc upstream, libio/libio.h had been deprecated for applications and
became internal header in its v2.28 release. We can see below message in
its release note[1].

* The nonstandard header files <libio.h> and <_G_config.h> are no longer
  installed.  Software that was using either header should be updated to
  use standard <stdio.h> interfaces instead.

This brings FTBFS with glibc v2.28 due to missing <libio.h>. This commit
fixes it.

[1] https://www.sourceware.org/ml/libc-alpha/2018-08/msg00003.html

Reported-by: Adrian Bunk <bunk@debian.org>
Reference: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=916052
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

```
---
 alsa/stdioemu.c | 1 -
 1 file changed, 1 deletion(-)
```

Request URL   : https://github.com/alsa-project/alsa-oss/pull/1
Patch URL     : https://github.com/alsa-project/alsa-oss/pull/1.patch
Repository URL: https://github.com/alsa-project/alsa-oss

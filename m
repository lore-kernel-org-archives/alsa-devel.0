From: GitHub issues - opened <github@alsa-project.org>
Subject: axfr/tests fail on hppa and sparc
Date: Sat, 27 Jul 2019 16:49:50 +0200 (CEST)
Message-ID: <20190727144950.73A52F80394@alsa1.perex.cz>
References: <1564238987542835951-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3768AF800E8
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2019 16:49:47 +0200 (CEST)
In-Reply-To: <1564238987542835951-webhooks-bot@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-utils issue #23 was opened from DerDakon:

There is a Gentoo bug about this test failures: https://bugs.gentoo.org/681652

The log on hppa says this:

```
=================================================
   alsa-utils 1.1.9: axfer/test/test-suite.log
=================================================

# TOTAL: 2
# PASS:  0
# SKIP:  0
# XFAIL: 0
# FAIL:  2
# XPASS: 0
# ERROR: 0

.. contents:: :depth: 2

FAIL: container-test
====================

container-test: container-test.c:53: test_builder: Assertion `err == 0' failed.
FAIL container-test (exit status: 134)

FAIL: mapper-test
=================

Invalid argument
FAIL mapper-test (exit status: 1)
```

The errors are similar on sparc. Does that depend on specific kernel features to be enabled? Also note that both architectures are big endian, which may or may not be related.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/23
Repository URL: https://github.com/alsa-project/alsa-utils

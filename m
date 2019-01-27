From: GitHub pull_request - opened <github@alsa-project.org>
Subject: [PATCH] alsa-utils: axfer: add missing header file of
 unit test to distribution
Date: Sun, 27 Jan 2019 03:29:39 +0100 (CET)
Message-ID: <20190127022939.286D3267333@alsa0.perex.cz>
References: <1548556176371073961-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id C935B266A7C
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2019 03:29:36 +0100 (CET)
In-Reply-To: <1548556176371073961-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #10 was opened from takaswie:

The file 'axfer/test/generator.h' is missing in distribution and brings
FTBFS for unit tests of axfer.

This commit fixes to add it.

Reported-by: Elimar Riesebieter <riesebie@lxtec.de>
Fixes: b878df1ff0b0: ('axfer: add unit test for container interface')
Fixes: 39d1ab8a0cb4: ('axfer: add a unit test for mapper interface')

Request URL   : https://github.com/alsa-project/alsa-utils/pull/10
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/10.patch
Repository URL: https://github.com/alsa-project/alsa-utils

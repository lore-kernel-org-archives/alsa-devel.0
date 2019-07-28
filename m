From: GitHub pull_request - opened <github@alsa-project.org>
Subject: axfer: test: fix invalid comparison of 64 bit storage
	in ILP32 data type
Date: Sun, 28 Jul 2019 09:32:47 +0200 (CEST)
Message-ID: <20190728073247.6FBCCF804FE@alsa1.perex.cz>
References: <1564299164820060015-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0C03DF804CF
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2019 09:32:45 +0200 (CEST)
In-Reply-To: <1564299164820060015-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #25 was opened from takaswie:

In system V ABIs with ILP32 data model, bit shift for '1ul' can brings
undefined behaviour when the calculation result is over 32 bit width.

This commit fixes the bug.

Reported-by: Rolf Eike Beer <eike@sf-mail.de>
Reference: https://bugs.gentoo.org/681652
Reference: https://github.com/alsa-project/alsa-utils/issues/23
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/25
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/25.patch
Repository URL: https://github.com/alsa-project/alsa-utils

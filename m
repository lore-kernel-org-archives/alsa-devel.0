From: GitHub pull_request - opened <github@alsa-project.org>
Subject: axfer: mapper: fix parameter check for demuxer
Date: Sun, 28 Jul 2019 09:32:38 +0200 (CEST)
Message-ID: <20190728073238.A9680F804CB@alsa1.perex.cz>
References: <1564299154734652996-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A7F5AF80134
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2019 09:32:35 +0200 (CEST)
In-Reply-To: <1564299154734652996-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #24 was opened from takaswie:

Each container should be configured to store one saple per frame in
demuxer case. This commit fixes the bug.

Fixes: 25c8e3bebb53 ('axfer: add support for a mapper for multiple target')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/24
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/24.patch
Repository URL: https://github.com/alsa-project/alsa-utils

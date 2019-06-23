From: GitHub pull_request - opened <github@alsa-project.org>
Subject: aplay: fix a possible memory leak
Date: Sun, 23 Jun 2019 11:39:46 +0200 (CEST)
Message-ID: <20190623093946.E7D49F896F0@alsa1.perex.cz>
References: <1561282782445739031-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C1C7CF8071F
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 11:39:43 +0200 (CEST)
In-Reply-To: <1561282782445739031-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #20 was opened from chunxuxiao:

Fix a possible memory leak in function setup_chmap(void).  Memory free was
ignored when the function return an error.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/20
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/20.patch
Repository URL: https://github.com/alsa-project/alsa-utils

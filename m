From: GitHub pull_request - opened <github@alsa-project.org>
Subject: aplay: fix memory leak when setup_chmap() fail
Date: Sun, 23 Jun 2019 18:05:58 +0200 (CEST)
Message-ID: <20190623160558.8ABDEF896F0@alsa1.perex.cz>
References: <1561305955333041906-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id EB476F8065D
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2019 18:05:55 +0200 (CEST)
In-Reply-To: <1561305955333041906-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #21 was opened from chunxuxiao:

setup_chmap() will return with error number if hw_map calloc fail or
channels doesn't match with hw_params, but memory free was ignored when
error occurs.
this summit has been Reviewed-by @takaswie

Request URL   : https://github.com/alsa-project/alsa-utils/pull/21
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/21.patch
Repository URL: https://github.com/alsa-project/alsa-utils

From: GitHub pull_request - opened <github@alsa-project.org>
Subject: axfer: Fix creation of v1.2 headers on big-endian
	systems
Date: Sun, 21 Apr 2019 02:23:03 +0200 (CEST)
Message-ID: <20190421002303.24DC3F89704@alsa1.perex.cz>
References: <1555806179861110926-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 48743F896E8
 for <alsa-devel@alsa-project.org>; Sun, 21 Apr 2019 02:22:59 +0200 (CEST)
In-Reply-To: <1555806179861110926-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #15 was opened from smaeul:

struct block_v120_format defines these members as uint8_t. On
little-endian systems, no swapping is done, and the generated block
header is fine. However, on big-endian machines, the value is swapped to
the high byte and then truncated by the assignment, causing both
bits_per_sample and samples_per_frame to be zero.

This fixes an assertion failure in container-test when later
parsing the header ["assert(*samples_per_frame > 0);" in
container_context_pre_process()].

Signed-off-by: Samuel Holland <samuel@sholland.org>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/15
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/15.patch
Repository URL: https://github.com/alsa-project/alsa-utils

From: GitHub pull_request - opened <github@alsa-project.org>
Subject: cplay: Always write whole buffer requested by user
Date: Mon,  3 Dec 2018 16:14:37 +0100 (CET)
Message-ID: <20181203151437.A2B88267AAA@alsa0.perex.cz>
References: <1543850074722342014-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C736267A77
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 16:14:34 +0100 (CET)
In-Reply-To: <1543850074722342014-webhooks-bot@alsa-project.org>
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

alsa-project/tinycompress pull request #1 was opened from dbaluta:

cplay first writes frag * fragment_size and then
it only writes one fragment at a time.

This means for example than if the user supplied a buffer_size
it will only be used for the first write.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Request URL   : https://github.com/alsa-project/tinycompress/pull/1
Patch URL     : https://github.com/alsa-project/tinycompress/pull/1.patch
Repository URL: https://github.com/alsa-project/tinycompress

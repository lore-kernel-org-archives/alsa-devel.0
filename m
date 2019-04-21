From: GitHub pull_request - opened <github@alsa-project.org>
Subject: axfer: Declare global variables as 'extern' in header
Date: Sun, 21 Apr 2019 02:22:31 +0200 (CEST)
Message-ID: <20190421002231.9FB8FF896E5@alsa1.perex.cz>
References: <1555806148495058060-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 07B01F801D9
 for <alsa-devel@alsa-project.org>; Sun, 21 Apr 2019 02:22:28 +0200 (CEST)
In-Reply-To: <1555806148495058060-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #14 was opened from smaeul:

This avoids multiple definitions of the same global variable (one in
each file that includes this header), and fixes a linking error when
compiled with -fno-common.

Signed-off-by: Samuel Holland <samuel@sholland.org>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/14
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/14.patch
Repository URL: https://github.com/alsa-project/alsa-utils

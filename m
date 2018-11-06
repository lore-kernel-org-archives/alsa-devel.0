From: GitHub pull_request - opened <github@alsa-project.org>
Subject: aplay: fix description about options for process
	duration
Date: Tue,  6 Nov 2018 01:22:35 +0100 (CET)
Message-ID: <20181106002235.46EEC2679BF@alsa0.perex.cz>
References: <1541463753188396931-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 8372D267930
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 01:22:33 +0100 (CET)
In-Reply-To: <1541463753188396931-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #1 was opened from takaswie:

Hi,

At present, aplay has two options for duration to process PCM frames.
However, the recent one ('--samples') option is not described yet in
its manual. Furthermore, '-s' option was used for '--sleep-min' option
once and description for this option was left as is. This can puzzle
uses.

This patchset improves description about options for process duration.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/1
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/1.patch
Repository URL: https://github.com/alsa-project/alsa-utils

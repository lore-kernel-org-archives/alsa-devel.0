From: GitHub issues - edited <github@alsa-project.org>
Subject: Is period_size bytes per period or frames per period?
Date: Mon, 12 Aug 2019 13:30:30 +0200 (CEST)
Message-ID: <20190812113030.0E4A6F8048D@alsa1.perex.cz>
References: <1565609427429264069-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9B179F80268
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 13:30:27 +0200 (CEST)
In-Reply-To: <1565609427429264069-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-lib issue #8 was edited from crocket:

According to https://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html
period_size in dmix is bytes per period.

According to aplay --dump-hw-params -D dmix ...
period_size is frames per period.

Which one is right?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/8
Repository URL: https://github.com/alsa-project/alsa-lib

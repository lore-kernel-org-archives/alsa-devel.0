From: "Sudheer" <spapothi@codeaurora.org>
Subject: Using regmap_multi_reg_write() with regcache_sync()
Date: Thu, 30 Jul 2015 20:01:07 -0700
Message-ID: <007801d0cb3d$25ec4870$71c4d950$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 07F8F2612AC
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 05:01:10 +0200 (CEST)
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@kernel.org>
Cc: plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
We are trying to measure cold start output latency for audio playback
usecase on our platform and observing that the latency is high. As a part of
optimization, we have profiled regcache_sync() API when the codec is out of
reset and observed that regcache_sync() takes little long time for synching
all of the codec registers (around 100 registers). But, the bus connecting
the codec has the capability to send multiple register writes at once. It
seems regmap_multi_reg_write() can be used for triggering multiple register
writes at once. So, we would like to know, if it is possible to use
regmap_multi_reg_write() or a similar function with regcache_sync that
intern calls bus driver's multi_reg_write API to sync to the HW, that will
help in reducing the latency.

Your comments/suggestions are highly appreciated.

Thanks & Regards,
Sudheer
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a
Linux Foundation Collaborative Project

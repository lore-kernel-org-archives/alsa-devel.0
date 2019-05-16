From: Matt Flax <flatmax@flatmax.org>
Subject: ASoc : cs42xx8 : merge cs42xx8-i2c.c into cs42xx8.c
Date: Thu, 16 May 2019 16:15:11 +1000
Message-ID: <e182bf72-c369-7344-e4d1-0524b09ca489@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79FB6F80C18
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 08:15:31 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>, broonie@kernel.org, ckeepax@opensource.cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Do you think it would be a good idea to merge cs42xx8-i2c.c into cs42xx8.c ?

Is there a reason to keep these two related driver functions separate ?

Here is their source code :

https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs42xx8-i2c.c

https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs42xx8.c

Matt

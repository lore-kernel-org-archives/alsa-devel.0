From: Axel Lin <axel.lin@ingics.com>
Subject: ASoC: 88pm860x: Question about pm860x_set_dai_sysclk
	implementation
Date: Sun, 28 Jun 2015 23:00:59 +0800
Message-ID: <1435503659.6929.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1BC264FEB
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 17:01:07 +0200 (CEST)
Received: by pabvl15 with SMTP id vl15so92295661pab.1
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 08:01:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Haojian,
In sound/soc/codecs/88pm860x-codec.c (pm860x_set_dai_sysclk):
When dir != PM860X_CLK_DIR_OUT, current code set
pm860x->dir = PM860X_CLK_DIR_IN; and then return -EINVAL.
This looks confusion.
Since there is no comment for that, I'm wondering if the
return -EINVAL is intentional or not.

Regards,
Axel

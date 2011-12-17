From: Axel Lin <axel.lin@gmail.com>
Subject: ASoC: missed hx4700-audio platform device for hx4700
Date: Sat, 17 Dec 2011 17:32:59 +0800
Message-ID: <1324114379.28427.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 58C41244AF
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2011 10:33:14 +0100 (CET)
Received: by yhjj56 with SMTP id j56so3346854yhj.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2011 01:33:12 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Dmitry Artamonow <mad_soft@inbox.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The iPAQ hx4700 machine driver needs a hx4700-audio platform device which is
not (yet) merged.

The patchs was post on LKML: https://lkml.org/lkml/2011/5/18/222
but [PATCH v3 3/3] pxa/hx4700: add platform device and I2C info for AK4641 codec is missed.

Regards,
Axel

From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 0/4] enable sound in pxa168
Date: Wed, 10 Mar 2010 08:18:31 -0500
Message-ID: <771cded01003100518v2992dc7ft16e0478c683d70d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f175.google.com (mail-pz0-f175.google.com
	[209.85.222.175])
	by alsa0.perex.cz (Postfix) with ESMTP id BE029103988
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 14:18:32 +0100 (CET)
Received: by pzk5 with SMTP id 5so681454pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 05:18:31 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

These patches are used to enable sound in pxa168 SoC. The platform is
aspenite. Since SSP clock is changed in PXA168, create a new
pxa168-ssp.c file in sound/soc/pxa directory.

0001--ARM-pxa-move-ssp-into-plat.patch
0002--ARM-mmp-support-ssp-in-pxa168.patch
0003-ASoC-enable-ssp-on-aspenite.patch
0004--ARM-mmp-enable-sound-in-aspenite.patch

Thanks
Haojian

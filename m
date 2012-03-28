From: Sangbeom Kim <sbkim73@samsung.com>
Subject: WM8994 playback delay
Date: Thu, 29 Mar 2012 08:02:29 +0900
Message-ID: <031201cd0d36$d9b78310$8d268930$@com>
References: <1332964426-8480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1332964426-8480-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B85924472
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 01:02:21 +0200 (CEST)
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0M1M00L56ANJNG80@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 29 Mar 2012 08:02:16 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.118.225])
	by mmp1.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0M1M00MF9ANS9V70@mmp1.samsung.com>
	for alsa-devel@alsa-project.org; Thu, 29 Mar 2012 08:02:16 +0900 (KST)
In-reply-to: <1332964426-8480-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sbkim01@gmail.com, sangsu4u.park@samsung.com, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi, Mark,

Currently, We are developing SMDK with Exynos5250 and  WM8994 on 3.3-rc6.
We try to enable CONFIG_PM_RUNTIME and on/off control of power domain.
But It has playback delay in the first playback.(3~4sec and 6/10times)

In that time, Log maessage is 
'wm8994-codec wm8994-codec: Timed out waiting for DC Servo 300'
wait_for_dc_servo() function generate above message on sound/soc/codecs/wm_hubs.c

After removing wait_for_dc_servo for testing, playback delay is disappeared.
So, Could you please explain the  purporse of wait_for_dc_servo()?
If wait_for_dc_servo() is removed, What kind of problem can be happened?

Thanks,
Sangbeom.

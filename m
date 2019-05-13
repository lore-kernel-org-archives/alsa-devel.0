From: Kailang <kailang@realtek.com>
Subject: Boot procudure on HDA driver
Date: Mon, 13 May 2019 09:00:18 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D766254@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 857EBF8072A
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 11:00:24 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

When System Boot up.
The Hda Driver running step was as below.

alc_init();
alc_shutup();
alc_init();

The depop procedure was put in spec->init_hook and spec->shutup.

But I find more codec which run spec->shutup at boot up. It will occur pop noise.
If it doesn't run spec->shutup, it will not occur pop noise or reduce pop noise.

How could the spec->shutup not run at boot up?

I ever test to put the check in spec->shutup() for PM_EVENT_SUSPEND and PM_EVENT_HIBERNATE and shutdown.
But if power_save=1, it was have issue for this.
Codec was idle already in power_save=1 state. If system go suspend, it will not run spec->shutup() again.

BR,
Kailang

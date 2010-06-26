From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH RFC 0/3] asoc: uda1380 cleanup
Date: Sat, 26 Jun 2010 18:14:42 +0300
Message-ID: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AD4810383A
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 17:15:14 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1046443bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2010 08:15:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch series cleanups uda1380 codec driver a bit:
- it introduces callbacks instead of direct gpiolib usage, as some
machines requires more actions than just plain gpio toggle to
enable/disable/reset codec;
- it makes driver more powersave-friendly and fixes suspend/resume

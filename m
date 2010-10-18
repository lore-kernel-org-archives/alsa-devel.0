From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Newbie needs help to understand
	SNDRV_PCM_TRIGGER_START?
Date: Mon, 18 Oct 2010 10:28:11 -0700
Message-ID: <AANLkTi=LftOiqPhFKsc-uxPUabLZuyhcgzB4XNsSBLr7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 16E0024522
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 19:28:11 +0200 (CEST)
Received: by fxm14 with SMTP id 14so846711fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 10:28:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am writing my first ALSA driver. We have hardware where the amp is
controlled with another CPU (non Linux) so I have to forward the buffers
from ALSA to it. We do not have working solution on another CPU so I cannot
test sound playback yet. ALSA hits trigger method in my driver and soon
after it leaves my trigger method throws an null pointer exception (probably
since I did not do anything in my trigger method). I am wondering if the
ALSA will call  SNDRV_PCM_TRIGGER_START every single time new buffer is
available. Do I need to manage circular queue of buffers or ALSA is doing
this for me already?
Thanx

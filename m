From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 0/2] ASoC: au1x updates for 2.6.33
Date: Tue,  1 Dec 2009 18:10:33 +0100
Message-ID: <1259687435-7066-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 8401D2412E
	for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2009 18:10:24 +0100 (CET)
Received: by fxm3 with SMTP id 3so3994761fxm.4
	for <alsa-devel@alsa-project.org>; Tue, 01 Dec 2009 09:10:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

The following two patches fix 2 issues in the updated au1x asoc drivers
in your/Takashis queue for 2.6.33.  If possible, please either fold them
into commit 0f83d639d84c99a775c60696dbde77372c2cf4ac ("au1x: convert to
platform drivers") found in Takashi's tree.

Thank you!
     Manuel Lauss


Manuel Lauss (2):
  ASoC: au1x: dbdma2: fix oops on soc device removal.
  ASoC: au1x: dbdma2: plug memleak in pcm device creation error path

 sound/soc/au1x/dbdma2.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

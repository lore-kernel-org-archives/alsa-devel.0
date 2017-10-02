From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 0/2] ASoC: img-spdif-in: Add power management
Date: Mon,  2 Oct 2017 11:01:16 +0100
Message-ID: <1506938478-747-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0060.outbound.protection.outlook.com [104.47.0.60])
 by alsa0.perex.cz (Postfix) with ESMTP id AC6DE2671A6
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:01:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ed Blake <ed.blake@sondrel.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds power managment to the img-spdif-in driver.  The
first patch adds system PM suspend / resume handling and the second
patch adds runtime PM.

Ed Blake (2):
  ASoC: img-spdif-in: Add suspend / resume handling
  ASoC: img-spdif-in: Add runtime PM

 sound/soc/img/img-spdif-in.c | 111 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 12 deletions(-)

-- 
1.9.1

From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 0/3] ASoC: some trivial fixups
Date: Tue,  7 Oct 2014 13:41:22 +0200
Message-ID: <1412682085-5217-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 92654260320
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 13:41:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Here are some trivial fixes for minor issues that were spotted by
Coverity. Only compile-tested, but the issues are pretty obvious, and
the fixes are simple.

Applicable to the for-next branch of the asoc tree.

Thanks,
Daniel

Daniel Mack (3):
  ASoC: core: fix use after free in snd_soc_remove_platform()
  ASoC: soc-dapm: fix use after free
  ASoC: 88pm860x-codec: Fix possibly missing string termination

 sound/soc/codecs/88pm860x-codec.c |  2 +-
 sound/soc/soc-core.c              |  4 ++--
 sound/soc/soc-dapm.c              | 25 ++++++++++++++-----------
 3 files changed, 17 insertions(+), 14 deletions(-)

-- 
2.1.0

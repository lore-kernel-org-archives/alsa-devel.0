From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 0/4] ASoC: mediatek: mt8183: some cleanups
Date: Fri, 30 Aug 2019 15:42:36 +0800
Message-ID: <20190830074240.195166-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD9E5F800D1
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 09:42:48 +0200 (CEST)
Received: by mail-qt1-x849.google.com with SMTP id e2so6149815qtm.19
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 00:42:48 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

The series contains some cleanup refactors and should not change any
behavior.

Tzung-Bi Shih (4):
  ASoC: mediatek: mt8183: move private structure
  ASoC: mediatek: mt8183: move headset jack to card-specific storage
  ASoC: mediatek: mt8183: remove forward declaration of headset_init
  ASoC: mediatek: mt8183: fix space issues

 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 55 +++++++++----------
 1 file changed, 26 insertions(+), 29 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog

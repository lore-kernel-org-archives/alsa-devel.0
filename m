From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 0/3] ASoC: mediatek: mt6358: fix mixer control
	issues
Date: Tue,  7 May 2019 18:12:17 +0800
Message-ID: <20190507101220.182466-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc4a.google.com (mail-yw1-xc4a.google.com
 [IPv6:2607:f8b0:4864:20::c4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64799F89671
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 12:12:52 +0200 (CEST)
Received: by mail-yw1-xc4a.google.com with SMTP id a70so27616363ywe.21
 for <alsa-devel@alsa-project.org>; Tue, 07 May 2019 03:12:51 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, tiwai@suse.com
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

This series fixes the following mixer control related issues:
- "Headphone Volume" and "PGA Volume" have been reset after previous
  stream closed.
- Set "Headphone Volume" to the smallest value (-10dB) still get mute,
  because ramp from -10dB to -10dB is a NOP in original implementation.

"Lineout Volume" and "Handset Volume" are un-tested.  Fixing them by
applying similar logic with "Headphone Volume".

Tzung-Bi Shih (3):
  ASoC: mediatek: mt6358: initialize setting when ramping volume
  ASoC: mediatek: mt6358: save output volume for mixer controls
  ASoC: mediatek: mt6358: save PGA for mixer control

 sound/soc/codecs/mt6358.c | 131 ++++++++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 48 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

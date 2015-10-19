From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH v4 0/2] ASoC: nau8825: Add FLL config and
	device property debug
Date: Mon, 19 Oct 2015 16:49:04 -0700
Message-ID: <1445298546-23975-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 96B812652C5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 01:49:25 +0200 (CEST)
Received: by pacfv9 with SMTP id fv9so1130925pac.3
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 16:49:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

This patch series adds the codec FLL configuration code to allow
different input MCLK frequencies, and prints out the received
device properties to make debugging easier with multiple versions
of ACPI _DSD blob.

Changes in v2:
 - Changed function/struct prefix from nau88xx_ to nau8825_ to
   match with the rest of the driver.

Changes in v3:
 - Changed the implicit unsigned 64-bit divide to div_u64() to
   fix build errors on 32-bit arch.

Changes in v4:
 - v2 and v3 updated only patch 1/2, not 2/2. The posted partial
   patch series makes code review confusing. v4 updates both
   patches in this series to the latest version.

Ben Zhang (2):
  ASoC: nau8825: Add FLL configuration
  ASoC: nau8825: Show device properties

 sound/soc/codecs/nau8825.c | 193 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8825.h |  28 +++++--
 2 files changed, 216 insertions(+), 5 deletions(-)

-- 
2.6.0.rc2.230.g3dd15c0

From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH 0/2] Introduce dmic mode switch delay parameter
Date: Tue,  2 Oct 2018 11:27:29 +0530
Message-ID: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B384C26783D
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 08:04:13 +0200 (CEST)
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
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

Some DMICs need clock to be running for a specified duration as per the
DMIC spec to complete the mode transition like sleep to mormal, off to normal
etc.

Jenny TC (2):
  ASoC: dmic: Enable ACPI device entry
  ASoC: dmic: Introduce mode switch delay

 sound/soc/codecs/dmic.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
1.9.1

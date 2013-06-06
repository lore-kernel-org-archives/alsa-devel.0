From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH V2 0/2] Add device tree binding support to
	WM8962 codec driver
Date: Thu, 6 Jun 2013 19:38:44 +0800
Message-ID: <cover.1370518627.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 013C1265562
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 13:32:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@linaro.org, broonie@kernel.org, lgirdwood@gmail.com, rob.herring@calxeda.com
List-Id: alsa-devel@alsa-project.org

*** These two patch added devicetree binding support to WM8962 codec driver
*** so that it can fetch pdata not only from old platform_data but also from
*** newer dts binding.
---
ChangeLog:
v1->v2:
 * PATCH 1/2:
 *** Embedded a copy of struct wm8962_pdata instead of its pointer
 *** Removed all 'if (pdata)' checking code as it is always valid.
 * PATCH 2/2:
 *** Dropped out-of-band value error msg by regarding it as default value. 

Nicolin Chen (2):
  ASoC: WM8962: Create default platform data structure
  ASoC: WM8962: Add device tree binding

 Documentation/devicetree/bindings/sound/wm8962.txt |   20 ++++
 sound/soc/codecs/wm8962.c                          |   99 +++++++++++++------
 2 files changed, 88 insertions(+), 31 deletions(-)

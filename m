From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 0/2] Add device tree binding support to WM8962
	codec driver
Date: Wed, 5 Jun 2013 20:12:54 +0800
Message-ID: <cover.1370433363.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A9932265467
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 14:06:53 +0200 (CEST)
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

Nicolin Chen (2):
  ASoC: WM8962: Create default platform data structure
  ASoC: WM8962: Add device tree binding

 Documentation/devicetree/bindings/sound/wm8962.txt |   20 +++++++
 sound/soc/codecs/wm8962.c                          |   56 ++++++++++++++++++--
 2 files changed, 72 insertions(+), 4 deletions(-)

From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/2] ASoC: tfa9879: cleanup bindings and claim
	maintainership
Date: Mon, 11 Dec 2017 15:26:13 +0100
Message-ID: <20171211142615.11440-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00105.outbound.protection.outlook.com [40.107.0.105])
 by alsa0.perex.cz (Postfix) with ESMTP id B9BD3266E93
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 15:26:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Hi!

Device tree bindings where added for the tfa9879 along with improved
support for them in the driver some time ago. All behind my back.
This cleans things up and properly adds me as maintainer of the new
bindings.

Cheers,
Peter

Peter Rosin (2):
  ASoC: tfa9879: clean up bindings
  ASoC: tfa9879: add DT bindings to MAINTAINERS

 Documentation/devicetree/bindings/sound/tfa9879.txt | 8 ++++----
 MAINTAINERS                                         | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.11.0

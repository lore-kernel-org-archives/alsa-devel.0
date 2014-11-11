From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] Subject: [PATCH 0/2] ASoC: tlv320aic3x:
	soc_enum array conversion and pop reduction
Date: Tue, 11 Nov 2014 10:58:59 +0200
Message-ID: <1415696341-12802-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id D9EC0264F36
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 09:59:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Convert the soc_enum arrays to individual items and add the pop reduction patch
on top of this change.

Regards,
Peter
---
Misael Lopez Cruz (1):
  ASoC: tlv320aic3x: Add output driver pop reduction controls

Peter Ujfalusi (1):
  ASoC: tlv320aic3x: Convert SOC_ENUM_SINGLE/DOUBLE arrays to individual

 sound/soc/codecs/tlv320aic3x.c | 165 +++++++++++++++++++++++------------------
 1 file changed, 93 insertions(+), 72 deletions(-)

-- 
2.1.3

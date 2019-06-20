From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: ti: davinci-mcasp: Fixes for multi
	serializer setup
Date: Thu, 20 Jun 2019 12:20:00 +0300
Message-ID: <20190620092002.13766-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96939F80C15
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 11:19:29 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Hi,

Now that I have access to a board with codec using multiple digital inputs and
outputs (pcm3168a) I found these two issues with the McASP driver:

- unused pins needs to be set as inactive
- the tdm mask is not set correctly when multiple serializers are enabled and
  needed

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: ti: davinci-mcasp: Set unused serializers as INACTIVE
  ASoC: ti: davinci-mcasp: Fix slot mask settings when using multiple
    AXRs

 sound/soc/ti/davinci-mcasp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

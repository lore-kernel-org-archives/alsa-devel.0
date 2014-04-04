From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 0/4] Add ESAI & SPDIF Vybrid and LS1+ support.
Date: Fri, 4 Apr 2014 15:10:25 +0800
Message-ID: <1396595429-16629-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 095CF265726
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 09:54:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, Guangyu.Chen@freescale.com
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

Changes in V2:
- Revise some issue from Nicolin Chen and Fabio Estevam.


Xiubo Li (4):
  ASoC: esai: use the precise definition of 'ret'.
  ASoC: spdif: Sort the header files alphabetically.
  ASoC: esai: Add VF610+ compatibles support.
  ASoC: spdif: Add VF610+ compatibles support.

 sound/soc/fsl/fsl_esai.c  | 9 ++++++---
 sound/soc/fsl/fsl_spdif.c | 9 +++++----
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
1.8.4

From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH RESEND 0/4] ASoC: fsl_esai: Fix some issues
Date: Tue, 6 May 2014 16:55:58 +0800
Message-ID: <cover.1399366227.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B35026072A
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 10:54:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Sorry for this resend. I just found my previous patches have
not been delivered successfully to the alsa maillist.

This series of patches fix the following problems:
PATCH-1 for an incorrect ratio range check.
PATCH-2 for an incorrect bypass settings of FSYS clock source.
PATCH-3 for duplicated calculations and configurations of dividers
PATCH-4 for mismatched init flow of configuration comparing to RM.

Nicolin Chen (4):
  ASoC: fsl_esai: Fix incorrect condition within ratio range check for
    FP
  ASoC: fsl_esai: Only bypass sck_div for EXTAL source
  ASoC: fsl_esai: Bypass divider settings if clock requirement is not
    changed
  ASoC: fsl_esai: Set PCRC and PRRC registers at the end of hw_params()

 sound/soc/fsl/fsl_esai.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

-- 
1.8.4

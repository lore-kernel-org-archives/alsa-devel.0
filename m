From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 0/3] Add master mode,
	tmd and right-j mode support
Date: Tue, 20 Jan 2015 20:21:17 +0800
Message-ID: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0110.outbound.protection.outlook.com [207.46.100.110])
 by alsa0.perex.cz (Postfix) with ESMTP id A87E226044D
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 13:20:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Add sai master mode support.
Add tdm slots support.
Add Right-J mode support.

Zidan Wang (3):
  SoC: fsl_sai: add sai master mode support
  ASoC: fsl_sai: Add support for tdm slots operation
  ASoC: fsl_sai: Add support for Right-J mode

 sound/soc/fsl/fsl_sai.c | 164 ++++++++++++++++++++++++++++++++++++++++++++----
 sound/soc/fsl/fsl_sai.h |  13 +++-
 2 files changed, 164 insertions(+), 13 deletions(-)

-- 
1.9.1

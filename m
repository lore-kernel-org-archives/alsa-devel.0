From: David Binderman <dcb314@hotmail.com>
Subject: sound/soc/intel/atom/sst/sst_loader.c:407]: (style)
 Redundant condition
Date: Mon, 27 Mar 2017 10:42:22 +0000
Message-ID: <HE1PR0801MB18659CE2EE920B0B2A12FCEE9C330@HE1PR0801MB1865.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-oln040092067098.outbound.protection.outlook.com [40.92.67.98])
 by alsa0.perex.cz (Postfix) with ESMTP id 353E126583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 12:42:23 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hello there,

linux-4.11-rc4/sound/soc/intel/atom/sst/sst_loader.c:407]: (style) Redundant condition: If 'EXPR == 4', the comparison 'EXPR != 3' is always true.

Source code is

    if (sst_drv_ctx->sst_state !=  SST_RESET ||
            sst_drv_ctx->sst_state == SST_SHUTDOWN)

Regards

David Binderman

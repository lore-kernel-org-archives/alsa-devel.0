From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Date: Fri, 1 Mar 2019 03:45:13 +0000
Message-ID: <VI1PR0402MB33925A2019ADC89B89BF3E91E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
 <ab0a0d6c-4905-328c-0e22-931c045ed8d9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00073.outbound.protection.outlook.com [40.107.0.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43E25F896C0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 04:45:15 +0100 (CET)
In-Reply-To: <ab0a0d6c-4905-328c-0e22-931c045ed8d9@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Timur Tabi <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi

> > cs42xx8 is a 24-bit A/D and 24-bit D/A device, so the S32_LE should
> > not be in the supported format list.
> >
> > Signed-off-by: Shengjiu Wang<shengjiu.wang@nxp.com>
> 
> Is the device capable of accepting 32-bit samples, even if it downgrades it to
> 24-bit internally?  If so, then maybe SNDRV_PCM_FMTBIT_S32_LE should
> stay.
Yes,  the S32_LE can be accepted by device, it seems like that the device only
Use the upper 24bit, so the S32_LE result is same as S24_LE,  do you think the
S32_LE should be remained?

Best regards
Wang shengjiu

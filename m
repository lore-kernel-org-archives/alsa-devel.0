From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Date: Sat, 2 Mar 2019 05:42:39 +0000
Message-ID: <VI1PR0402MB3392FB4321D229EC2F857FB5E3770@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301045041.GA5064@Asurada>
 <5c60b8c7-cb85-dec8-0358-6773251d3f2c@flatmax.org>
 <VI1PR0402MB3392CCF09FE75CE856C6174EE3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
 <de5ebabd-52a5-dedb-6710-8f09e1a4e380@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20088.outbound.protection.outlook.com [40.107.2.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3B63F8961D
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2019 06:42:41 +0100 (CET)
In-Reply-To: <de5ebabd-52a5-dedb-6710-8f09e1a4e380@kernel.org>
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
To: Timur Tabi <timur@kernel.org>, Matt Flax <flatmax@flatmax.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi

> On 3/1/19 12:32 AM, S.j. Wang wrote:
> > This case is covered by S24_LE I think.  The S32_LE means the data is
> > 32bit and slot width Is 32bit, this is not in data sheet.
> 
> The problem is that if you have 32-bit samples in your audio file, and you
> want to play them, then software (e.g. alsalib) will need to convert the
> audio to 24-bit before sending it to hardware.  This is unnecessary because
> the hardware can "convert" the sample to 24-bit automatically by ignoring
> the lower 8 bits.
> 
> I think a lot of codecs do this already.

Ok. Thanks for reviewing, I will drop this patch.

Best regards
Wang shengjiu

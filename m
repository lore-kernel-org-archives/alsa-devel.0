From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v9 2/2] ASoC: fsl: Add S/PDIF machine driver
Date: Tue, 20 Aug 2013 13:00:47 -0600
Message-ID: <5213BCDF.2010705@wwwdotorg.org>
References: <cover.1376972170.git.b42378@freescale.com>
 <ede222d17047e863da34a78069ceead2668bd5d2.1376972170.git.b42378@freescale.com>
 <52139680.1010800@wwwdotorg.org>
 <CAGoOwPQ_7F1-3AetKBF35pwO_-LNY6yUtx_r8Mn+HZia_WqyoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id C624D2651A9
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 21:01:00 +0200 (CEST)
In-Reply-To: <CAGoOwPQ_7F1-3AetKBF35pwO_-LNY6yUtx_r8Mn+HZia_WqyoA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicole Otsuka <nicoleotsuka@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, linuxppc-dev@lists.ozlabs.org, s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

On 08/20/2013 10:54 AM, Nicole Otsuka wrote:
> Hi Stephen,
> 
> I have a whole changelist in the cover letter (PATCH 0/2). Please take a
> look at it.
> 
> And about the codec dummy things.. I do that only because the codec
> driver's doc say so.

The DT binding document is not meant to be influenced by internal driver
architecture.

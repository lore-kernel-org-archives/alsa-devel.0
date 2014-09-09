From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage
	in this module
Date: Tue, 09 Sep 2014 15:37:26 -0500
Message-ID: <540F6506.4060302@tabi.org>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada> <540F5D29.7040309@tabi.org>
 <20140909202710.GB5224@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C5BE2652F1
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 22:37:28 +0200 (CEST)
In-Reply-To: <20140909202710.GB5224@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com, mpa@pengutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 09/09/2014 03:27 PM, Nicolin Chen wrote:
> I guess Mark's comment is merely against the check for clk validation
> because if talking about clk validation, we should check IS_ERR(clk)
> rather than check !=NULL directly.

Ah, that makes sense now.

> However, my approach doesn't need any check. The open() or pm_resume()
> can just call clk_prepare_enable() directly. The __clk_enable() will
> then handle the 'clk == NULL' case:

Yes, I was thinking the same thing.

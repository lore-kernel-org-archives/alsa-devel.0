From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage
	in this module
Date: Fri, 12 Sep 2014 13:11:42 +0800
Message-ID: <20140912051140.GA3644@audiosh1>
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
 <54125DEF.4090101@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0145.outbound.protection.outlook.com [157.56.111.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BD5D265171
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 07:12:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <54125DEF.4090101@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Li.Xiubo@freescale.com, lgirdwood@gmail.com, nicoleotsuka@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 11, 2014 at 09:43:59PM -0500, Timur Tabi wrote:
> Shengjiu Wang wrote:
> >+	ret = clk_prepare_enable(ssi_private->clk);
> >+	if (ret)
> >+		return ret;
> 
> Will this work on PowerPC, where ssi_private->clk is always NULL?

When ssi_private->clk is NULL, then ret = 0, so here will not return,
the code in below will be continuously executed.
I think it work on PowerPC.

wang shengjiu

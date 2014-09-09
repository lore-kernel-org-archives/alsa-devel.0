From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage
	in this module
Date: Tue, 9 Sep 2014 14:09:50 -0700
Message-ID: <20140909210949.GA1816@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada> <540F5D29.7040309@tabi.org>
 <20140909202710.GB5224@Asurada> <540F6506.4060302@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id CEE932652F4
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 23:18:47 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id y10so1987243pdj.8
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 14:18:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540F6506.4060302@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, mpa@pengutronix.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 09, 2014 at 03:37:26PM -0500, Timur Tabi wrote:
> >However, my approach doesn't need any check. The open() or pm_resume()
> >can just call clk_prepare_enable() directly. The __clk_enable() will
> >then handle the 'clk == NULL' case:
> 
> Yes, I was thinking the same thing.

Because that's following your suggestion :)

@Shengjiu
Another thing I forgot to mention is we still need a return check for
clk_prepare_enable() which isn't in the current version. And I said
"doesn't need any check" is indicating the pre-check of the call.

Thank you
Nicolin

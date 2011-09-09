From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: playpaq_wm8510: Return proper error
 if clk_get fails
Date: Fri, 9 Sep 2011 09:43:02 -0700
Message-ID: <20110909164302.GB4070@opensource.wolfsonmicro.com>
References: <1315534538.3275.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C5E01244A1
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 18:43:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315534538.3275.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <gwossum@acm.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 09, 2011 at 10:15:37AM +0800, Axel Lin wrote:
> Return proper error instead of 0 if clk_get fails.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.

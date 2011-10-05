From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove impossible case from
	wm8994_hw_params
Date: Wed, 5 Oct 2011 17:17:03 +0100
Message-ID: <20111005161702.GC11528@opensource.wolfsonmicro.com>
References: <1317770151.2547.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC7222445A
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 18:17:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317770151.2547.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 05, 2011 at 07:15:51AM +0800, Axel Lin wrote:
> We set hw_params callback for wm8994_aif3_dai_ops to wm8994_aif3_hw_params.
> Thus no need to check wm8994-aif3 in wm8994_hw_params.

This patch doesn't apply against current code, please recheck and resend
if required.

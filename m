From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix wrong mask in some
 snd_soc_update_bits calls
Date: Sat, 22 Oct 2011 10:36:18 +0100
Message-ID: <20111022093616.GA3316@opensource.wolfsonmicro.com>
References: <1319162083.4352.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 650212459A
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 11:36:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319162083.4352.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Dong Aisheng <B29396@freescale.com>, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2011 at 09:54:43AM +0800, Axel Lin wrote:
> Ensure all mask bits are clear before setting new value.

Applied, thanks.

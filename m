From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8750: Fix missing braces around
 initializer warning
Date: Sat, 13 Aug 2011 15:27:39 +0900
Message-ID: <20110813062737.GA16171@opensource.wolfsonmicro.com>
References: <1313207114.29596.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19C371037F8
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Aug 2011 08:27:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313207114.29596.6.camel@phoenix>
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
Cc: Richard Purdie <richard@openedhand.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 13, 2011 at 11:45:14AM +0800, Axel Lin wrote:
> Fix below warning:
>   CC      sound/soc/codecs/wm8750.o
> sound/soc/codecs/wm8750.c:784: warning: missing braces around initializer
> sound/soc/codecs/wm8750.c:784: warning: (near initialization for 'wm8750_spi_ids[2].name')

Takashi already made this change.

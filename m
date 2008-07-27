From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: sound/soc/pxa/tosa.c: removed duplicated include
Date: Sun, 27 Jul 2008 12:36:24 +0100
Message-ID: <20080727113624.GA17422@opensource.wolfsonmicro.com>
References: <20080726204150.AF5E.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6094F245C5
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 13:36:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080726204150.AF5E.WEIYI.HUANG@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 26, 2008 at 08:43:01PM +0800, Huang Weiyi wrote:
> Removed duplicated include <asm/arch/tosa.h> in 
> sound/soc/pxa/tosa.c.

Prior to your patch I see:

| $ grep include.*tosa.h sound/soc/pxa/tosa.c
| #include <asm/arch/tosa.h>

Where is the second inclusion?

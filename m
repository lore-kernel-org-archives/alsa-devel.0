From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: Re: sound/soc/pxa/tosa.c: removed duplicated include
Date: Sun, 27 Jul 2008 21:04:43 +0800
Message-ID: <20080727204945.8C74.WEIYI.HUANG@gmail.com>
References: <20080726204150.AF5E.WEIYI.HUANG@gmail.com>
	<20080727113624.GA17422@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 691BC1037FF
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 15:04:47 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so1969219tid.8
	for <alsa-devel@alsa-project.org>; Sun, 27 Jul 2008 06:04:45 -0700 (PDT)
In-Reply-To: <20080727113624.GA17422@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Huang Weiyi <weiyi.huang@gmail.com>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 27 Jul 2008 12:36:24 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

broonie>On Sat, Jul 26, 2008 at 08:43:01PM +0800, Huang Weiyi wrote:
broonie>> Removed duplicated include <asm/arch/tosa.h> in 
broonie>> sound/soc/pxa/tosa.c.
broonie>
broonie>Prior to your patch I see:
broonie>
broonie>| $ grep include.*tosa.h sound/soc/pxa/tosa.c
broonie>| #include <asm/arch/tosa.h>
broonie>
broonie>Where is the second inclusion?

In the commit 30d38542ec777468bb6a31829076a2dbc5690e35,
duplicated include <asm/arch/tosa.h> was found in line 32 and 36.

-- 
Huang Weiyi <weiyi.huang@gmail.com>

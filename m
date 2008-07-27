From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: sound/soc/pxa/tosa.c: removed duplicated include
Date: Sun, 27 Jul 2008 18:48:47 +0100
Message-ID: <20080727174847.GA1729@sirena.org.uk>
References: <20080726204150.AF5E.WEIYI.HUANG@gmail.com>
	<20080727113624.GA17422@opensource.wolfsonmicro.com>
	<20080727204945.8C74.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AF0B24646
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 19:48:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080727204945.8C74.WEIYI.HUANG@gmail.com>
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

On Sun, Jul 27, 2008 at 09:04:43PM +0800, Huang Weiyi wrote:

> In the commit 30d38542ec777468bb6a31829076a2dbc5690e35,
> duplicated include <asm/arch/tosa.h> was found in line 32 and 36.

Gah, right, I see.  That patch introducing the duplicate went in via ARM
tree and your fix can't be applied to ALSA until current mainline with
that commit in it has been merged into ALSA.  Please submit your patch
to the ARM patch tracker for merge that way - that's probably the
easiest thing here to do here:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."

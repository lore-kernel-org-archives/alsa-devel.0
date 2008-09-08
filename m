From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 2/5] Separate common pxa2xx-ac97 code
Date: Mon, 08 Sep 2008 10:51:37 +0100
Message-ID: <1220867497.17091.94.camel@odin>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
	<1220866410.17091.81.camel@odin>  <ga2s2q$sge$3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DE7E244F2
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:51:41 +0200 (CEST)
In-Reply-To: <ga2s2q$sge$3@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-09-08 at 09:42 +0000, Dmitry Baryshkov wrote:
> Liam Girdwood wrote:
> 
> > On Mon, 2008-09-08 at 13:06 +0400, Dmitry Baryshkov wrote:
> >> ASoC and non-ASoC drivers for ACLINK on PXA share lot's of common code.
> >> Move all common code into separate file.
> >> 
> >> +#include "pxa2xx-ac97-lib.c"
> >>  
> >>  
> > Any reason for not linking with pxa2xx-ac97-lib.o ?
> > 
> 
> >> +#include "../../arm/pxa2xx-ac97-lib.c"
> > 
> > 
> > ditto
> > 
> >>  static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97) {
> > 
> > Liam
> 
> 
> That is the interim change. In the next patch the file is fully separated
> into distinct module. I can squash those patches if you'd prefer.
> 
> 

Yes, please - makes it easier to read.

Liam

From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 1/4] Separate common pxa2xx-ac97 code
Date: Wed, 10 Sep 2008 13:52:41 +0100
Message-ID: <1221051161.17091.241.camel@odin>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<20080910115717.GC23682@sirena.org.uk>
	<20080910123456.GB17144@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 5965C2414D
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 14:52:45 +0200 (CEST)
In-Reply-To: <20080910123456.GB17144@doriath.ww600.siemens.net>
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

On Wed, 2008-09-10 at 16:34 +0400, Dmitry Baryshkov wrote:
> On Wed, Sep 10, 2008 at 12:57:20PM +0100, Mark Brown wrote:
> > On Wed, Sep 10, 2008 at 05:01:17AM +0400, Dmitry Baryshkov wrote:
> > > ASoC and non-ASoC drivers for ACLINK on PXA share lot's of common code.
> > > Move all common code into separate module snd-pxa2xx-lib.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> > 
> > These look good from code review but I'd like to do some testing on the
> > systems I have here before acking.  Could you confirm which platforms
> > you're able to test on?
> 
> Slightly tested on pxa255 (tosa, kernel compiled with support for all pxa
> models) and pxa27x (spitz under qemu, same kernel).
> 

I'd prefer some real hardware for pxa27x since it has some different
AC97 silicon errata. However, since there are no pxa27x volunteers we
should upstream and wait for any unlikely pxa27x issues in the 2.6.28-rc
series.

Acked-by Liam Girdwood <lrg@kernel.org>

Liam

From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/4] Separate common pxa2xx-ac97 code
Date: Wed, 10 Sep 2008 16:34:57 +0400
Message-ID: <20080910123456.GB17144@doriath.ww600.siemens.net>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<20080910115717.GC23682@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id A528E2435B
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 14:37:41 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so1023573eyc.56
	for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2008 05:37:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080910115717.GC23682@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2008 at 12:57:20PM +0100, Mark Brown wrote:
> On Wed, Sep 10, 2008 at 05:01:17AM +0400, Dmitry Baryshkov wrote:
> > ASoC and non-ASoC drivers for ACLINK on PXA share lot's of common code.
> > Move all common code into separate module snd-pxa2xx-lib.
> > 
> > Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> 
> These look good from code review but I'd like to do some testing on the
> systems I have here before acking.  Could you confirm which platforms
> you're able to test on?

Slightly tested on pxa255 (tosa, kernel compiled with support for all pxa
models) and pxa27x (spitz under qemu, same kernel).

-- 
With best wishes
Dmitry

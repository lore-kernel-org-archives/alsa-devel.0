From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: PLL computation in TLV320AIC3x SoC driver
Date: Tue, 08 Dec 2009 15:02:42 +0000
Message-ID: <1260284562.3119.20.camel@odin>
References: <alpine.DEB.2.00.0912081127460.22770@hippogriff.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 69993243AB
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 16:02:44 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so240691eyw.0
	for <alsa-devel@alsa-project.org>; Tue, 08 Dec 2009 07:02:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912081127460.22770@hippogriff.cosy.sbg.ac.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-12-08 at 12:28 +0100, Peter Meerwald wrote:
> Hello,
> 
> I'm trying to use the SoC TLV320AIC3x codec driver with sysclk 16384000 
> and ran into some problems with setting PLL; below is a patch against 
> linux-2.6-asoc
> 
> note that the original code uses variables pll_r and pll_p instead of the 
> loop variable r and p to compute tmp, this seems broken
> 
> further, the original code does not respect the constraints on j (>= 4, <= 
> 55 for d==0) according to the codec's datasheet, and similarly for d!=0
> 
> I've tested the code with a number of reasonable sysclk values and got 
> sane PLL values; please apply if acceptable
> 

Can you confirm you also tested against 12.288MHz and 11.2869MHz ?

If so, Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Thanks

Liam

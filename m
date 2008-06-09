From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 1/2] opti93x: add support for Opti93x codec
	in cs4231-lib
Date: Tue, 10 Jun 2008 01:21:43 +0200
Message-ID: <484DBB07.1080802@keyaccess.nl>
References: <20080609230728.273c9e1e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 83D7024A1D
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jun 2008 01:21:42 +0200 (CEST)
In-Reply-To: <20080609230728.273c9e1e.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09-06-08 23:07, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch adds support for WSS compatible Opti93x
> codec to the cs4231-lib.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> This patch was sent some time ago but was not accepted
> due to regression of the driver on the  opti 930 chip.
> The regression is fixed with already accepted patch, so 
> it should work now. 

Could you elaborate a bit? Yesterday's patch removing the QS1000 from 
82C930 fixed the 930 staying silent but the regression this introduced 
previously at least appeared to be a different one.

Post QS1000, 82C930 appeared to work fine, just didn't actually produce 
a signal onto its analog out. Post CS4231, 82C930 wasn't just silent but 
didn't even generate any interrupts anymore.

I didn't compare with your old code...

> The patch was prepared against the 2.6.26-rc5 kernel. Tested on Opti
> 930, 931 and 933.

Tested-by: Rene Herman <rene.herman@gmail.com>

also on 930, 931 and 933 for playback, capture on 930 and 931. So 
whatever the answer to the above, it appears that problem is now also 
fixed. Which is very good; this is a rather welcome unification/cleanup 
as far as I'm concerned.

The mixer levels do seem different between the old and new driver. Does 
that make sense? The new one appears to  be a bit louder so there might 
be an offset issue somewhere I suppose. I didn't compare that closely.

Rene.

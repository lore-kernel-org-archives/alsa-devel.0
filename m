From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] opti93x: fix sound ouput for Opti930
Date: Sun, 08 Jun 2008 22:29:03 +0200
Message-ID: <484C410F.2090701@keyaccess.nl>
References: <20080608075753.6e55b6ba.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 2320124803
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jun 2008 22:29:07 +0200 (CEST)
In-Reply-To: <20080608075753.6e55b6ba.krzysztof.h1@poczta.fm>
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
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08-06-08 07:57, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch fixes silenced output from the Opti930.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> The bug was introduced by me in the patch which added 
> QS1000 wavetable support:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f81b953d43c2c12f617da3ecec25e04b5c9e6eb2
> 
> Simply do not change digital input bits on Opti930.

Oh, right, that was it:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-February/005898.html

I've tested that sound is back after this patch on my 930 as well:

Acked-by: Rene Herman <rene.herman@gmail.com>

I did experience a few instances where the 930 produced nothing but 
static after adjusting its mixer down but this is not going to have 
anything to do with this patch. Mentioned just in case you're now 
looking at a 930 and seeing similar things -- it's not just your card in 
that case...

Rene.

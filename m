From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH V2] ASoC: mcbsp: remove unnecessary null
 test before kfree
Date: Fri, 27 Jun 2014 09:01:06 +0300
Message-ID: <20140627060106.GA20108@bitmer.com>
References: <1403812063-12251-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id AA9A7264F8D
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 08:01:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1403812063-12251-1-git-send-email-fabf@skynet.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 26, 2014 at 09:47:43PM +0200, Fabian Frederick wrote:
> Fix checkpatch warning:
> WARNING: kfree(NULL) is safe this check is probably not required
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> V2: replace subject "sound/soc/omap/mcbsp.c" by "ASoC: mcbsp:"
> (suggested by Peter Ujfalusi)
> 
>  sound/soc/omap/mcbsp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
I noticed ASoC maintainers Mark Brown <broonie@kernel.org> and Liam
Girdwood <lgirdwood@gmail.com> were not CC'ed so in case this patch gets buried
under list traffic and if you won't see this patch applied in a ~1 week, please
resend with them CC'ed.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com> 

From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Suppress restore of default register
 values for rbtree cache sync
Date: Fri, 03 Jun 2011 17:29:32 +0100
Message-ID: <4DE90BEC.1000404@ti.com>
References: <1307115435-18213-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id A05C7103974
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 20:38:46 +0200 (CEST)
In-Reply-To: <1307115435-18213-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "dp@opensource.wolfsonmicro.com" <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 03/06/11 16:37, Mark Brown wrote:
> Currently the rbtree code will write out the entire register map when
> doing a cache sync which is wasteful and will slow things down. Check
> to see if the value we're about to write is the default and don't bother
> restoring it if it is, either the value will have been retained or the
> device will have been reset and holds the value already.
> 
> We should really store the defaults in the nodes but this resolves the
> immediate issue.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>

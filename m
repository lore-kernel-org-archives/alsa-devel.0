From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Move register I/O code into a
	separate file
Date: Mon, 13 Jun 2011 18:44:05 +0100
Message-ID: <4DF64C65.9040100@ti.com>
References: <1307983867-5084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D17D524384
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 19:44:11 +0200 (CEST)
In-Reply-To: <1307983867-5084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 13/06/11 17:51, Mark Brown wrote:
> For clarity and to help ongoing refactoring in this area create a new file
> to contain the physical I/O functions, separating them out from the cache
> operations.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/Makefile    |    3 +-
>  sound/soc/soc-cache.c |  380 ----------------------------------------------
>  sound/soc/soc-io.c    |  399 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 401 insertions(+), 381 deletions(-)
>  create mode 100644 sound/soc/soc-io.c
> 

Acked-by: Liam Girdwood <lrg@ti.com>

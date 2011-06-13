From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Factor out redundant read() functions
Date: Mon, 13 Jun 2011 14:21:35 +0100
Message-ID: <4DF60EDF.8020605@ti.com>
References: <1307731717-16506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BB4741037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 15:21:44 +0200 (CEST)
In-Reply-To: <1307731717-16506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 10/06/11 19:48, Mark Brown wrote:
> We've got a whole bunch of functions which just call straight through to
> do_hw_read(). Simplify this situation by removing them and using hw_read()
> directly.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |   52 +++++++-----------------------------------------
>  1 files changed, 8 insertions(+), 44 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>

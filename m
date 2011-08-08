From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Move WM8962 CLKREG_OVD earlier
Date: Mon, 8 Aug 2011 16:45:42 +0100
Message-ID: <1312818342.3314.1.camel@CNA0741383>
References: <1312761937-1764-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id E17892452A
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 17:45:47 +0200 (CEST)
In-Reply-To: <1312761937-1764-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2011-08-08 at 02:05 +0200, Mark Brown wrote:
> When the clocking registers are not overriden some of the registers are
> not writable.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8962.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>

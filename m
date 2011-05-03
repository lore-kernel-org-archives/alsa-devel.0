From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Don't crash on PM operations
Date: Tue, 03 May 2011 23:02:15 +0100
Message-ID: <1304460135.3362.26.camel@odin>
References: <1304443567-1530-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E01424496
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 00:02:20 +0200 (CEST)
Received: by wwf26 with SMTP id 26so455247wwf.20
	for <alsa-devel@alsa-project.org>; Tue, 03 May 2011 15:02:18 -0700 (PDT)
In-Reply-To: <1304443567-1530-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-05-03 at 18:26 +0100, Mark Brown wrote:
> The move over to exposing snd_soc_register_card() let the initialisation
> of the driver data we use to find the card in PM operations go AWOL. Fix
> this by setting the driver data when we register the card.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>

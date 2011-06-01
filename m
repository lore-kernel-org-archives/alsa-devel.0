From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Support edge triggered IRQs for
	WM8915
Date: Wed, 1 Jun 2011 17:11:43 +0100
Message-ID: <4DE664BF.8090609@ti.com>
References: <1306935999-15469-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B368B103858
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 18:11:45 +0200 (CEST)
In-Reply-To: <1306935999-15469-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 01/06/11 14:46, Mark Brown wrote:
> Really this should be something the IRQ core can cope with for us but since
> it doesn't currently do so (at least for threaded interrupts like this) do
> so in the driver. This allows us to run with interrupt controllers that
> only support edge triggered interrupts.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>

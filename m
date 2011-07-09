From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH] ASoC: OMAP4: HDMI: Make stricter
 dependency on OMAP2_DSS
Date: Sat, 09 Jul 2011 12:06:52 +0100
Message-ID: <1310209614.3556.0.camel@odin>
References: <1310071134-11625-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 94CEA2447F
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 15:05:49 +0200 (CEST)
Received: by wyh21 with SMTP id 21so2816097wyh.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2011 06:05:49 -0700 (PDT)
In-Reply-To: <1310071134-11625-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: tomi.valkeinen@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-07-07 at 15:38 -0500, Ricardo Neri wrote:
> When building DSS HDMI driver with audio support, there is dependency
> on SND_SOC to register the ASoC audio codec. Also, SND_OMAP_SOC_OMAP4_HDMI
> has dependency on OMAP2_DSS. Then, to avoid build breakages,
> SND_OMAP_SOC_OMAP4_HDMI, is restricted to be available only when
> OMAP2_DSS AND SND_SOC have the same build type.
> 
> Also, dependency on ARCH_OMAP4 is removed, as it is checked indirectly
> by OMAP4_DSS_HDMI.
> 
> Reported-by: Liam Girdwood <lrg@ti.com>
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---

Applied

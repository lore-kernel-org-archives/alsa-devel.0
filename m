From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: spdif: Add codec driver to use spdif
 stand-alone
Date: Thu, 27 May 2010 14:54:23 +0100
Message-ID: <1274968463.3542.287.camel@odin>
References: <1274951628-10572-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f177.google.com (mail-wy0-f177.google.com
	[74.125.82.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A499103A85
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 15:54:29 +0200 (CEST)
Received: by wyb33 with SMTP id 33so637242wyb.8
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 06:54:28 -0700 (PDT)
In-Reply-To: <1274951628-10572-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, schen@mvista.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-05-27 at 18:13 +0900, Seungwhan Youn wrote:
> This patch adds spdif dummy codec driver for using spdif-dit as
> a stand-alone. Until this, spdif-dit can be used only with other
> codecs like tlv320aci3x in davinci platform.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
>  sound/soc/codecs/spdif_transciever.c |   93 +++++++++++++++++++++++++++++++++-
>  1 files changed, 92 insertions(+), 1 deletions(-)


> +	spdif_dit_codec = NULL;

This isn't really necessary as the module is being removed at this
point.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

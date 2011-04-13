From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: codecs: JZ4740: Fix OOPS
Date: Wed, 13 Apr 2011 08:39:55 +0100
Message-ID: <1302680395.3600.11.camel@odin>
References: <1302629609-21537-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id C4FA710381A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 09:39:58 +0200 (CEST)
Received: by wwi18 with SMTP id 18so4656381wwi.2
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2011 00:39:58 -0700 (PDT)
In-Reply-To: <1302629609-21537-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-04-12 at 19:33 +0200, Lars-Peter Clausen wrote:
> Commit ce6120cc(ASoC: Decouple DAPM from CODECs) changed the signature of
> snd_soc_dapm_widgets_new to take an pointer to a snd_soc_dapm_context instead of
> a snd_soc_codec. The call to snd_soc_dapm_widgets_new in jz4740_codec_dev_probe
> was not updated to reflect this change, which results in a compiletime warning
> and a runtime OOPS.
> 
> Since the core code calls snd_soc_dapm_widgets_new after the codec has been
> registered it can be dropped here.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Both

Acked-by: Liam Girdwood <lrg@ti.com>

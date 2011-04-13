From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: codecs: JZ4740: Fix OOPS
Date: Wed, 13 Apr 2011 10:36:14 -0700
Message-ID: <20110413173614.GE18008@opensource.wolfsonmicro.com>
References: <1302629609-21537-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B110510384D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 19:36:04 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 12, 2011 at 07:33:28PM +0200, Lars-Peter Clausen wrote:
> Commit ce6120cc(ASoC: Decouple DAPM from CODECs) changed the signature of
> snd_soc_dapm_widgets_new to take an pointer to a snd_soc_dapm_context instead of
> a snd_soc_codec. The call to snd_soc_dapm_widgets_new in jz4740_codec_dev_probe

Applied both, thanks.

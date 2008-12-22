From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [topic/asoc][PATCH] ASoC: Fix DSP formats
	in	SSM2602 audio codec
Date: Mon, 22 Dec 2008 14:45:52 +0000
Message-ID: <20081222144551.GA30743@rakim.wolfsonmicro.main>
References: <1229936253-5115-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7E021037E3
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 15:45:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1229936253-5115-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 22, 2008 at 10:57:33AM +0200, Jarkko Nikula wrote:
> Thanks to Troy Kisky <troy.kisky@boundarydevices.com> for noticing.

> - DSP_A format has 1-bit data delay which corresponds to SSM6202 submode 2
> - DSP_B has 0-bit data delay which corresponds to submode 1
> - Currently driver sets them opposite so swap the submode setting

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Cliff Cai <cliff.cai@analog.com>

Presumably this means that the Blackfin I2S driver also needs to be
updated (probably just replacing DSP_A with DSP_B by the looks of it)?
Though since the SSM6206 machine driver uses I2S it shouldn't matter too
much if they're out of sync temporarily.

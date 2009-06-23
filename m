From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Correct bypass event for
	voice sidetone
Date: Tue, 23 Jun 2009 08:18:44 +0300
Message-ID: <200906230818.44470.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3555FB1F@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 37B2124506
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 07:18:49 +0200 (CEST)
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E3555FB1F@dlee04.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 23 June 2009 03:34:07 ext Lopez Cruz, Misael wrote:
> Event for voice sidetone was being interpreted as an
> analog HiFi bypass event because VSTPGA register offset
> is less than ARXR2_APGA_CTL offset. Reordering the
> register checks allows to handle voice digital bypass
> event properly.
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  sound/soc/codecs/twl4030.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)

Good catch.

BTW: I think I'll try to get rid of this bypass handling at some point.
Now that ASoC core has support for keeping the codec in BIAS_ON when any of 
the paths are active we should not need this black magic with the bypasses.

But I'm afraid this has to wait, since I will start my summer holiday quite 
soon...

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

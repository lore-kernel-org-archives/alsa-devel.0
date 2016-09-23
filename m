From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: add explicit support
 for tlv320dac31xx
Date: Fri, 23 Sep 2016 11:03:14 +0200
Message-ID: <1474621394.10437.19.camel@hadess.net>
References: <1474574803-4007-1-git-send-email-nikita.yoush@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C88726718B
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2016 11:03:20 +0200 (CEST)
In-Reply-To: <1474574803-4007-1-git-send-email-nikita.yoush@cogentembedded.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2016-09-22 at 23:06 +0300, Nikita Yushchenko wrote:
> tlv320dac31xx is a subset of tlv320aic31xx:
> - it does not have MIC inputs and ADC, thus capture is not supported,
> - it has analog inputs AIN1/AIN2 that can be mixed into output.
> 
> Although tlv320dac31xx does work with tlv320aic31xx driver, this
> setup
> does register non-existent widgets and non-existent capture stream.
> Thus userspace lists non-existent objects in user interfaces, an can
> access these, causing operations with device registers that are
> declared as "reserved" in tlv320dac31xx datasheet.
> 
> This patch fixes this situation by separating controls/widgets/routes
> into common, aic31xx-specific, and dac31xx-specific parts. Only parts
> that match actual hardware (as declared in "compatible" device tree
> property) are registered.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

I don't have access to the hardware. My original patch allowed playback
to work (ish) on a specific device that I don't own. Probably best to
ignore my patch, or even revert it before applying this one.

Cheers

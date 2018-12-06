From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 3/7] ASoC: dt-bindings: make enable-gpio
 optional for simple amplifier
Date: Thu, 6 Dec 2018 17:43:45 -0600
Message-ID: <20181206234345.GA1842@bogus>
References: <20181121051752.18387-1-anarsoul@gmail.com>
 <20181121051752.18387-4-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 30638267CA4
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 00:43:47 +0100 (CET)
Received: by mail-oi1-f194.google.com with SMTP id j21so1968763oii.8
 for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2018 15:43:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181121051752.18387-4-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Nov 2018 21:17:48 -0800, Vasily Khoruzhick wrote:
> Amplifier may have no enable GPIO, so make this property optional
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/simple-amplifier.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

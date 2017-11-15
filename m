From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 07/17] ASoC: tlv320aic31xx: Add MICBIAS off
	setting
Date: Wed, 15 Nov 2017 09:30:42 -0600
Message-ID: <20171115153042.4f72ackp7sy2flpf@rob-hp-laptop>
References: <20171109002741.10897-1-afd@ti.com>
 <20171109002741.10897-8-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id B620A266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 16:30:44 +0100 (CET)
Received: by mail-oi0-f45.google.com with SMTP id f135so1136039oib.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 07:30:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171109002741.10897-8-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 08, 2017 at 06:27:31PM -0600, Andrew F. Davis wrote:
> Leaving microphone bias off is a valid setting and even used in the DT
> binding document example. Add this setting here and document the same.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 1 +
>  include/dt-bindings/sound/tlv320aic31xx-micbias.h         | 1 +
>  sound/soc/codecs/tlv320aic31xx.c                          | 1 +
>  3 files changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

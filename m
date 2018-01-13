From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: fix powerup/down of
	micbias-voltage
Date: Fri, 12 Jan 2018 22:05:31 -0200
Message-ID: <CAOMZO5A9ypZOhA01hHwS3Eyig7t=3ivD2nnWh8NF7PB2P-w-Uw@mail.gmail.com>
References: <DD64F087E8F0B540A1C9216D6716FFBDF994813E@defrsexc01.swissphone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B8F8C266B67
 for <alsa-devel@alsa-project.org>; Sat, 13 Jan 2018 01:05:33 +0100 (CET)
Received: by mail-oi0-f65.google.com with SMTP id t16so5012196oif.10
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 16:05:33 -0800 (PST)
In-Reply-To: <DD64F087E8F0B540A1C9216D6716FFBDF994813E@defrsexc01.swissphone.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fischer, Christian" <fischerc@swissphone.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "bhumirks@gmail.com" <bhumirks@gmail.com>, "richard.leitner@skidata.com" <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

Hi Christian,

On Fri, Jan 12, 2018 at 10:35 AM, Fischer, Christian
<fischerc@swissphone.de> wrote:

> Thanks for this tip!
> The problem is that the machine-driver mxs-sgtl5000 don't support audio-routing.
> I've prepared a patch that will be submitted this noon.

What about using simple audio card binding in your device tree instead?

You could pass the simple-audio-card,routing property as described in
Documentation/devicetree/bindings/sound/simple-card.txt

A dts where sgtl5000 is used with simple audio card is
arch/arm/boot/dts/imx7s-warp.dts.

This one does not use simple-audio-card,routing, but at least it gives
you a reference.

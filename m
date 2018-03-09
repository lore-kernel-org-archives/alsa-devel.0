From: Matt Porter <mporter@konsulko.com>
Subject: Re: [PATCH 1/2] ASoC: add tda7419 audio processor
	binding
Date: Fri, 9 Mar 2018 09:39:47 -0500
Message-ID: <20180309143947.vxmzuqmlwdyf2gpd@bacon.ohporter.com>
References: <20180227225128.17815-1-mporter@konsulko.com>
 <20180227225128.17815-2-mporter@konsulko.com>
 <20180305222954.chitmlvsklszods7@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8387266EBE
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 15:39:51 +0100 (CET)
Received: by mail-io0-f193.google.com with SMTP id g21so3778824ioj.5
 for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2018 06:39:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180305222954.chitmlvsklszods7@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 05, 2018 at 04:29:54PM -0600, Rob Herring wrote:
> On Tue, Feb 27, 2018 at 05:51:27PM -0500, Matt Porter wrote:
> > DeviceTree binding for the tda7419 audio processor.
> > 
> > Signed-off-by: Matt Porter <mporter@konsulko.com>
> > ---
> >  Documentation/devicetree/bindings/sound/tda7419.txt | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
> > new file mode 100644
> > index 000000000000..919318315600
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tda7419.txt
> > @@ -0,0 +1,15 @@
> > +TDA7419 audio processor
> > +
> > +This device supports I2C only.
> > +
> > +Required properties:
> > +
> > +- compatible : "st,tda7419"
> > +- reg : the I2C address of the device.
> 
> For completeness:
> 
> st,mute-gpios for MUTE pin?

I'll add mute in as an optional property.

> 
> vdd-supply?

Yes, there's a required ~8.5V supply so I'll add the regulator reference.

Thanks,
Matt

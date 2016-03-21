From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: codecs: add TA5720 digital
 amplifier DT bindings
Date: Mon, 21 Mar 2016 09:06:03 -0500
Message-ID: <20160321140603.GN20025@borg.dal.design.ti.com>
References: <1458343678-4086-1-git-send-email-dannenberg@ti.com>
 <1458343678-4086-2-git-send-email-dannenberg@ti.com>
 <20160321124555.GA12693@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 03DAD264F37
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 15:06:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160321124555.GA12693@rob-hp-laptop>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 21, 2016 at 07:45:55AM -0500, Rob Herring wrote:
> > +Optional properties:
> > +
> > +- dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
> > +- pvdd-supply : phandle to a supply used for the Class-D amp and the analog
> > +- interrupts-extended : reference to a GPIO pin connected to the TAS5720
> > +                        FAULTZ pin for error reporting purposes
> 
> There's no point in having interrupts-extended here with a single 
> interrupt. It is fine to use, but really that's outside the scope of 
> this binding. So I'd just document "interrupts" here as that is what 
> most docs do, and that implies interrupts-extended could be used.

Hi Rob,
Good point. Will remove it for v2.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

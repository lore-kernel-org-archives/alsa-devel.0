From: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/4] dt-bindings: Document the dmas and
 dma-names properties for bcm2835-analog-audio
Date: Mon, 20 Mar 2017 10:07:34 -0700
Message-ID: <1490029654.11105.7.camel@crowfest.net>
References: <20170312063820.19313-1-mzoran@crowfest.net>
         <20170320165009.ylrohjwettdy2lgf@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170320165009.ylrohjwettdy2lgf@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-AbSShOkvfpQ@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-03-20 at 11:50 -0500, Rob Herring wrote:
> On Sat, Mar 11, 2017 at 10:38:17PM -0800, Michael Zoran wrote:
> > Add documentation for the DMA properties required when using the
> > PWM controller of the bcm2835 for analog audio output.
> > 
> > Signed-off-by: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 9
> > ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
> > b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
> > index cf573e85b11d..08fc06fc083a 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
> > @@ -1,14 +1,21 @@
> >  BCM2835 PWM controller (Raspberry Pi controller)
> >  
> >  Required properties:
> > -- compatible: should be "brcm,bcm2835-pwm"
> > +- compatible: should be "brcm,bcm2835-pwm" or "brcm,bcm2835-
> > analog-audio"
> 
> Compatibles are not for selecting usage modes. You should describe
> the 
> connection to the pwm that makes it an audio output rather than
> change 
> the compatible.
> 

Cool, that's good to know that someone let me know after all this time.
 And please tell how if DT nodes are an exact documentation of the
hardware how are virtualized DT nodes like firmware getting into the
DTs?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

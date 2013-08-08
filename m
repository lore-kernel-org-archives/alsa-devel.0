From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ASoC: dt: Move WM8903 pin list from Tegra
 board binding to CODEC binding
Date: Thu, 8 Aug 2013 09:30:34 +0100
Message-ID: <20130808083034.GB14648@e106331-lin.cambridge.arm.com>
References: <1375899380-17714-1-git-send-email-broonie@kernel.org>
 <52029666.90701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B922A265677
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 10:30:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <52029666.90701@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Brown <broonie@linaro.org>, Liam Girdwod <lgirdwood@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 07, 2013 at 07:48:06PM +0100, Stephen Warren wrote:
> On 08/07/2013 12:16 PM, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>
> > 
> > The pin list is the same for any board using the CODEC.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> (CC'ing the other DT binding maintainers)

Fine by me also.

Acked-by: Mark Rutland <mark.rutland@arm.com>

> 
> > 
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > ---
> >  .../bindings/sound/nvidia,tegra-audio-wm8903.txt   | 24 ++--------------------
> >  Documentation/devicetree/bindings/sound/wm8903.txt | 19 +++++++++++++++++
> >  2 files changed, 21 insertions(+), 22 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
> > index 3bf722d..4b44dfb 100644
> > --- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
> > +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
> > @@ -11,28 +11,8 @@ Required properties:
> >  - nvidia,audio-routing : A list of the connections between audio components.
> >    Each entry is a pair of strings, the first being the connection's sink,
> >    the second being the connection's source. Valid names for sources and
> > -  sinks are the WM8903's pins, and the jacks on the board:
> > -
> > -  WM8903 pins:
> > -
> > -  * IN1L
> > -  * IN1R
> > -  * IN2L
> > -  * IN2R
> > -  * IN3L
> > -  * IN3R
> > -  * DMICDAT
> > -  * HPOUTL
> > -  * HPOUTR
> > -  * LINEOUTL
> > -  * LINEOUTR
> > -  * LOP
> > -  * LON
> > -  * ROP
> > -  * RON
> > -  * MICBIAS
> > -
> > -  Board connectors:
> > +  sinks are the WM8903's pins (documented in the WM8903 binding document),
> > +  and the jacks on the board:
> >  
> >    * Headphone Jack
> >    * Int Spk
> > diff --git a/Documentation/devicetree/bindings/sound/wm8903.txt b/Documentation/devicetree/bindings/sound/wm8903.txt
> > index f102cbc..94ec32c 100644
> > --- a/Documentation/devicetree/bindings/sound/wm8903.txt
> > +++ b/Documentation/devicetree/bindings/sound/wm8903.txt
> > @@ -28,6 +28,25 @@ Optional properties:
> >      performed. If any entry has the value 0xffffffff, that GPIO's
> >      configuration will not be modified.
> >  
> > +Pins on the device (for linking into audio routes):
> > +
> > +  * IN1L
> > +  * IN1R
> > +  * IN2L
> > +  * IN2R
> > +  * IN3L
> > +  * IN3R
> > +  * DMICDAT
> > +  * HPOUTL
> > +  * HPOUTR
> > +  * LINEOUTL
> > +  * LINEOUTR
> > +  * LOP
> > +  * LON
> > +  * ROP
> > +  * RON
> > +  * MICBIAS
> > +
> >  Example:
> >  
> >  codec: wm8903@1a {
> > 
> 
> 

From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: cs53l30: Add MUTE pin control
	support via GPIO
Date: Tue, 21 Jun 2016 15:32:11 -0700
Message-ID: <20160621223211.GA4287@Asurada-Nvidia>
References: <1466474084-6775-1-git-send-email-nicoleotsuka@gmail.com>
 <20160621213437.GA3571@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7292B2668D9
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 00:32:09 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id t190so2211179pfb.2
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 15:32:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160621213437.GA3571@rob-hp-laptop>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 21, 2016 at 04:34:37PM -0500, Rob Herring wrote:
> On Mon, Jun 20, 2016 at 06:54:44PM -0700, Nicolin Chen wrote:
> > The codec chip has a physical MUTE pin to let users control it via
> > GPIO. So this patch add a mute control support to the driver.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  .../devicetree/bindings/sound/cs53l30.txt          |  2 ++
> >  sound/soc/codecs/cs53l30.c                         | 30 ++++++++++++++++++++++
> >  sound/soc/codecs/cs53l30.h                         |  1 +
> >  3 files changed, 33 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/cs53l30.txt b/Documentation/devicetree/bindings/sound/cs53l30.txt
> > index 18d6b99..6f7d3c8 100644
> > --- a/Documentation/devicetree/bindings/sound/cs53l30.txt
> > +++ b/Documentation/devicetree/bindings/sound/cs53l30.txt
> > @@ -13,6 +13,8 @@ Optional properties:
> >  
> >    - reset-gpios : a GPIO spec for the reset pin.
> >  
> > +  - mute-gpios : a GPIO spec for the MUTE pin.
> 
> Please define the active state for the gpio.

The active state here is programmable and being taken care by the
driver automatically. Maybe I should have mentioned this in the
binding as well?

Thanks
Nic

From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] ASoC: zx-i2s: introduce pclk for zx2967 family
Date: Thu, 9 Feb 2017 09:48:09 +0800
Message-ID: <20170209014807.GO3407@dragon>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
 <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
 <20170209005207.y6wcrzk43ngfslhl@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170209005207.y6wcrzk43ngfslhl@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, wang.qiang01-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 08, 2017 at 06:52:07PM -0600, Rob Herring wrote:
> On Wed, Feb 08, 2017 at 11:02:34AM +0800, Baoyou Xie wrote:
> > ZTE's zx2967 I2S controller driver introduces pclk, this
> > patch documents this fact.
> 
> Now we have the same subject for patches 2 and 3.
> 
> Personally, I'd prefer "dt-bindings: sound: blah...", but not enough to 
> argue with Mark about it. If that is not the prefix, then it should at 
> least have "binding" in the subject.

+1

The prefix of sound bindings is quite unique from other subsystems.
Looking at the prefix of Documentation/devicetree/bindings/sound/
commits, I'm always confused whether it's a pure binding commit
or just submitted as part of the driver patch.  I feel that we
kinda lose the point of having a prefix.

Just my 2 cents.

Shawn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

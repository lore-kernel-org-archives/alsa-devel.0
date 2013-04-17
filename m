From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 17 Apr 2013 20:13:58 +0100
Message-ID: <20130417191358.GA19873@opensource.wolfsonmicro.com>
References: <515377AD.9080704@wwwdotorg.org>
 <20130327230730.GA18316@opensource.wolfsonmicro.com>
 <1121E117AD4ECE49880A389A396215BB8718BB370D@rtitmbs7.realtek.com.tw>
 <516DD0D4.5070409@wwwdotorg.org>
 <20130417140147.GM13687@opensource.wolfsonmicro.com>
 <516EBD46.7020804@wwwdotorg.org>
 <20130417152802.GZ13687@opensource.wolfsonmicro.com>
 <516ECCFA.8010204@wwwdotorg.org>
 <20130417185208.GA18950@opensource.wolfsonmicro.com>
 <516EF05E.6060606@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B945F26172C
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 21:13:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <516EF05E.6060606@wwwdotorg.org>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 17, 2013 at 12:56:30PM -0600, Stephen Warren wrote:
> On 04/17/2013 12:52 PM, Mark Brown wrote:

> > Not if you do it at the other end - do it during device registration.
> > If nothing is set up then feed the regulator API whatever the default
> > configuration is for the device, otherwise use what you were given.
> > The consumer side can't tell where the configuration came from and will
> > always have one.

> > This does mean you need to do the regulator driver if you support
> > non-default configurations but that's no bad thing.

> OK, so something like:

> During DT parsing:

> if (!dt_property_exits())
>     // regulator API call to set up a dummy regulator for this device

You should probably have an actual regulator for the regulator that's
physically there and doing things but yes.  If (as one should) you're
supporting platform data as well then the DT code should just work with
no extra effort.

The WM8994 code I posted recently does all this, the regulator side is
in -next though Samuel didn't pick up the DT stuff yet and non-default
configurations just aren't supported except with platform data since I
am not aware of any such designs.

> The one thing I may have forgotten to mention here for the LDO1 case is
> that if we don't explicitly support regulators right away, then instead
> the driver needs to explicitly request a GPIO to control the LDO1_EN
> input on the chip; without that, the device won't even respond to I2C
> accesses. And hence, that GPIO also needs to be described in device
> tree. The other regulators could certainly all work as you're pointing out.

That's expected, yes - you can just define a property for the GPIO and
move it over to being handled by a proper regulator driver when you
write one.

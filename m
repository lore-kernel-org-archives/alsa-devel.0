From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 17 Apr 2013 12:56:30 -0600
Message-ID: <516EF05E.6060606@wwwdotorg.org>
References: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
 <20130327011511.GP18316@opensource.wolfsonmicro.com>
 <515377AD.9080704@wwwdotorg.org>
 <20130327230730.GA18316@opensource.wolfsonmicro.com>
 <1121E117AD4ECE49880A389A396215BB8718BB370D@rtitmbs7.realtek.com.tw>
 <516DD0D4.5070409@wwwdotorg.org>
 <20130417140147.GM13687@opensource.wolfsonmicro.com>
 <516EBD46.7020804@wwwdotorg.org>
 <20130417152802.GZ13687@opensource.wolfsonmicro.com>
 <516ECCFA.8010204@wwwdotorg.org>
 <20130417185208.GA18950@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 93845261727
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 20:56:35 +0200 (CEST)
In-Reply-To: <20130417185208.GA18950@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 04/17/2013 12:52 PM, Mark Brown wrote:
> On Wed, Apr 17, 2013 at 10:25:30AM -0600, Stephen Warren wrote:
>> On 04/17/2013 09:28 AM, Mark Brown wrote:
> 
>>> You can do the same thing with DT as you do with board files -
>>> make those supplies an optional property and then if the property
>>> is missing do the default thing.
> 
>> But then, you end up with an optional regulator, and the driver has to
>> do things like:
> 
>> if (!IS_ERR(x->reg_foo))
>> 	regulator_enable(x->reg_foo);
> 
> Not if you do it at the other end - do it during device registration.
> If nothing is set up then feed the regulator API whatever the default
> configuration is for the device, otherwise use what you were given.
> The consumer side can't tell where the configuration came from and will
> always have one.
> 
> This does mean you need to do the regulator driver if you support
> non-default configurations but that's no bad thing.

OK, so something like:

During DT parsing:

if (!dt_property_exits())
    // regulator API call to set up a dummy regulator for this device

Somewhere later in the probe() path:

x->reg = regulator_get();

The one thing I may have forgotten to mention here for the LDO1 case is
that if we don't explicitly support regulators right away, then instead
the driver needs to explicitly request a GPIO to control the LDO1_EN
input on the chip; without that, the device won't even respond to I2C
accesses. And hence, that GPIO also needs to be described in device
tree. The other regulators could certainly all work as you're pointing out.

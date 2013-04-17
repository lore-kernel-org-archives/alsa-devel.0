From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 17 Apr 2013 10:25:30 -0600
Message-ID: <516ECCFA.8010204@wwwdotorg.org>
References: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
 <20130327011511.GP18316@opensource.wolfsonmicro.com>
 <515377AD.9080704@wwwdotorg.org>
 <20130327230730.GA18316@opensource.wolfsonmicro.com>
 <1121E117AD4ECE49880A389A396215BB8718BB370D@rtitmbs7.realtek.com.tw>
 <516DD0D4.5070409@wwwdotorg.org>
 <20130417140147.GM13687@opensource.wolfsonmicro.com>
 <516EBD46.7020804@wwwdotorg.org>
 <20130417152802.GZ13687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 929132616DC
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 18:25:35 +0200 (CEST)
In-Reply-To: <20130417152802.GZ13687@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 04/17/2013 09:28 AM, Mark Brown wrote:
> On Wed, Apr 17, 2013 at 09:18:30AM -0600, Stephen Warren wrote:
>> On 04/17/2013 08:01 AM, Mark Brown wrote:
> 
>>> That said if boards generally don't use external supplies and
>>> use the built in regulators then it's probably best to at least
>>> have the driver assume that by default.
> 
>> So the issue here is that regulators aren't supposed to be
>> optional, right? So if there's a reasonable chance that
>> regulators would ever be needed, we should add them now.
> 
>> With board files, we probably could have just added them later,
>> but with device tree (which is my use-case for this CODEC at
>> least), the DT binding needs to specify which regulator(s) the
>> device requires (if any) right from the start, so that all DTs
>> will include the regulator definitions.
> 
> You can do the same thing with DT as you do with board files -
> make those supplies an optional property and then if the property
> is missing do the default thing.

But then, you end up with an optional regulator, and the driver has to
do things like:

if (!IS_ERR(x->reg_foo))
	regulator_enable(x->reg_foo);

I thought the whole point of the rule that "if a regulator is ever
needed, it must always be provided, and if there isn't one on the
board, use a 'dummy' fixed-regulator" was to avoid exactly that?

But if that rule is relaxed, and the code above is fine, then indeed
one can do as you say.

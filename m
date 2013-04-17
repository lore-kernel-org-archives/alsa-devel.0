From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 17 Apr 2013 09:18:30 -0600
Message-ID: <516EBD46.7020804@wwwdotorg.org>
References: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
 <20130327011511.GP18316@opensource.wolfsonmicro.com>
 <515377AD.9080704@wwwdotorg.org>
 <20130327230730.GA18316@opensource.wolfsonmicro.com>
 <1121E117AD4ECE49880A389A396215BB8718BB370D@rtitmbs7.realtek.com.tw>
 <516DD0D4.5070409@wwwdotorg.org>
 <20130417140147.GM13687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C67D2616A6
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 17:18:34 +0200 (CEST)
In-Reply-To: <20130417140147.GM13687@opensource.wolfsonmicro.com>
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

On 04/17/2013 08:01 AM, Mark Brown wrote:
> On Tue, Apr 16, 2013 at 04:29:40PM -0600, Stephen Warren wrote:
> 
>> a) There are many different VDD inputs to the chip. I imagine
>> that some of these only need to be enabled/active under certain
>> conditions. For example, perhaps the SPKVDD or MICVDD inputs are
>> only required if actively using the speakers or microphones, and
>> could be disabled at other times? If so, all of these "optional"
>> or "part-time" VDD inputs should be represented as regulators,
>> and retrieved/manipulated using Linux APIs such as
>> regulator_get(), regulator_enable(), etc.
> 
> There's framework support for regulator supplies in ASoC so you
> just need to specify the name and the core will do the rest.
> 
>> b) Some VDD inputs are optional; for example, either I believe
>> that a board should either provide DCVDD, or provide LDO1_IN and
>> assert the LDO1_EN input signal. Similarly, I think that either
>> MICVDD should be provided, or SPKVDDL be provided, coupled with
>> LDO2_EN register bit being set. This may require the RT5640
>> driver to provide two regulator objects (LDO1, LDO2), which the
>> board file or device tree can connect back to the DCVDD and
>> MICVDD inputs if appropriate for the board's HW configuration. In
>> the case where LDO1 is used, a separate fixed regulator with GPIO
>> should be used to control the LDO1_EN GPIO input.
> 
> That said if boards generally don't use external supplies and use
> the built in regulators then it's probably best to at least have
> the driver assume that by default.

So the issue here is that regulators aren't supposed to be optional,
right? So if there's a reasonable chance that regulators would ever be
needed, we should add them now.

With board files, we probably could have just added them later, but
with device tree (which is my use-case for this CODEC at least), the
DT binding needs to specify which regulator(s) the device requires (if
any) right from the start, so that all DTs will include the regulator
definitions.

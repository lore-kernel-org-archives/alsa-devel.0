From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator
 notification handling
Date: Tue, 4 Sep 2018 10:55:05 -0500
Message-ID: <6c1cc350-b806-2f9b-8cf4-72390f13a0ec@ti.com>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
 <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
 <20180904145740.GE12993@sirena.org.uk>
 <f6c7df62-a98f-009a-2169-0e5564f4b675@ti.com>
 <20180904154905.GH12993@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F6B72676C6
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 17:55:07 +0200 (CEST)
In-Reply-To: <20180904154905.GH12993@sirena.org.uk>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/04/2018 10:49 AM, Mark Brown wrote:
> On Tue, Sep 04, 2018 at 10:03:40AM -0500, Andrew F. Davis wrote:
>> On 09/04/2018 09:57 AM, Mark Brown wrote:
> 
>>> It's there to save us having to rewrite the register cache if we asked
>>> for the device to be powered down but that didn't actually happen due to
>>> other constraints, we know all the registers are still as we left them.
> 
>> I don't see that happening for any other user of this, we will still
>> have to re-write the cache when the device goes from OFF->STANDBY, and
> 
> You will?  All the power_off() code seems to do is mark the regmap as
> cache only and turn off the regulators.
> 

OFF->STANDBY will call power_on(). That is what is needed to start back
up after a regulator notification event.

>> if it stays in standby and never went off, then we are still broken as
>> we switched to using the register cache only, but never turned on real
>> writes again.
> 
> regmap can remember which registers were written to while in cache only
> mode and only sync the ones that are actually dirty, or you can
> invalidate the entire cache.
> 

If we never turn off cache only after a regulator notification then that
doesn't matter.

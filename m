From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
Date: Tue, 4 Sep 2018 10:03:40 -0500
Message-ID: <f6c7df62-a98f-009a-2169-0e5564f4b675@ti.com>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
 <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
 <20180904145740.GE12993@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904145740.GE12993@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/04/2018 09:57 AM, Mark Brown wrote:
> On Tue, Sep 04, 2018 at 09:50:50AM -0500, Andrew F. Davis wrote:
>> On 09/03/2018 06:30 AM, Mark Brown wrote:
>>> On Fri, Aug 31, 2018 at 01:17:37PM -0500, Andrew F. Davis wrote:
>>>> The notification handler sets the reset line but never re-enables it
>>>> as no one is listening for an enable event, this is certainly broken
>>>> and was most likely just copied from other CODECs, remove this code.
> 
>>> Why not fix it?  The usual pattern would be to take the CODEC out of
>>> reset when bringing the bias back to standby.
> 
>> The only time this code gets called outside of the normal power on/off
>> path is regulator_force_disable(). And the enable event is only called
>> inside regulator_enable() which would already be part of the normal
>> power up path.
> 
> It's there to save us having to rewrite the register cache if we asked
> for the device to be powered down but that didn't actually happen due to
> other constraints, we know all the registers are still as we left them.
> 

I don't see that happening for any other user of this, we will still
have to re-write the cache when the device goes from OFF->STANDBY, and
if it stays in standby and never went off, then we are still broken as
we switched to using the register cache only, but never turned on real
writes again.

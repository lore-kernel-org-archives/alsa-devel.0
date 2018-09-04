From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
Date: Tue, 4 Sep 2018 09:50:50 -0500
Message-ID: <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903113038.GG10302@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/03/2018 06:30 AM, Mark Brown wrote:
> On Fri, Aug 31, 2018 at 01:17:37PM -0500, Andrew F. Davis wrote:
>> The notification handler sets the reset line but never re-enables it
>> as no one is listening for an enable event, this is certainly broken
>> and was most likely just copied from other CODECs, remove this code.
> 
> Why not fix it?  The usual pattern would be to take the CODEC out of
> reset when bringing the bias back to standby.
> 

The only time this code gets called outside of the normal power on/off
path is regulator_force_disable(). And the enable event is only called
inside regulator_enable() which would already be part of the normal
power up path.

I still don't see the need for this code at all, I do not want to fix
unused broken code, and if no one else will fix it, the code should be
dropped.

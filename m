From: Gilles <gilles@whospot.com>
Subject: Re: Audio codec with multiple I2C devices
Date: Mon, 7 Apr 2014 11:32:27 -0700
Message-ID: <3C2805F4-7EB9-4E43-9140-98982932737C@whospot.com>
References: <mailman.300.1396595329.806.alsa-devel@alsa-project.org>
 <C71C517D-B88B-48C3-9156-AB9DD40AE4C0@whospot.com>
 <53411B1F.5070004@metafoo.de> <20140407113710.GC14763@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p3plsmtpa08-04.prod.phx3.secureserver.net
 (p3plsmtpa08-04.prod.phx3.secureserver.net [173.201.193.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 65026261A99
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 20:32:33 +0200 (CEST)
In-Reply-To: <20140407113710.GC14763@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


On Apr 7, 2014, at 04:37 , Mark Brown <broonie@kernel.org> wrote:

> On Sun, Apr 06, 2014 at 11:15:11AM +0200, Lars-Peter Clausen wrote:
>> On 04/05/2014 12:02 AM, Gilles wrote:
> 
> Always CC kernel related mails to relevant maintainers, it's very hit
> and miss if things on the list only will get seen.
> 
>>> I'm writing an ALSA SoC codec which uses a 3 distinct I2C devices (a
>>> DAC, a CAG for volume and a input selector) all 3 at different I2C
>>> addresses.
> 
>> If those are 3 distinct devices you'd typically implement them as 3
>> different drivers and model the interconnections between them at the
>> board/machine driver level.
> 
> If they're hard wired together then i2c_new_dummy() allows a single
> driver to control multiple slaves - have the driver instantiate from one
> of the addresses and then register dummies for the other addresses.  The
> framework is probably still going to want to see this registered as a
> series of CODECs though unless that's extended.  In any case the
> internal mappings for the devices ought to at least have helpers
> available so machine drivers don't need to reinvent things.

Yes, it would make much more sense for it to be all in the same driver for two reasons. (1) The only reason why there are multiple I2C are because the adapter has a novelty way of providing certain functions (like Volume) and there are no Codec chips on the market with that built-in. And (2) the functionality of - say the secondary I2C device - is only a simple control (in this case, a general volume which happens to be at a different I2C address.

Doesn't it make perfect sense to have the Volume be a control of the Codec driver even if it's provided by a separate chip on the same sound card?

I'm going to look into the suggested i2c_new_dummy(), I don't really want to write a separate volume codec. I was just wondering what would be the best way to make it DT friendly but I can see that's pretty much up to me to define my own DT property for the I2C address of the secondary chip.

Thanks for the pointer.
Gilles
.

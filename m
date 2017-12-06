From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [RFC PATCH 1/3] ASoC: Add platforms directory
Date: Wed, 6 Dec 2017 14:59:14 -0600
Message-ID: <5aaa3cdc-613d-25fe-0149-db91f0b9d8c6@ti.com>
References: <20171205181448.18513-1-afd@ti.com>
 <20171205181448.18513-2-afd@ti.com> <20171206123908.GB1827@finisterre>
 <561a6ebd-c978-c52a-a13a-3300be9a58bb@ti.com>
 <20171206172924.mrd233uipzorrymc@sirena.org.uk>
 <caea9bc4-94f3-41bc-5940-5769917962cf@ti.com>
 <20171206184219.fhhohxdihsm33kf6@sirena.org.uk>
 <d531a2c5-94d9-aa6f-dc6e-aeb22f70d746@ti.com>
 <20171206192707.vurfm6whlzku3ifk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id B3A3E267044
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 21:59:16 +0100 (CET)
In-Reply-To: <20171206192707.vurfm6whlzku3ifk@sirena.org.uk>
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

On 12/06/2017 01:27 PM, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 12:49:39PM -0600, Andrew F. Davis wrote:
>> On 12/06/2017 12:42 PM, Mark Brown wrote:
> 
>>> We need to preserve old bindings to ensure DT compatiblity, the easiest
>>> way to do that is to keep old machine drivers around.  There are plenty
>>> of older drivers that wouldn't be accepted now but would at least need
>>> replacing with a compatibility layer that adapts the bindings onto one
>>> of the generic drivers.  That adaption layer would definitely be useful
>>> (basically a big table of platform data) but it'd take time to implement
>>> it.
> 
>> We then should at least start depreciating them now so that someday we
>> can drop that stuff. Isolating them would be the first step.
> 
> Moving the drivers around is not going to help with that.  For users the
> drivers are not deprecated until someone actually steps up and makes
> something that allows the generic drivers to handle the old bindings and
> moves them over, at which point we'd just remove things that have been
> converted.  We can't just tell them not to use something without
> providing an alternative.  For developers they're just going to end up
> with the simpler machine drivers sitting next to a bunch of machine
> drivers that reasonably exist which I'm not sure clarifies anything.
> It's an orthogonal problem.
> 

It helps in that people would see an organized set of drivers to target,
"this folder here (sound/soc/machines/) should be reduced as much as
possible". Otherwise it is just, "go dig around for the machine drivers
burred together with platform drivers, which file is which type? Who
knows!?"

I will help too, but there needs to be just a bit of organization first.

>>> Wouldn't a few regexps in the MAINTAINERS file cover it?  We've already
>>> got a bunch of vendors doing this.
> 
>> pcm*
>> tas*
>> tlv*
>> twl*
> 
>> It's messy how many prefixes we have :/
> 
> Eh, not that bad.  And easy enough to do anyway.
> 

And it is easy enough to group them into a directory by something like
vendor, same as everyone else, including your very own sound/soc/. Yet
codecs/ is a giant 400+ file blob, by C file count it is the largest
directory in the whole kernel...

Top 10:

C files count: folder

130: drivers/staging/comedi/drivers
145: drivers/gpio
159: drivers/watchdog
164: drivers/rtc
165: drivers/hwmon
172: net/netfilter
175: drivers/acpi/acpica
194: lib
201: drivers/mfd
239: sound/soc/codecs

Maybe a bit of grouping wouldn't be so bad

From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Fri, 10 Jan 2014 18:32:38 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
 <20140109202446.GQ12858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CEED26158B
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 19:32:41 +0100 (CET)
In-Reply-To: <20140109202446.GQ12858@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Jan 2014 20:24:46 +0000, Mark Brown wrote:

> If you want to support any additional CODEC only devices with compatible
> register maps that exist you just need to add something like less than a
> hundred lines of mostly boilerplate code to do so in the ASoC driver.
> It's hard to see any difference to devices that have both I2C and SPI or
> both PCI and platform buses here.  Those devices should have separate
> device ID entries anyway.

The point is here is that it's unnecessary what you're suggesting. You're
basically adding more code to instantiate the Codec from the PMIC, removing the
valid I2C code from the Codec driver, and then if a user/customer wants to use
the Codec standalone then they need to add that code again. Agreed that new
device Ids should be added in the future for new standalone variants, but that
should not mean having to add all of the I2C boilerplate code again. It think
it makes things unnecessarily messy, on top of the additional effort required.

> I do agree that the current situation is not great - this is intended to
> try to move things forwards since mainline is currently broken for this
> device and has been for a couple of releases now.  One of the things my
> patch is trying to do is to get someone to tell us what we need to plug
> into i2c_add_dummy() to make this work.  I had hoped that if I wrote the
> code we could get this fixed but without documentation or something that
> last bit can't be done, would that be possible?

Well, the truth is that there are default I2C addresses for both PMIC and Codec
but as they are standalone devices, albeit in one package, both addresses can
be changed. This is one more reason why I don't believe we should be taking your
method of implementation here. If you just make sure PMIC and Codec drivers
have unique Ids then the problem is solved. If you are worried about people
changing this again in the future (although for the life of me I don't know
why they would), then we can add a glaring comment to dissuade them, or point
them at the codec driver.

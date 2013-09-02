From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Mon, 2 Sep 2013 09:49:20 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A033751E611AF@SW-EX-MBX01.diasemi.com>
References: <20130708112613.GQ27646@sirena.org.uk>
 <1373542576.9286.101.camel@matrix> <20130717103651.GP22506@sirena.org.uk>
 <1374482594.13726.11.camel@matrix> <20130722100211.GP9858@sirena.org.uk>
 <1375110386.21326.6.camel@matrix> <20130729160157.GZ9858@sirena.org.uk>
 <1375689331.28910.5.camel@matrix> <20130805144201.GF9858@sirena.org.uk>
 <1375717898.29528.23.camel@matrix>  <20130805162342.GS9858@sirena.org.uk>
 <1377778108.15438.6.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 52CD82610D1
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 11:54:38 +0200 (CEST)
In-Reply-To: <1377778108.15438.6.camel@matrix>
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
To: Ashish Chavan <ashish.chavan@kpitcummins.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 29, 2013 at 13:08, Ashish Chavan wrote:

> Apologies for my delayed response. Unfortunately I need to come out of
> this activity abruptly. One of my colleague, Adam Thomson will take this
> thread forward and will help in doing all required updates to the
> driver. He will also serve as future maintainer for DA9055 codec driver.
> 
> Thanks for all your support till date.

Hi Mark,

As Ashish mentioned, I'm now taking responsibility for this. Would be good to get
a quick resolution as this has been dragging along for some time now.

At present I believe your suggestion is to instantiate the codec regmap in the MFD
core for the PMIC, and then pass this in as part initialisation of the codec driver,
from the PMIC. Please correct me if I'm wrong.

If I'm correct then to me this doesn't make sense. The devices are separate,
and have completely independent register maps. As such I believe the instantiation
and ownership of the Codec register map should be in the Codec driver itself and
not performed outside by other code. If you were to use the Codec driver as a
standalone device, using the above approach, you would need to write some additional
code to create the regmap structure before you could use the driver. Seems logically
wrong to me and provides an unnecessary step for anyone wanting to use the driver.

I currently see two options on how to proceed with this:

1) Simply modify the Codec driver to use a different I2C id string and leave the rest of
the functionality as is (as was previously suggested, and my preferred option).

2) Including the above change, add some optional code to the PMIC MFD core which
uses 'i2c_new_device()' to instantiate the codec, if it's required (I guess indicated by
platform data to the PMIC). Means the Codec can still be used as is, but the PMIC core
code can, if required, instantiate the codec.

I personally believe option 2 seems unnecessary and it would be simple enough
just to instantiate the codec driver from machine code, as is done for many standalone
codecs. Am interested though in understanding the reasoning behind your suggestion,
for devices like this which are completely independent but can share the same HW
package. I currently don't see a good reason to make PMIC MFD core instantiate the
codec, for this type of scenario, but maybe you see something I don't?

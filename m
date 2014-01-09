From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Thu, 9 Jan 2014 11:30:42 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.137])
 by alsa0.perex.cz (Postfix) with ESMTP id E4D9E261A80
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 12:31:59 +0100 (CET)
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
To: "broonie@linaro.org" <broonie@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed,  8 Jan 2014 20:38:55 +0000, Mark Brown wrote:

> It has never been possible to even load the da9055 driver since both the
> MFD and CODEC drivers register the I2C device "da9055". Fix this by using
> the usual pattern for MFDs with multiple I2C addresses and having the CODEC
> driver reference an I2C dummy registered by the MFD.

> Since I don't know which I2C address to use for the CODEC a FIXME has been
> left in the MFD, this doesn't make anything any worse since the device has
> never been able to load in the first place.

What you're saying here is incorrect, as previously discussed at length in this thread:

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066027.html

The two drivers did work together fine until someone in 3.12 changed the PMIC I2C Id
back to just 'da9055' and broke it again. Also, I wanted to add a simple patch to tidy up
the I2C Id names and avoid this but you would not agree. The codec part can be
standalone and by doing what you've done here means that customers would need to
now add additional, unnecessary code to be able to use just the codec driver.
This is not right to me.
 

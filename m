From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: RE: [PATCH] ASoC: Add max98088 CODEC driver
Date: Wed, 29 Sep 2010 18:20:34 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40D46F2DA19@ITSVLEX06.it.maxim-ic.internal>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
 <20100929033757.GB29975@opensource.wolfsonmicro.com>
 <B2150E1E4418E1438554A300EA5040E40D46F2D8D8@ITSVLEX06.it.maxim-ic.internal>
 <20100929221826.GC31934@opensource.wolfsonmicro.com>
 <B2150E1E4418E1438554A300EA5040E40D46F2D9E9@ITSVLEX06.it.maxim-ic.internal>
 <20100930005850.GB4517@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100930005850.GB4517@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 29, 2010, Mark Brown wrote:
> On Wed, Sep 29, 2010 at 05:52:08PM -0700, Peter Hsiang wrote:
> > On Wed, Sep 29, 2010, Mark Brown wrote:
> 
> > > You're looking for the non-DAPM equivalent of SND_SOC_DAPM_VALUE_MUX().
> 
> > This is a simple table lookup of a register value from the index
> > number given by SOC_ENUM, the same way it's been done in other drivers.
> 
> Yes, exactly.
> 
> > I found a "case snd_soc_dapm_value_mux:" in dapm_set_path_status()
> > Is this what you are referring to?
> > How is the code there relevant to this?
> 
> No, I'm referring to the fact that it provides an enum that allows
> arbatrary values to be set for each enum value rather than just allowing
> indexes as the standard SOC_ENUM does.  This is essentially what you've
> implemented, it would factor out the code so that others can use it too
> (and IIRC save you some code since IIRC you had more than one of these
> in the driver).

Thank you!

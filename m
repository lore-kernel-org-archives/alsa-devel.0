From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 0/6] ASoC: sgtl5000: fix use of
 regulators and internal LDO
Date: Fri, 6 Mar 2015 23:24:29 +0000
Message-ID: <20150306232429.GI8656@n2100.arm.linux.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <54FA2F03.2060804@boundarydevices.com>
 <20150306225337.GH8656@n2100.arm.linux.org.uk>
 <54FA3122.9050805@boundarydevices.com>
 <54FA3542.1010402@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 0E9DA26609F
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 00:24:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54FA3542.1010402@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 06, 2015 at 04:16:18PM -0700, Eric Nelson wrote:
> Hi Russell,
> 
> On 03/06/2015 03:58 PM, Eric Nelson wrote:
> > Hi Russell,
> > 
> > On 03/06/2015 03:53 PM, Russell King - ARM Linux wrote:
> >> On Fri, Mar 06, 2015 at 03:49:39PM -0700, Eric Nelson wrote:
> >>> Based on your review, it seems like the following is needed for a
> >>> V2 patch (set):
> >>>
> >>> - Move call to sgtl5000_fill_defaults() earlier in the
> >>>   sgtl5000_i2c_probe routine, before adjusting ANA_POWER.
> >>>   This will allow registers LINEREG_CTRL, CLK_CTRL, and even ANA_POWER
> >>>   back into the default	register list.
> >>> - Move regulators from codec to I2C device
> >>> - switch to devm_regulator api
> >>> - various code cleanups to simplify logic
> >>> - Adjust regulator usage in SND_SOC_BIAS_OFF
> >>>
> >>> I'll leave out the "write all default" registers for the moment.
> >>
> >> I'll also interject here to say that, against mainline, I need this
> >> patch to make the sgtl5k work on SolidRun's Hummingboard hardware.
> >> Without this, the internal regulator seems to get powered down, and
> >> we lose access to the device until the entire board is power cycled.
> >>
> > 
> > Mark applied essentially the patch below separately from
> > the LDO support:
> > 	http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/088376.html
> > 	http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/088773.html
> > 
> >>  sound/soc/codecs/sgtl5000.c | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> >> index e182e6569bbd..79d5cbd65f36 100644
> >> --- a/sound/soc/codecs/sgtl5000.c
> >> +++ b/sound/soc/codecs/sgtl5000.c
> >> @@ -825,6 +825,10 @@ static int ldo_regulator_disable(struct regulator_dev *dev)
> >>  	struct snd_soc_codec *codec = (struct snd_soc_codec *)ldo->codec_data;
> >>  
> 
> Sorry. This part of the patch you sent wasn't included in the
> patch I mentioned above:
> 
> >>  	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> >> +				SGTL5000_LINREG_SIMPLE_POWERUP,
> >> +				SGTL5000_LINREG_SIMPLE_POWERUP);
> >> +
> >> +	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> >>  				SGTL5000_LINEREG_D_POWERUP,
> >>  				0);
> >>  
> 
> In the full patch-set, initialization of ANA_POWER is placed inside
> the sgtl5000_i2c_probe routine and the ldo_regulator is discarded.
> 
> I'm not sure why the code above is needed though.
> 
> Do you know what sequence of events causes this to fail?

All that I remember is that as the mainline code stood in 3.19 etc,
the SGTL5k would be partially detected and then I2C communication
with it was lost.  Probing the pins with a scope showed that it had
basically lost power.

The patch above is over a year old now, and I don't remember much
more detail than that.

I'm not going to be physically in a state where I can look at it for
about a week and a bit, sorry.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

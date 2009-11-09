From: "Wang, Jane" <jwang@ti.com>
Subject: Re: [PATCH]ASoc:ZOOM2:Add support for DSP rendering.
Date: Mon, 9 Nov 2009 11:22:47 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B8D1913@dlee02.ent.ti.com>
References: <1257459691-12411-1-git-send-email-jwang@ti.com>
	<20091106140306.GD10371@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 202C72413B
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 18:22:49 +0100 (CET)
In-Reply-To: <20091106140306.GD10371@rakim.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Friday, November 06, 2009 8:03 AM
> To: Wang, Jane
> Cc: alsa-devel@alsa-project.org; peter.ujfalusi@nokia.com
> Subject: Re: [alsa-devel][PATCH]ASoc:ZOOM2:Add support for DSP rendering.
> 
> On Thu, Nov 05, 2009 at 04:21:31PM -0600, Jane Wang wrote:
> 
> > New mixer controls added to send dapm stream events to power up/down
> TWL4030
> > DAPM widgets along playback and capture paths. In case of DSP rendering,
> > use the corresponding mixer control to power up widgets before stream
> starts
> > and power down the widges after stream stops.
> 
> What does the hardware look like and what is the problem you're trying
> to solve here?  Sending stream events into the core is a definite
> layering violation and is likely to fail with some use case transitions
> but without knowing what the patch is trying to achieve it's hard to
> offer much advice.

The scenario is data is going between DSP<->McBSP<->TWL4030. DSP configures and controls McBSP ports. Since DSP does not have control over TWl4030 codec, the role of ALSA here is providing mixer controls for user space application to configure codec to prepare for DSP rendering.

TWL4030 driver does not provide explicit controls over DAC/ADC, mic bias, APLL, headset pop-noise attenuation etc, and we need these to make playback/capture happen. I can think of two ways to handle this, one is add controls in codec to explicitly control these widgets, or using DAPM stream events as a single control to power up/down the path. And I feel the second solution is cleaner...

> 
> > +static const char *path_control[] = {"Off", "On"};
> 
> > +static const struct soc_enum zoom2_enum[] = {
> > +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(path_control), path_control),
> > +};
> 
> Why is this an enumerated control and not a switch?


I can change this and resubmit the patch.

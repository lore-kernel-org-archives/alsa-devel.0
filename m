From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Fri, 21 Sep 2012 10:23:50 -0600
Message-ID: <505C9496.1050307@wwwdotorg.org>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 35867265DA6
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 18:23:55 +0200 (CEST)
In-Reply-To: <505C68AA.7080907@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 09/21/2012 07:16 AM, Peter Ujfalusi wrote:
> On 09/21/2012 02:13 PM, Mark Brown wrote:
>> On Fri, Sep 21, 2012 at 10:54:26AM +0300, Peter Ujfalusi wrote:
>>> pinctrl framework now becoming widely available for SoCs to configure pin
>>> multiplexing.
>>> Instead of adding the same code to all dai drivers the core can take care
>>> of this transparently.
>>> Do not make too much noise if pinctrl is not provided via DT for the dai
>>> but just use dev_info().
>>
>> Please fix your word wrapping, I've mentioned this to you before...
> 
> I'll reformat it. BTW: The text is edited so it fits in the 'Commit Message'
> part of git gui.
> 
>>> +/*
>>> + * Simple function to be used in snd_soc_dai_register_dai/s to set the default
>>> + * pinmuxing for the dai.
>>
>> I would be more inclined to do this on card init time, doing it at
>> registration seems wrong as systems typically have interfaces that
>> aren't used and share pins with other functions.  By the time we are
>> setting up a card we've got a good idea we actually want to use the IP
>> but at probe time that's not the case.
> 
> Make sense. My first candidate to do this is the soc_probe_link_dais()
> function and to call snd_soc_configure_dai_pins() for both the cpu_dai and
> codec_dai.
> 
>> It also seems bad that we're ignoring errors, does the pinctl API not
>> stub itself out well enough.
> 
> pinctrl_get_select() returns with a pointer to struct pinctrl. If the platform
> does not have CONFIG_PINCTRL enabled it will return with NULL.
> If no pinctrl has been specified for the device it will return with error
> (-ENODEV).
> Neither of these cases should be considered as error. We do print out with
> dev_info() to notify the developer, but having pinctrl mux should not be
> mandatory.

Indeed - what about a platform like Tegra which has pinctrl enabled, yet
doesn't specify any pinctrl configuration for any device other than the
pin controller itself? Do we want to force every device into having to
specify an empty pin control configuration? If we take this route, we
should really have the driver core or platform bus set up the initial
pinctrl state, and I believe that approach was explicitly decided against.

From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/3] ASoC: dio2125: add dio2125 amp driver
Date: Tue, 7 Mar 2017 14:47:54 +0100
Message-ID: <f8d8557b-39bb-265c-9fa7-2034a0364594@metafoo.de>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
 <20170306174451.24406-3-jbrunet@baylibre.com>
 <20170307123653.jg7jqe4sft2pqycc@sirena.org.uk>
 <1488892400.2420.26.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B6676266EEB
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:47:57 +0100 (CET)
In-Reply-To: <1488892400.2420.26.camel@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 03/07/2017 02:13 PM, Jerome Brunet wrote:
> On Tue, 2017-03-07 at 13:36 +0100, Mark Brown wrote:
>> On Mon, Mar 06, 2017 at 06:44:50PM +0100, Jerome Brunet wrote:
>>
>>> +	gpiod_set_value(priv->gpiod_enable, val);
>>
>> You should use gpiod_set_value_cansleep() so that the driver can work
>> with all GPIOs unless there's a specific need to have GPIOs you can
>> control in interrupt (which should be the case for anything you're
>> using
>> for DAPM control).
> 
> Indeed, Thanks for pointing this out.
> I have question regarding this DAPM control.
> Here, I put the control in DAPM so it can help with the pop noise
> reduction, but I think it would be nice if the user could force the
> mute if he wants to.
> 
> Would it be OK to add a user control and some logic so the output is
> enabled only if DAPM and the user agree it should ?

You could put a DAPM switch on the path. This way DAPM will take care of
muting the output if the user toggles the control and other DAPM widgets
connected to the output of the AMP will also be aware that it is off.

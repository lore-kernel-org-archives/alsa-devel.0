From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Fri, 21 Sep 2012 17:55:11 +0300
Message-ID: <505C7FCF.1050509@ti.com>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog128.obsmtp.com (na3sys009aog128.obsmtp.com
 [74.125.149.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 45B44265D73
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 16:54:17 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so3188391obb.38
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 07:54:15 -0700 (PDT)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/21/2012 04:16 PM, Peter Ujfalusi wrote:
>> I would be more inclined to do this on card init time, doing it at
>> registration seems wrong as systems typically have interfaces that
>> aren't used and share pins with other functions.  By the time we are
>> setting up a card we've got a good idea we actually want to use the IP
>> but at probe time that's not the case.
> =

> Make sense. My first candidate to do this is the soc_probe_link_dais()
> function and to call snd_soc_configure_dai_pins() for both the cpu_dai and
> codec_dai.

If we are going to do the pinctrl mux configuration in core we should also
consider the machine driver as well.
But they tend to request the needed GPIOs in their probe before registering
the card.
Same can be true for codec drivers where they might need the mux configured
before they request the GPIOs  they need.

It might be better to leave this to the drivers?

> =

>> It also seems bad that we're ignoring errors, does the pinctl API not
>> stub itself out well enough.
> =

> pinctrl_get_select() returns with a pointer to struct pinctrl. If the pla=
tform
> does not have CONFIG_PINCTRL enabled it will return with NULL.
> If no pinctrl has been specified for the device it will return with error
> (-ENODEV).
> Neither of these cases should be considered as error. We do print out with
> dev_info() to notify the developer, but having pinctrl mux should not be
> mandatory.
> =



-- =

P=E9ter

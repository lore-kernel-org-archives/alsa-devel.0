From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Driver for AK4555 codec
Date: Thu, 29 Jul 2010 19:42:34 +0100
Message-ID: <20100729184233.GA9469@sirena.org.uk>
References: <AANLkTimnYLEe-sK2_DcYQAGqVYd+JnsJaSpRfdKBbeEi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C9201039E2
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 20:42:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimnYLEe-sK2_DcYQAGqVYd+JnsJaSpRfdKBbeEi@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yoran Brondsema <yoran.brondsema@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 29, 2010 at 09:18:43AM +0200, Yoran Brondsema wrote:

> There is a driver available for the LPC3250 but none for the AK4555 codec,
> so I have to write it myself. I checked the document "Writing an ALSA
> Driver" by Takashi Iwai but it seems to focus on full-featured sound cards;
> I'm just dealing with a "simple" codec. I checked at the code of the uda1380
> in linux/sound/soc/lpc3xxx/lpc3xxx-uda1380.c and it seems to be calling some
> functions like platform_device_alloc, platform_set_drvdata,... but I can't
> find the documentation of what these functions do.

> Can someone give me some pointers to some documentation or some rough idea
> of how it needs to be done?

The documentation for ASoC is in:

	Documentation/sound/alsa/soc

which should give you a reasonable structural overview of things.

Probably the easiest thing for you to do is to clone the driver for a
simple I2C controlled CODEC such as the WM8523 and then replace all the
specifics of the register access with those for your CODEC.

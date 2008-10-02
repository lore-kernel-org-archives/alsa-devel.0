From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH] Add AC'97 driver for AT91SAM9263ek atmel
 board.
Date: Thu, 02 Oct 2008 11:45:54 +0200
Message-ID: <48E49852.2010504@atmel.com>
References: <48E3A42C.6090202@atmel.com> <48E48B76.1050809@atmel.com>
	<s5h4p3vicaz.wl%tiwai@suse.de>
	<20081002092430.GB2848@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 02E9A244C6
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 11:45:57 +0200 (CEST)
In-Reply-To: <20081002092430.GB2848@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
Mark Brown a =E9crit :
> On Thu, Oct 02, 2008 at 11:19:48AM +0200, Takashi Iwai wrote:
>> Sedji Gaouaou wrote:
>>> Sedji Gaouaou a ?crit :
> =

>>> When I was writing this patch I was wondering if it should actually be =

>>> in the sound/arm directory or in a sound/soc/atmel directory?
> =

>> sound/arm looks correct unless the driver is based on the ASoC
>> framework.
> =

> Indeed.
> =

> If you look at pxa2xx-ac97 you'll see that for that there's actually two
> drivers (both of which now share most of the actual hardware access code
> thanks to some good work by Dmitry Baryshkov), one for the non-ASoC AC97
> framework and one for use within ASoC.  Both can be useful, though the
> ASoC one is only useful if people design boards which can make use of
> the extra features it provides.
> =

Should I provide the same thing?
This driver is not based on the ASoC.
Nevertheless I can see that there is a ac97 driver in sound/soc/codec, =

so should I do the same as pxa, I mean create 2 drivers?

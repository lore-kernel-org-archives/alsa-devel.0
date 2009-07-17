From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Add possibility to control the GPIO_STATUS shift
Date: Fri, 17 Jul 2009 13:11:59 +0100
Message-ID: <20090717121159.GA20904@rakim.wolfsonmicro.main>
References: <200907171001.16889.marek.vasut@gmail.com>
 <200907171326.08512.marek.vasut@gmail.com>
 <20090717114312.GA20492@rakim.wolfsonmicro.main>
 <200907171353.59356.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200907171353.59356.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org, alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2009 at 01:53:59PM +0200, Marek Vasut wrote:
> Dne P=C3=A1 17. =C4=8Dervence 2009 13:43:12 Mark Brown napsal(a):

> > The same way your current patch does it.  I'm just saying you shoul=
d
> > change the way the configuration is passed in so that it is clear t=
hat
> > this is only useful for WM1613.

> But there might appear some other chips that have this issue.

Then they can get handled the same way - it might be an idea to have th=
e
data that's passed in be a chip number to allow for this.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cmi8330: add OPL3 support
Date: Wed, 21 Jan 2009 10:43:20 +0100
Message-ID: <20090121104320.4bfe9db6.krzysztof.h1@poczta.fm>
References: <20090121081816.b3d1246b.krzysztof.h1@poczta.fm>
	<4976D3A2.70608@ladisch.de> <s5hljt52iqo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 05E541037E3
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 10:40:25 +0100 (CET)
In-Reply-To: <s5hljt52iqo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Jan 2009 08:58:23 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 21 Jan 2009 08:49:54 +0100,
> Clemens Ladisch wrote:
> > 
> > Krzysztof Helt wrote:
> > > +		err = snd_opl3_timer_new(opl3, 0, 1);
> > > +		if (err < 0)
> > > +			return err;
> > 
> > Does this chip really have a working timer implementation?
> > (There is a timer test program in alsa-lib/test/.)
> 
> A good question.  Krzysztof, could you check alsa-lib/test/timer
> program?  First run "./timer list" and then run like
> 	./timer class 1 card 0 device 2
> or so...
> 
> BTW, your patches were already applied now, so please send fixes as
> additional patches if any.
> 
> 

The test returns: "Timer time out!!". However, it returns the same
for the SC-6000 board which has the Yamaha YMF 262-M chip which is 
supposed to have the Adlib timers.

Regards,
Krzysztof

-----------------------------------------------------------------------
Promocja w Speak Up. Kwartal angielskiego za darmo. 
3 miesiace nauki gratis. Sprawdz teraz! >> http://link.interia.pl/f2019

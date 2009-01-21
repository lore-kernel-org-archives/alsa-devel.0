From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cmi8330: add OPL3 support
Date: Wed, 21 Jan 2009 12:49:16 +0100
Message-ID: <20090121124916.5260bde3.krzysztof.h1@poczta.fm>
References: <20090121081816.b3d1246b.krzysztof.h1@poczta.fm>
	<4976D3A2.70608@ladisch.de> <s5hljt52iqo.wl%tiwai@suse.de>
	<20090121104320.4bfe9db6.krzysztof.h1@poczta.fm>
	<497703AF.7000703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id C193B24362
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 12:46:17 +0100 (CET)
In-Reply-To: <497703AF.7000703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Jan 2009 12:14:55 +0100
Clemens Ladisch <clemens@ladisch.de> wrote:

> Krzysztof Helt wrote:
> > The test returns: "Timer time out!!". However, it returns the same
> > for the SC-6000 board which has the Yamaha YMF 262-M chip which is
> > supposed to have the Adlib timers.
> 
> Then that chip does not forward the timer interrupt to the computer,
> and its driver should not create a timer device either.
> 

I checked the status word and it changed after the timeout elapsed.

However, the IRQ is not forwarded as you wrote. The same seems true
for more drivers and they should be checked:

ad1816a
als100
azt2320
dt019x
opti92x-ad1848
sc6000

All of them create the OPL3 timers but none of them
calls the snd_opl3_interrupt (do acknowledge timer
interrupt). The only driver which does it is the opl3sa2.

I will test the ad1816a, opti93x and the sc6000. If the
interrupt is not received I will prepare patches to
remove the OPL3 timers.

Regards,
Krzysztof

-----------------------------------------------------------------------
Promocja w Speak Up. Kwartal angielskiego za darmo. 
3 miesiace nauki gratis. Sprawdz teraz! >> http://link.interia.pl/f2019

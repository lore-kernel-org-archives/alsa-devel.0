From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Terratec EWS88D (ice1712) optical stuck on ADAT
	(no IEC958 optical i/o)
Date: Mon, 13 Sep 2010 21:35:26 +0100
Message-ID: <201009132135.26733.gineera@aspect135.co.uk>
References: <AANLkTik7=sY9VJ2QX9j=W4+qH5s6SfBKi-LGG2WeF3x1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net
	[62.24.128.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 83AF610384E
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 22:35:29 +0200 (CEST)
In-Reply-To: <AANLkTik7=sY9VJ2QX9j=W4+qH5s6SfBKi-LGG2WeF3x1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Mayer <nielsmayer@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 13 September 2010 16:55, Niels Mayer wrote:
> I just scored a nice Terratec EWS88D for $20.00. :-)  (
> http://nielsmayer.com/envy24control/EWS88D_Board_L.jpg missing midi cable
> though (*))
> It works nicely with Linux and http://mudita24.googlecode.com ,  although
> it's missing some important controls to turn off the ADAT parts of the
> card. Alas, it wouldn't help to support them in mudita24, as I cannot get
> them to change values through standard ALSA tools like amixer(1) and
> alsamixer(1).
>
> Therefore, the question: is what is it about snd-ice1712 that prevents the
> mixer control values detailed below from changing, and is there anything I
> can do to fix it? (sometimes you want to use this card in it's dual IEC958
> optical + spdif I/O config, other times, you want to use the optical for
> ADAT and the spdif for IEC958, which is the only configuration I can get
> currently.)
>
> The results from amixer(1):
>   http://nielsmayer.com/envy24control/terratec-ews88d-amixer.txt
> Results of "cat /proc/asound/EWS88D/ice1712":
>   http://nielsmayer.com/envy24control/terratec-ews88d-ice1712.txt
>
> My attempts at changing optical port from ADAT to IEC958. Nothing happens:

<snip>

May be helpful to use alsamixer (command-line pseudo graphical) - that should 
present all the controls the driver provides.  Certainly I found that to be 
the most useful way of understanding/operating the underlying controls.  
(Which envy24control etc operate on top of).

I am fairly sure that the ice1712 driver has no run-time mechanism for 
enabling/disabling the paired digital streams that are ADAT on EWS88D, and go 
to/from the AK4524 codecs on most other versions.  With the DMX6fire, which 
normally has 3-pairs, I added a different register value used at start-up so 
that 2 channel are not active (and picking up 'static' noise), but the other 
ice1712's enable all 4 pairs always.

It is possible that the functions and controls have been coded from 
data-sheets and never debugged on real hardware, or at least not in every 
respect.  Perhaps others may know?

Hope this helps,

Alan

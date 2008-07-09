From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Add initial support of Mitac mioa701
	device SoC.
Date: Wed, 09 Jul 2008 20:09:35 +0200
Message-ID: <87wsjvj5eo.fsf@free.fr>
References: <87vdzgp0ue.fsf@free.fr>
	<1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
	<1215601156.4882.256.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BD8E24499
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 20:09:36 +0200 (CEST)
In-Reply-To: <1215601156.4882.256.camel@localhost.localdomain> (Liam
	Girdwood's message of "Wed\, 09 Jul 2008 11\:59\:16 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Liam Girdwood <liam.girdwood@wolfsonmicro.com> writes:

> I've committed both to git now. We can upstream when the dependencies
> are committed. Just some minor comments below.
Ah. So, how should I provide the corrections :
 - with another full patch ?
 - a differential patch to the previous one ?

> Fwiw, there is a thermal IRQ on the WM9713 and you may want to use it
> for monitoring this. However it only interrupts at 150C so it may be a
> little high for this purpose.
Well, I compared the temperature to my frying pan. The pan is hotter, so I
assume the heat dissipated raises the temperature to about 70 degrees Celsius.

> This is still pending atm.
No problem, I'm very patient.

> If it depends on mode then have a look at the scenario/use case/mode
> manager for ALSA :-
OK. Will look.

>
> This could be shortened to :-
>
> return rear_amp_power(codec, SND_SOC_DAPM_EVENT_ON(event));
>
Absolutely.

>> +static void mioa701_wm9713_exit(struct snd_soc_card *card)
>> +{
>
> I assume this will never be called in real life phone usage. If it is
> you could optionally shutdown/slow down the AC97 link to save power.
Yes, it's never called, unless build as module, and then it makes sense. I'll
post an update for this.

--
Robert

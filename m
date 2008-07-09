From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Add initial support of Mitac mioa701
	device SoC.
Date: Wed, 09 Jul 2008 21:36:41 +0200
Message-ID: <87skuihmt2.fsf@free.fr>
References: <87vdzgp0ue.fsf@free.fr>
	<1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
	<1215601156.4882.256.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id B556B103801
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 21:36:42 +0200 (CEST)
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

>> +static void mioa701_wm9713_exit(struct snd_soc_card *card)
>> +{
>
> I assume this will never be called in real life phone usage. If it is
> you could optionally shutdown/slow down the AC97 link to save power.
After a second thought, I don't think I can. The AC97 link is needed to for the
touchscreen and battery level calculation (ADC1). So I don't think we can
shutdown the link.

Perhaps we could slow it down, but is there a way to _not_ disturb
wm97xx_touchscreen drivers ?

--
Robert

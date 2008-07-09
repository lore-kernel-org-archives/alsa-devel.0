From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Add initial support of Mitac mioa701
	device SoC.
Date: Wed, 09 Jul 2008 23:34:02 +0200
Message-ID: <87d4lmg2t1.fsf@free.fr>
References: <87vdzgp0ue.fsf@free.fr>
	<1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
	<1215601156.4882.256.camel@localhost.localdomain>
	<87skuihmt2.fsf@free.fr>
	<20080709203008.GA19229@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 90C17244E0
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 23:34:04 +0200 (CEST)
In-Reply-To: <20080709203008.GA19229@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Wed\, 9 Jul 2008 21\:30\:09 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Wed, Jul 09, 2008 at 09:36:41PM +0200, Robert Jarzmik wrote:
>
>> After a second thought, I don't think I can. The AC97 link is needed to for the
>> touchscreen and battery level calculation (ADC1). So I don't think we can
>> shutdown the link.
>
> Have you checked that this currently works?  The AC97 bus should be
> unregistered when the audio device is unregistered.  I have to confess
> that I haven't tested this in v2 but it is the intended behaviour - the
> AC97 controller is provided by the ASoC drivers so when it is stopped
> the link should be unregistered.
No. And yes, just checked. You're right, once snd-soc-mioa701 is removed,
touchscreen and battery don't exist anymore (input device gone, etc ...).
So I could/will shutdown the link.

--
Robert

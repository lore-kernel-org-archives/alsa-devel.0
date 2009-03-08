From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Sun, 08 Mar 2009 19:59:38 +0100
Message-ID: <87bpsb6dt1.fsf@free.fr>
References: <87iqn6f97x.fsf@free.fr>
	<4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 22EEB1037F9
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 19:59:44 +0100 (CET)
In-Reply-To: <4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk> (Mark
	Brown's message of "Thu\, 19 Feb 2009 21\:21\:59 +0000")
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On 19 Feb 2009, at 20:44, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> Hi Mark,
>>
>> I can't find out if somebody had submitted that kind of patch  before. This is
>> a
>> starting point of discussion. I'm not fully convinced by my own  code, and so
>> I
>> post it here for advice.
>>
>> What I'd really like is to be able to choose the PXA AC97 gpio reset  (GPIO95
>> or
>> GPIO113) through platform_data, but I couldn't find a way of doing  it. I hope
>> you'll have some kind of idea.
>
> This is a sensible idea in principle but should be done via platform  data for
> the AC97 driver rather than via Kconfig - it'll need an  update to use the
> platform in ASoC but I'll need to do those anyway.

Would you like me to help you with this platform data. This GPIO thing is
breaking mioa701 GSM chip (not damaging this time :)), so would you like me to
cook up the platform data passed to pxa2xx-ac97, and amend my patch accordingly
?

Or have you already coded the beast in your working repository ?

Cheers.

--
Robert

PS: passing that platform data is easy, I should have done it right from the
start. I can't see how I missed the simple platform_data in pxa2xx_ac97 probe
function ... grrr... Must be the belgian food I tried.

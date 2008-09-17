From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: ALSA:AT91SAM9G20: Add support(DAI) for wolfson8731
Date: Wed, 17 Sep 2008 17:23:20 +0200
Message-ID: <48D120E8.4060504@atmel.com>
References: <48D0D30D.7070807@atmel.com> <20080917110530.GA7679@sirena.org.uk>
	<48D11D0E.90701@endrelia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id D4F8524654
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 17:23:40 +0200 (CEST)
In-Reply-To: <48D11D0E.90701@endrelia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frank Mandarino <fmandarino@endrelia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi Frank,
Frank Mandarino a =E9crit :
> Mark Brown wrote:
> =

>> The only major issue I see with the patch is a documentation one: it's
>> not clear to me reading the code how the atmel_ssc DAI driver relates to
>> the existing at91_ssc driver.  It may be that this is something that's
>> obvious to someone familiar with the at91 hardware but just looking at
>> the code it's not clear to me what the difference is between the two and
>> when each should be used.  =

>>
>> Looking at the code they appear to be similar to the point where they
>> should be the same driver but it's entirely possible that I'm missing
>> something here.  I've CCed in Frank Mandarino who did the existing AT91
>> support.  If they should be separate drivers then some comments should
>> be added in the driver and the Kconfig help text explaning the
>> situation.
> =

> I agree that the drivers should be combined.  Unfortunately, at this
> time I am unable to contribute to this effort.
> =

I agree with you as well. I wanted to use the drivers/misc/atmel-ssc in =

the dai because it is a common arch between atmel ARM and AVR core.
I will have a look at the at91-ssc code and at the eti_b1_wm8731.c file =

to see what changes should be done.
> =

>>> +		start_event =3D channels =3D=3D 1
>>> +				? 4
>>> +				: 7;
>> This would be much clearer if it were expanded into multiple statements.
> =

> This was a little clearer in at91-ssc.c:
> =

>                 start_event =3D channels =3D=3D 1
>                                 ? AT91_SSC_START_FALLING_RF
>                                 : AT91_SSC_START_EDGE_RF;
> =

> Perhaps these constant definitions are no longer available it the latest
> kernel.  Are there updated definitions to use instead of magic numbers?

My mistake, I will use your constant def.
> =

>>> +#ifdef CONFIG_PM
>>> +#define atmel_ssc_suspend	NULL
>>> +#define atmel_ssc_resume	NULL
>>> +#else
>>> +#define atmel_ssc_suspend	NULL
>>> +#define atmel_ssc_resume	NULL
>>> +#endif
>> These may as well be removed - if someone implements suspend/resume
>> support they can add them then then.
> =

> Is there a reason that suspend/resume was removed?  It is really
> important for embedded systems.
I removed resume/suspend because I didn't have the time to write it...
I wanted to add it in a next patch, but maybe I shoul do it now.

Mark, concerning your other comments I am working on it.
I will send another patch as soon as it is finished.

Regards,
Sedji

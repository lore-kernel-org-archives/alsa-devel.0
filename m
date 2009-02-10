From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Re: Juli@ ICE1724 and 24 bit audio
Date: Tue, 10 Feb 2009 08:21:16 -0800
Message-ID: <55308455CD2246E39D1A3CE0A73423FC@PDSDesktop>
References: <366C228A7F9A4AAF9EE7190DC4C0EE68@PDSDesktop>	<49909186.4050902@insite.cz>	<67FF030CD7BA4BFB9ACE52B69F56D69D@DemianM1330>	<fd3eb9bf0902091338i7ffa51d6t5a62d82a6b48ada3@mail.gmail.com>	<47A687F571094A7F827250BBE602F100@DemianM1330>
	<fd3eb9bf0902100333m7ab4edc1g99de11000a794245@mail.gmail.com>
	<49919EA2.6030000@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp104.prem.mail.sp1.yahoo.com
	(smtp104.prem.mail.sp1.yahoo.com [98.136.44.59])
	by alsa0.perex.cz (Postfix) with SMTP id 69ADA10384B
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 17:21:27 +0100 (CET)
In-Reply-To: <49919EA2.6030000@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Pavel Hofman' <pavel.hofman@insite.cz>, =?iso-8859-2?Q?'Vedran_Mileti=E6'?= <rivanvx@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now I'm more confused. I'll try the experiments today and report on what I
find. If plughw with aplay works and xine doesn't that will explain a lot.

I should have some good experimental answers in a few hours.

Demian Martin
Product Design Services


-----Original Message-----
From: Pavel Hofman [mailto:pavel.hofman@insite.cz] =

Sent: Tuesday, February 10, 2009 7:35 AM
To: Vedran Mileti=E6
Cc: Demian Martin; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Juli@ ICE1724 and 24 bit audio

Vedran Mileti=E6 wrote:
> Yeah, ALSA's documentation is actually quite lacking on many fronts
> and is mostly scattered around various wikis and mailing lists.
> =

> But I guess it is as it is, complaining about it won't fix it.
> =

> On 2/9/09, Demian Martin <demianm_1@yahoo.com> wrote:
>> Thanks, I'll try that. I guess this e-mail will serve as more
documentation
>> on that feature (bug). I had not seen that factoid anywhere.
>>
>> Demian Martin
>> PDS
>>
>>

What makes you guys think the plug plugin trims the data down to 16bits? =

  Sure if the rate is changed (the source code suggests only the =

low-quality linear rate algorithm supports above-16bit format - =

operation convert, the other resampling algorithms convert using the =

operation convert_s16).

Ice1724 supports all the general rates natively, the rate conversion in =

the plug plugin should not kick in for common audio formats. The only =

case I can think of would be switching Juli to external SPDIF-IN clock - =

the hw.rate_min =3D hw.rate_max =3D actual_rate and the automatic rate =

conversion could happen.

I did not use the hw device in my tests since all the tested tracks =

would have to be 32-bit for the hw device to accept the format when =

played via my favorite aplay.

My 2 cents guess is xine does the conversion.

Regards,

Pavel.

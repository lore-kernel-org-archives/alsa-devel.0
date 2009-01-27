From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 20:49:01 +0100
Message-ID: <74d0deb30901271149g40ac1842wfc28828377c27794@mail.gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200901271749.38788.anarsoul@gmail.com>
	<74d0deb30901270806s166f5336g3086e42477913e1d@mail.gmail.com>
	<200901271822.32537.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B9E424389
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 20:49:02 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so2639330ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 11:49:01 -0800 (PST)
In-Reply-To: <200901271822.32537.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 5:22 PM, Vasily Khoruzhick <anarsoul@gmail.com> wro=
te:
> On Tuesday 27 January 2009 18:06:47 pHilipp Zabel wrote:
>
>> Could you show the code?
>> On magician I'm just powering up uda1380 when the driver is loaded,
>> but I wouldn't mind saving some power :)
>> There are two GPIOs involved - one connected to the uda1380's RESET
>> line and one to control the power.
>> The last one doesn't have anything to do with uda1380, really. It's an
>> external power switch in a PMIC (or CPLD, on magican) so it would be
>> nice if this code could live in the machine specific drivers.
>>
>> regards
>> Philipp
>
> Yep, of course, here's machine driver (originally created by Denis Grigor=
iev)
> and modified codec driver.
>
> Btw, on rx1950 there're 4 gpio pins involved:
> GPJ0 controls codec power
> GPA1 controls amplifier power
> GPG12 is jack sense pin, it's value depends whether headphone jack is ins=
erted
> or not,
> and GPD0 is connected to uda1380 reset.

The uda1380 data sheet says that the reset time should be at least 1
=B5s - could that be a problem?

regards
Philipp

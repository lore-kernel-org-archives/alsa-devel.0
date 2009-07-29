From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Re: Master channel is only mono
Date: Wed, 29 Jul 2009 18:12:27 +0200
Message-ID: <4A7074EB.3070908@molgaard.org>
References: <4A7066BF.9000603@molgaard.org> <s5hbpn3biyn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.nfit.au.dk (nfitmail.nfit.au.dk [130.225.31.129])
	by alsa0.perex.cz (Postfix) with ESMTP id F0BF6103895
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 18:12:35 +0200 (CEST)
In-Reply-To: <s5hbpn3biyn.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 29 Jul 2009 17:11:59 +0200,
> Sune M=F8lgaard wrote:
>>
>> As per gnubien's advice on #alsa on irc.freenode.net, I have run
>> alsa-info.sh - the URL is
>> http://www.alsa-project.org/db/?f=3Dfbe93f301ca214007e66c521cd6c41a17a60=
4c79 .
>
> Better to run alsa-info.sh with --no-upload and attach it instead
> of URL.

Sorry about that. I was instructed otherwise...

>> My problem is that the master channel for my card is shown to be mono
>> only, which I don't think seems right...
>
> Mono is correct.
> You have other mixer elements for left/right volume balance.

Could you recommend to me a mixer program that can access them, then? =

alsamixer only shows Master, Headphone, Headphone 1, PCM, Digital Input =

Source [Digital Mic 1], Digital Input Source 1 [Analog Inputs] and Speaker.

Same goes for the gnome mixer with all inputs selected...

>> Also, sound in general is rather low.
>
> I guess you didn't raise headphone and speaker volumes.

Nope, Master, Speaker, and PCM are at max.

>
> HTH,
>
> Takashi

Thank you for your input, but it would seem that I still need some advice...

Best regards,

Sune

From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Tue, 23 Jun 2009 22:00:42 -0300
Message-ID: <d54969c50906231800p2f507c48h9e6977cc7d03461f@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<1245707939.441.5.camel@localhost> <s5hfxdrex0w.wl%tiwai@suse.de>
	<1245709097.441.7.camel@localhost> <1245710676.441.9.camel@localhost>
	<d54969c50906221614k5e12f5edt8973f7bb8e69592c@mail.gmail.com>
	<1245712854.441.11.camel@localhost>
	<d54969c50906221623j4fd17c6yb7fc2c9316d11766@mail.gmail.com>
	<d54969c50906231105k251880eahbf82cf74b699c7d8@mail.gmail.com>
	<1245796809.3640.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id E6A4C245F3
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 03:00:43 +0200 (CEST)
Received: by qyk1 with SMTP id 1so602975qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2009 18:00:42 -0700 (PDT)
In-Reply-To: <1245796809.3640.10.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Vroon <tony@linx.net>
Cc: Takashi Iwai <tiwai@suse.de>, Karthik Ramgopal <applefreakpeeps@gmail.com>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2009/6/23 Tony Vroon <tony@linx.net>:
> On Tue, 2009-06-23 at 15:05 -0300, Emilio L=F3pez wrote:
>> I had a little free time, so I decided to play a little with alsa. I
>> copied the mic verbs from the old model to this new one and it seems
>> to be working fine. Here is the patch for that
>
> Takashi, please feel free to apply this. Especially the PIN_IN selector
> is obviously correct, and if this fixes the 6935 it should work on the
> 6930.
> Unfortunately the 6930 (which isn't mine) will be out of the country as
> of tomorrow.
>
> Emilio, you may want to resubmit with a Signed-Off-By line etc. There's
> a Documentation/SubmittingPatches in the kernel source that explains all
> the little details.

I can't seem to find it on the alsa sources. Is it online somewhere?

>
>> Now, the only 'broken' thing is jack sensing, it just mutes front, but
>> not LFE. I guess this is an easy to fix issue.
>
> Now that you've got your hands dirty you might want to fix that one as
> well :)

OK :-)

> You'll want to mute/unmute node 0x17 (the "tuba") in addition to 0x14 in
> the jack sense handler. Might as well handle 0x16 now that you're at it,
> the codec graph suggests this is a speaker of some kind as well. Copy
> alc888_acer_aspire_4930g_init_hook into a new 6930g_init_hook, and look
> at 8930g to see how to do multiple speaker nodes.

I did it, but it still doesn't work. I'll play a bit more with it
tomorrow, might be a stupid error of mine.

>
> That's basically it. Hacking on patch_realtek.c is quite doable.
>
>> Emilio
>
> Regards,
> Tony V.
>

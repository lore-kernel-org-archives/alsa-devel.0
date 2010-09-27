From: Reimundo Heluani <rheluani@gmail.com>
Subject: Re: mic on macbook air
Date: Mon, 27 Sep 2010 14:47:35 -0300
Message-ID: <AANLkTi=1KbpHrTC9oNL2PPL5yTOOVbqKunVY8h-Tgf1b@mail.gmail.com>
References: <1285540323.2205.11.camel@vino> <s5hvd5rxncg.wl%tiwai@suse.de>
	<4CA0C81E.5030103@gmail.com>
	<AANLkTikbkubbhOnc0hCRmWRv5H6vqQTRjE6afmmJ48t=@mail.gmail.com>
	<4CA0D537.1000209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E765243E2
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 19:47:36 +0200 (CEST)
Received: by iwn4 with SMTP id 4so44019iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2010 10:47:35 -0700 (PDT)
In-Reply-To: <4CA0D537.1000209@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 27, 2010 at 2:32 PM, Justin P. Mattock
<justinmattock@gmail.com> wrote:
> On 09/27/2010 09:40 AM, Reimundo Heluani wrote:
>>
>> As far as I know I wrote the only patch for macbook air 2,1 that
>> shipped with 2.6.34 but that was for the internal speaker only. I
>> could never get the mic going.
>>
>> Cheers,
>>
>> R.
>
> when doing a cat codec#0 | grep Pin on my iMac9,1
> I can see:
>
> Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
> =A0Pincap 0x0000373c: IN OUT HP Detect
> =A0Pin Default 0x90a00110: [Fixed] Mic at Int N/A
> =A0Pin-ctls: 0x24: IN VREF_80
>
> when doing the same for the mba1,1 I didn't see anything in there that sa=
id
> Mic.. I'm wondering if the Mic is there, it's just not being shown when
> doing cat codec#0 due to apple changing something with the hardware. did =
you
> try different pin numbers?(even though none of the pins say Mic)
>
> Justin P. Mattock
>

Well, here it could just be my ignorance, but I think last year when I
was trying, I tried all possible pins and didn't find the mic
anywhere. Then I thought that it could be some vendor parameters on
0x20, but then I saw the plist file in the kext and the only thing
they adjust is the pindefault to 0x90a00110: [Fixed] Mic at Int N/A on
what it seems to be either pin 0x1c (which I tried) or 0x27 (which is
nonexistent). There's a thread at the ubuntu forums with people
running alsa on air 2,1 but I couldn't get anyone to play with
hda-verb.

Cheers,

R.

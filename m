From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC: WM9712 Codec: Workaround an unmute
	problem (Was: Re: [PATCH] ASoC: MPC5200: Support for buffer
	wrap around)
Date: Wed, 5 Aug 2009 13:16:01 -0400
Message-ID: <9e4733910908051016m49251075gca103c28f8a9a579@mail.gmail.com>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker> <20090802114950.GA1778@sirena.org.uk>
	<1249489853.4582.58.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BB88244E3
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 19:16:02 +0200 (CEST)
Received: by qyk15 with SMTP id 15so220626qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 10:16:01 -0700 (PDT)
In-Reply-To: <1249489853.4582.58.camel@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 5, 2009 at 12:30 PM, John Bonesio<bones@secretlab.ca> wrote:
> Hi Mark,
>
> I've retitled the email to better reflect the real patch. I believe
> there has been some general confusion because I originally sent the
> wrong patch.
>
> You wrote:
>
>> Like I said before, exactly which control are you adjusting here?
>>
> My description of this got lost in all the confusion. Let me try again.
> We are adjusting the mixer bits for mute/unmute on two of the mixer
> settings. The first one is general headphone mute setting on register
> 0x4 (bit 15). The second one is the PCM mute setting on register 0x18
> (bit 15).
>
> What we are seeing is that if we first unmute the general headphone (reg
> 0x4 bit15), then unmute the PCM (reg 0x18 bit 15) [HPL PCM in the
> alsamixer application], the general headphone gets muted again, even
> though software didn't write to that register.
>
>>
>> > If there is code in software doing this, it's very subtle.
>>
>> My money would be on the AC97 controller having problems; the quality of
>> SoC AC97 controllers is variable. =A0It certainly doesn't sound like a
>> WM9712 issue; as I say I'd be very surprised if such an issue hadn't
>> come up before given how widely deployed the part is.
>
> We don't have access to an AC97 analyzer. Do you have any suggestions on
> other ways we can pinpoint the error?

Do you have a normal logic analyzer? You can decode the AC97 by hand,
its only a couple of frames.

-- =

Jon Smirl
jonsmirl@gmail.com

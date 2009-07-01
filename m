From: =?ISO-8859-1?Q?St=E9phane_BERTHELOT?= <sberthelot@emisfr.com>
Subject: Re: MCP7A HDMI passthrough audio Linux/ALSA
Date: Wed, 01 Jul 2009 11:18:15 +0200
Message-ID: <4A4B29D7.5070805@emisfr.com>
References: <4A4A01CF.9090203@emisfr.com>	<s5hocs598yz.wl%tiwai@suse.de>	<4A4A0D45.7030501@emisfr.com>	<s5hhbxx98d4.wl%tiwai@suse.de>	<4A4A7AB7.6050103@emisfr.com>
	<s5hr5x1apu9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smith2.emisfr.net (smith2.emisfr.net [88.191.81.87])
	by alsa0.perex.cz (Postfix) with ESMTP id AD79624650
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 11:18:16 +0200 (CEST)
In-Reply-To: <s5hr5x1apu9.wl%tiwai@suse.de>
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
Cc: wni@nvidia.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai a =E9crit :
> At Tue, 30 Jun 2009 22:51:03 +0200,
> Stephane BERTHELOT wrote:
>   =

>
> Hm, so apparently your TV doesn't accept non-audio format?
> But TV accepted the ac3dec output with -R option, right?
> (Make sure this -- otherwise ac3dec might have decoded by itself.)
>
> Basically, -R means to send the encoded an AC3 stream (packed in the
> SPDIF format) without setting non-audio bit.  Whether non-audio bit is
> 1 or 0 is the only difference between -C and -R.  So, if -R really
> works but not -C, it means that the non-audio bit must be off no
> matter what you send.  Weird.
>
>   =

I'm sure the TV only accepted -R and not -C (or -P) with the same ac3 file.
But I'm confused since I was quite sure -R would *decode* ac3 to PCM and =

then send it in LPCM format.
I used alsa-tools 1.0.20, should I try with a Git version ?
Sorry to ask this, but are you sure the data is sent as-is (in ac3 =

format) with only audio bit changed ?
It sounds effectively completely weird to me, because moreover my Amp is =

showing LPCM format with -R (my TV would downsample the 5.1 AC3 signal =

to LPCM ??)
>> I may try again on XP/Vista tomorrow to be really sure it works on them.
>>
>> When changing play mode AES0 changes from 0x00 to 0x02 and AES1 to AES3 =
stay
>> the same (0x82,0x00,0x02 if I remember well)
>>     =

>
> Note that the setup you made before ac3dec will be overridden anyway.
> And during ac3dec playback, the status bits are locked and can't be
> changed by others.
>
>   =

Ok that's what I thought since ac3dec show AES bytes and they depend =

only on command line options and not iecset done before.
> Takashi
>
>
>   =

Stephane.

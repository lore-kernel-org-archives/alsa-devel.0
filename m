From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: Strange behaviour in snd-usb-cayak with Audio4DJ
Date: Tue, 16 Feb 2010 17:10:37 +0000
Message-ID: <74fd948d1002160910g12141190k8f8a87b69fda85f1@mail.gmail.com>
References: <74fd948d1002160835j3df4a44sbfa3d3fdaabfdb60@mail.gmail.com>
	<20100216164443.GY9007@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AA2F243C0
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 18:10:39 +0100 (CET)
Received: by ewy23 with SMTP id 23so775450ewy.4
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 09:10:38 -0800 (PST)
In-Reply-To: <20100216164443.GY9007@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 16 February 2010 16:44, Daniel Mack <daniel@caiaq.de> wrote:
> Hi,
>
> On Tue, Feb 16, 2010 at 04:35:29PM +0000, Pedro Ribeiro wrote:
>> ALSA information script output is here
>> http://www.alsa-project.org/db/?f=3Dfe4cc3eda2df49c6055f55d4cef935524124=
d1a1
>> and my .asoundrc is here =A0http://pastebin.com/m3f70572d
>>
>> Currently my .asoundrc has 4 devices:
>> - Audio4DJ_A (combines channels 1 and 2)
>> - Audio4DJ_B (combines channels 3 and 4)
>> - Audio4DJ (combines Audio4DJ_A and Audio4DJ_B)
>> - ttable is a device for JACK according to this
>> http://alsa-project.org/main/index.php/Asoundrc#Virtual_multi_channel_de=
vices
>>
>> My goal is to have a separate ALSA soundcard for each pair of
>> channels, an ALSA soundcard for 4 channels and a JACK device for all 4
>> channels.
>>
>> Running speaker-test -c2 -D plughw:Audio4DJ,0,X -twav -l1
>> with X=3D0 and X=3D1 correctly outputs to each channel. Also,
>> pcm.Audio4DJ_A and pcm.Audio4DJ_B correctly work through both ALSA and
>> JACK for each pair of channels.
>>
>> However, if I try to use the pcm.Audio4DJ (which combines both
>> pcm.Audio4DJ_A and pcm.Audio4DJ_B), I get correct output through
>> channels 1 and 2, but channels 3 and 4 have a lot of garbage - you can
>> hear the track playing but it is at a very high pitch and distorted.
>
> Could you first try to playback audio without all your quirks using the
> following commands, please.
>
> For channel 1&2: aplay -D plughw:Audio4DJ,0,0 test.wav
> For channel 3&4: aplay -D plughw:Audio4DJ,0,1 test.wav
>
> If that works, we can exclude driver issues. I'm very confident that
> will work btw, as this is the way I tested the driver.
>
> I admittedly have no clue about JACK ;)
>
> Daniel
>
>

Thank you for the quick reply!

it works perfectly! I have no clue why the combined device produces
such garbage when playing on channels 3 and 4.

Pedro

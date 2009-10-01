From: Arjun Sambamoorthy <arjunsam@gmail.com>
Subject: Re: Help! Playing multiple audio stream using alsa
	libraries
Date: Thu, 1 Oct 2009 18:00:23 -0500
Message-ID: <19a7f99e0910011600x73cff9fcg37db4dab289467e4@mail.gmail.com>
References: <19a7f99e0910011122r22584b6k9fe8faa4aa064d1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id BE39F103814
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 01:00:27 +0200 (CEST)
Received: by ewy25 with SMTP id 25so734652ewy.45
	for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2009 16:00:26 -0700 (PDT)
In-Reply-To: <19a7f99e0910011122r22584b6k9fe8faa4aa064d1b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello guys,

I had to mix the two streams before playing it. Thanks anyways.

Arjunen

On Thu, Oct 1, 2009 at 1:22 PM, Arjun Sambamoorthy <arjunsam@gmail.com> wro=
te:
> Hello all,
>
> I am trying to play two audio streams using alsa libraries at the same
> time, but I am not able to do so. I could play a single audio stream
> though.
> I get bi-directional G711 MU Law RTP streams and I am using the sample
> playback capture code from the tutorial section for playing it. I am
> using the Non blocking and interleaved mode for playing the streams.
>
> The alsa library plays both the audio streams for a few seconds but it
> is incomprehensible and after few seconds I get the error "write to
> audio interface failed (broken pipe)".
>
> I also tried opening two pcm handles for each stream to the same
> device ("default"), but the second handle is unusable gives the same
> error "write to audio interface failed (broken pipe)".
>
> I have the same problem playing two audio streams to the /dev/dsp device.
>
> I am pretty sure I am not doing it the right way. Any help is highly
> appreciated or pointer to links that explains how =A0to play multiple
> streams using alsa.
>
>
> Thanks
> Arjunen
>

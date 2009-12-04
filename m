From: Christophe Osuna <christophe.osuna@gmail.com>
Subject: Re: Underruns in basic audio playback application
Date: Fri, 4 Dec 2009 09:28:57 +0100
Message-ID: <b6251a620912040028k7fdfaf23xbf07be01898aaaa6@mail.gmail.com>
References: <829197380912030804u672b31c6ybf30e87828b7576b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 77CE310380B
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 09:28:59 +0100 (CET)
Received: by bwz9 with SMTP id 9so4464601bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Dec 2009 00:28:58 -0800 (PST)
In-Reply-To: <829197380912030804u672b31c6ybf30e87828b7576b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Devin Heitmueller <dheitmueller@kernellabs.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/3 Devin Heitmueller <dheitmueller@kernellabs.com>:
> I am working on a very basic application that reads a capture device
> and outputs to a playback device. =A0It's what you would traditionally
> accomplish with something like the following:
>
> arecord -D hw:1,0 -r 48000 -c 2 -f S16_LE | aplay -
>
> However, in this case, since the final result will be part of a TV
> watching application, I need to maintain less than 30ms of latency to
> preserve lipsync.
>
> The application I ended up with essentially creates two PCM streams
> (one for capture, one for playback), sets them up with the same
> parameters in terms of rate, format, channels, etc., and then has a
> loop of snd_pcm_readi() and snd_pcm_writei() calls.
>
> The application works, except I am getting a considerable amount of
> underruns on the playback device.
>
> Given my relative inexperience with alsa-lib, I suspect that I have
> misconfigured one of the parameters effecting buffering - buffer size,
> buffer time, period size, period time.
>
> Can anyone offer any constructive suggestions or tips on what these
> tuning parameters should be set to for a continuous 48000Khz, 2
> channel stream of audio? =A0Also, should the buffering configuration
> really be the same for both the capture and playback stream, or do I
> need to play some games such that one requires more/less buffering
> than the other?

I don't have much experience myself, but in such a situation I would
recommend either increasing buffer size, or linking capture and
playback devices with snd_pcm_link().

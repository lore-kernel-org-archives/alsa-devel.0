From: Daniel Mack <zonque@gmail.com>
Subject: M-Audio FTU issues
Date: Fri, 24 Jun 2011 03:14:09 +0200
Message-ID: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 730E524725
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 03:14:13 +0200 (CEST)
Received: by pwi18 with SMTP id 18so1648244pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 18:14:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

So, I've looked into this today and as expected, the device normally
operates in implicit feedback mode. After installing a proprietary
driver on Mac OS X (that regularily crashed my kernel), the analyzer
shows that for every inbound packet, an out packet is sent back with
the same amount of data in it. And there are no feedback endpoints.


On Tue, Jun 14, 2011 at 11:21 AM, Aur=E9lien Leblond <blablack@gmail.com> w=
rote:
> There are still the issue of samples dropping.
>
> Tto reproduce it:
> - Open Audacity and set it up to be using Jack.
> - Click Generate -> Tone -> Ok.
>
> "Normally" you should hear very regular pops...
>

What surprises me though, is that I can't hear the clicks and pops you
guys describe. Instead, I hear a quite annoying distortion for both
44100 and 48000 Hz which I can't explain either. My spontanous guess
is that there is a resampler in the chain which compensates the sample
drift and notably reduces the audio quality.

I patched the driver so that it supports implicit feedback, but that
didn't change anything in that regard.

Hence my question is: How do you guys test? I renderened a sine tone
in different samplerates and bit depths to .wav files and play them
with aplay (no pulseaudio or anything in the chain). Could you try the
same and report what happens?


Daniel

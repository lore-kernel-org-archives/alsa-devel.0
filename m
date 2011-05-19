From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Thu, 19 May 2011 10:51:55 +1000
Message-ID: <BANLkTi=y-RO-LaiNsPLv8CJ-MWYYsePgCw@mail.gmail.com>
References: <4DD3E39D.30100@showlabor.de>
	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
	<4DD413FC.2090808@showlabor.de>
	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6899B10384E
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 02:51:56 +0200 (CEST)
Received: by ewy6 with SMTP id 6so677210ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 17:51:55 -0700 (PDT)
In-Reply-To: <BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

Daniel,

> The main problem at the moment is that snd_usb_create_mixer() will not be
> > called on quirked devices! Take a look at card.c: snd_usb_create_mixer()
> > will only be called if snd_usb_create_quirk() returns > 0. But why should
> we
> > assume that quirked devices don't have any mixers?
>
> That is indeed strange, yes. I can't explain that. Not to break
> existing devices, I would suggest adding a bit-wise "flags" field to
> snd_usb_audio_quirk and still create the mixers if a certain flag
> (something like "QUIRK_FLAG_CREATE_STANDARD_MIXERS") is set. Clemens,
> Takashi, would that be ok?
>
> In general, note that as long as functions are static, the can and
> should have short names. But once they're not, you're in the global
> kernel namespace, and all symbols must be well prefixed (with
> "snd_usb_" in that case) in order to avoid name collisions.
>
>
So this is probably a terrible idea but what about creating a new quirk

QUIRK_MIXER_STANDARD_INTERFACE and just having that eventually call
snd_usb_create_mixer()

because conceptually I could see this as two problems with two solutions.
one is that the interface type/blah is the mixer is a lie (vendor_specific
instead of UAC2 MIXER . (should be solved via a "quirk" in quirk-table.h)
and

The other is that the endpoint descriptors within that are wrong (solved in
mixer_quirks)

or am I thinking about this wrong?

Grant.

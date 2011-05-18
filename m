From: Daniel Mack <zonque@gmail.com>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Wed, 18 May 2011 23:30:46 +0200
Message-ID: <BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
References: <4DD3E39D.30100@showlabor.de>
	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
	<4DD413FC.2090808@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 83EC724372
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 23:30:48 +0200 (CEST)
Received: by pwi9 with SMTP id 9so1129681pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 14:30:47 -0700 (PDT)
In-Reply-To: <4DD413FC.2090808@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 18, 2011 at 8:46 PM, Felix Homann <linuxaudio@showlabor.de> wrote:
> Am 18.05.2011 19:51, schrieb Daniel Mack:
>>
>> Hmm, I'm not sure whether I understand what you're trying to do. You
>> want to add mixers that are not added by the generic driver?
>
> I'm adding a mixer to a device that doesn't even tell the driver that a
> mixer is present. There's no descriptor for it whatsoever. Nevertheless, you
> can control the mixer just like a standard usb audio mixer. Therefore I
> wanted to reuse as much of already present code as possible. Most of all I
> didn't want to construct any URBs or write new control_get or _put
> functions.

Ok, I see your point. Well in that case, I would add the mixers in
mixer_quirks.c just like you did in your patch, but I would basically
copy some code from build_feature_ctl() and allocate and fill a
special cval from within your quirk function. I would suggest making
usb_feature_unit_ctl (the struct) public (remove the static, prefix
the name with snd_usb_ and add the prototype to the header), so you
can reference it from mixer_quirks.c. That way, you would keep all the
_info, _get and _put functions privately to mixer.c, but still have
the ability to reuse most of the code. You just need to fill your cval
with data the generic functions can cope with. Does that make sense?

> The problem is not how to get the mixer for the Fast Track Ultra (FTU)
> working. The problem is how to do it without breaking other mixers ;-)

You wouldn't alter any existing code that way, and just add special
stuff for this device.

> The main problem at the moment is that snd_usb_create_mixer() will not be
> called on quirked devices! Take a look at card.c: snd_usb_create_mixer()
> will only be called if snd_usb_create_quirk() returns > 0. But why should we
> assume that quirked devices don't have any mixers?

That is indeed strange, yes. I can't explain that. Not to break
existing devices, I would suggest adding a bit-wise "flags" field to
snd_usb_audio_quirk and still create the mixers if a certain flag
(something like "QUIRK_FLAG_CREATE_STANDARD_MIXERS") is set. Clemens,
Takashi, would that be ok?

In general, note that as long as functions are static, the can and
should have short names. But once they're not, you're in the global
kernel namespace, and all symbols must be well prefixed (with
"snd_usb_" in that case) in order to avoid name collisions.


Daniel

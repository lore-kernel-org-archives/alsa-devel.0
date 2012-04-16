From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/2] snd-usb-audio: Skip un-parseable mixer
 units instead of erroring
Date: Mon, 16 Apr 2012 12:00:31 +0530
Message-ID: <CAJe_ZhcDBunFuHOzrzHHiMyNkLnvoCTZm8NifDSWGnRN-fqM2Q@mail.gmail.com>
References: <1334420364-30700-1-git-send-email-mark@pogo.org.uk>
	<s5hk41ip15p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id BC87024459
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 08:30:31 +0200 (CEST)
Received: by laap9 with SMTP id p9so3353543laa.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Apr 2012 23:30:31 -0700 (PDT)
In-Reply-To: <s5hk41ip15p.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Hills <mark@pogo.org.uk>
List-Id: alsa-devel@alsa-project.org

On 15 April 2012 00:54, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 14 Apr 2012 17:19:23 +0100,
> Mark Hills wrote:
>>
>> Some interfaces reference endpoints which do not exists. To
>> accomodate these, do not fail completely, but skip over them.
>>
>> This allows the Electrix Ebox-44 with earlier firmware to be
>> detected and used for audio.
>
> Does the driver warn something? =A0Ignoring silently doesn't sound
> right...
>
I had been looking into UAC2 device side driver. Debugging
it, enlightened me of the mess the USB audio implementations are in.
IMHO ALSA support usb audio better than AppleUSBAudio ... guess they
are too embarrassed of the code that they no longer keep it public :D

Of course, major blame is on buggy implementation/reporting of configuration
by the devices.

I was wondering if it would make sense for ALSA to first 'mend' any
discrepancies in the reported configuration (say by having optional
callbacks registered against vid/pid), and then instantiate the sound card
which only refers to the cached sanitized configuration ?

That way, we could write usb-audio core to UAC specification, while
keeping vendor specific hacks out separately. Or so do I think.

Regards.
-Jassi

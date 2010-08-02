From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: How to handle HBR pass-through? (new PCM_FORMAT?)
Date: Mon, 2 Aug 2010 14:33:38 -0500
Message-ID: <AANLkTi=gj0vwsX0x3Ct9nA=GM2BrH0GVqjxLPr5VG1gy@mail.gmail.com>
References: <201008011423.33724.anssi.hannula@iki.fi>
	<AANLkTi=MCNmW5qUT0spwu31UO3qmSFShw1vgkSAvU4ro@mail.gmail.com>
	<201008021040.17380.anssi.hannula@iki.fi>
	<s5hocdlm1f0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 586B510381E
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 21:33:41 +0200 (CEST)
Received: by iwn39 with SMTP id 39so4869131iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 12:33:40 -0700 (PDT)
In-Reply-To: <s5hocdlm1f0.wl%tiwai@suse.de>
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
Cc: Anssi Hannula <anssi.hannula@iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> Looked at gstreamer, it seems to only have ac3-in-iec61937 support curre=
ntly.
>> However, I'd guess gstreamer would additionally need some ways to 1) det=
ect if
>> HBR is supported, and 2) detect if the connected receiver supports the
>> specific codec..
>
> Reusing the existing IEC958 status bits is OK for practical POV,
> indeed. =A0This makes also compatible with the existing user-space stuff.
>
> But I feel a bit uncertain when looking forward for future
> development. =A0More discussions needed.

The automatic detection is not possible for now no matter if you rely
on gstreamer or ffmpeg or something else.
The one thing that is missing for HDMI is to make use of EDID
information to report to userspace the capabilities of the receiver so
that apps or the audio policy make educated decisions on whether to
decode locally or use pass-through modes using iec61937. The HDMI spec
only mandates stereo/48kHz, and if you have an older receiver (2 years
old...) you may not have TruHD supported there. To the best of my
knowledge, there aren't any standard controls to report what the
receiver supports. I had some discussions with Takashi on this in the
past, looks like it's time to make this happen?

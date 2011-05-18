From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Wed, 18 May 2011 10:43:36 -0500
Message-ID: <BANLkTi=oR9VoW8TbgicF0Zg3bSS46kwbkA@mail.gmail.com>
References: <4DD27C43.3050509@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAA0D@HQMAIL01.nvidia.com>
	<s5haael5mzb.wl%tiwai@suse.de>
	<BANLkTi=H8sqtf-5TvsKjQF8RA1bxBAfEWA@mail.gmail.com>
	<s5hpqnh2pyu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id B70652437B
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 17:43:37 +0200 (CEST)
Received: by ewy6 with SMTP id 6so532103ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 18 May 2011 08:43:37 -0700 (PDT)
In-Reply-To: <s5hpqnh2pyu.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>> > A simple approach would be adding a control element containing
>> > byte-array of ELD/EDID.
>>
>> Are there any examples of such controls? Or are we talking about a new
>> kind of control?
>
> Look for SNDRV_CTL_ELEM_TYPE_BYTES. =A0Some codecs provide these.

I started doing some work on this, adding a persistent 256-byte buffer
to store the ELD data instead of dynamically allocating and freeing
the buffer. I am kind of lost with the controls though, never looked
at this part of ALSA before.
In all the HDA code, all controls have an IFACE_MIXER type, while all
the code that uses ELEM_TYPE_BYTES the type is IFACE_PCM. Does this
matter at all?
Likewise, there's a 'generic_hdmi_build_controls' routine in which I
could add the ELD control, but it uses cvt structures. I think it
would make more sense to relate ELD controls to pins, as done with the
proc information.
Quite a learning experience...

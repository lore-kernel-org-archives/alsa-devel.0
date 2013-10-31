From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH 1/4] ALSA: hda - hdmi: Add ATI/AMD multi-channel audio
 support
Date: Fri, 01 Nov 2013 01:58:36 +0200
Message-ID: <5272EEAC.6020405@iki.fi>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>	<1380659456-3746-2-git-send-email-anssi.hannula@iki.fi>	<CACna6ryr37WRvKbMFmLEGt_A2zUD46rZOtJMVom+B_xK9WNLuw@mail.gmail.com>	<07e8973b4665cc23c3f4a77e9c7e2b7c@mail.onse.fi>	<CACna6ryFtmZHAhmCPEsoxZc5h4mLuM4ajnKGsp=q0jag2f_SYw@mail.gmail.com>	<5272BCE1.7010700@iki.fi>	<CACna6rzejyTOF2Fvvw1m2SAob7uU5-hJ+yRVk6HS5pDTz7+JWg@mail.gmail.com>	<5272E920.6030606@iki.fi> <CACna6rxuSUA9_1HXnY8yPhQ8BDeEnMvoX6i0WvTtst7UTvcgHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACna6rxuSUA9_1HXnY8yPhQ8BDeEnMvoX6i0WvTtst7UTvcgHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?B?UGV0ZXIgRnLDvGhiZXJnZXI=?= <fritsch@xbmc.org>, Olivier Langlois <olivier@trillion01.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

01.11.2013 01:51, Rafa=C5=82 Mi=C5=82ecki kirjoitti:
> 2013/11/1 Anssi Hannula <anssi.hannula@iki.fi>:
>> Just to check, is the display mode 720p50 or higher (as per HDMI spe=
c
>> 7.3.3)? Though I guess too small mode would cause something else, no=
t
>> this...
>=20
> I'm using 1080p all the time. Do you think that
> HDMI_AUDIO_PACKETS_PER_LINE may have anything to do with this issue
> (see evergreen_hdmi.c)?

Well, anything is possible, but that stuff seems unlikely here, since
apparently some channels get through fine. In multichannel HDMI one
sample of each channel is carried in each audio sample packet, so just
straight "packet loss" shouldn't cause this.

>> Also, does DTS-HD/TrueHD work with this receiver (interesting since
>> those require 8-channel 192kHz link)?
>=20
> Both are working for me. I've tested it using 2 movies:
> 1) English TrueHD.5.1 @ 1417 kbps
> 2) Audio
> Codec................: DTSHD-MA
> Bitrate..............: 3718 kbps
> kHz/bit..............: 24-bit
> Channels.............: 5.1
> Language.............: English

Which makes it even stranger, since HBR packets look exactly like ASP
packets with a few flipped bits.

Hm, the earlier non-working speaker-test commands were with -c6. What
about -c8?

>> Would be interesting to check if this works in Windows I guess (or m=
aybe
>> even just fglrx, though I can't think of a reason it'd make a differ=
ence).
>=20
> Installing fglrx is an option, I can try that. Not a big chance for
> Windows here.
>=20


--=20
Anssi Hannula

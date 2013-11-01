From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH 1/4] ALSA: hda - hdmi: Add ATI/AMD multi-channel audio support
Date: Fri, 1 Nov 2013 12:29:47 +0100
Message-ID: <CACna6rymYy6hfpH6reknpa0QPHy31EwngOx4-d7JW4roANNQbQ@mail.gmail.com>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
	<1380659456-3746-2-git-send-email-anssi.hannula@iki.fi>
	<CACna6ryr37WRvKbMFmLEGt_A2zUD46rZOtJMVom+B_xK9WNLuw@mail.gmail.com>
	<07e8973b4665cc23c3f4a77e9c7e2b7c@mail.onse.fi>
	<CACna6ryFtmZHAhmCPEsoxZc5h4mLuM4ajnKGsp=q0jag2f_SYw@mail.gmail.com>
	<5272BCE1.7010700@iki.fi>
	<CACna6rzejyTOF2Fvvw1m2SAob7uU5-hJ+yRVk6HS5pDTz7+JWg@mail.gmail.com>
	<5272E920.6030606@iki.fi>
	<CACna6rxuSUA9_1HXnY8yPhQ8BDeEnMvoX6i0WvTtst7UTvcgHA@mail.gmail.com>
	<5272EEAC.6020405@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5272EEAC.6020405@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?Q?Peter_Fr=C3=BChberger?= <fritsch@xbmc.org>, Olivier Langlois <olivier@trillion01.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

2013/11/1 Anssi Hannula <anssi.hannula@iki.fi>:
>> Both are working for me. I've tested it using 2 movies:
>> 1) English TrueHD.5.1 @ 1417 kbps
>> 2) Audio
>> Codec................: DTSHD-MA
>> Bitrate..............: 3718 kbps
>> kHz/bit..............: 24-bit
>> Channels.............: 5.1
>> Language.............: English
>
> Which makes it even stranger, since HBR packets look exactly like ASP
> packets with a few flipped bits.
>
> Hm, the earlier non-working speaker-test commands were with -c6. What
> about -c8?

Side right behaves just like rear right
Side left behaves just like a rear left
No other differences.

--=20
Rafa=C5=82

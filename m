From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [REGRESSION] Sound goes too fast due to 798cb7e897210
Date: Tue, 18 Oct 2011 10:38:06 +0200
Message-ID: <4E9D3AEE.6070809@tremplin-utc.net>
References: <4E9D3466.5000901@tremplin-utc.net> <s5hzkgy1zf1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzkgy1zf1.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, alsa-devel@alsa-project.org, david.henningsson@canonical.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Op 18-10-11 10:23, Takashi Iwai schreef:
> At Tue, 18 Oct 2011 10:10:14 +0200,
> =C3=89ric Piel wrote:
:
> If that commit affects, the best fix would be to give a quirk specifi=
c
> to your device.  Try to pass either position_fix=3D1 or position_fix=3D=
2.
> Only one of them should work (likely 2).
>
> After checking it, you can add it to position_fix_list[] in
> sound/pci/hda/hda_intel.c together with PCI SSID.

Hello,
Thanks for the quick response. Indeed forcing position_fix=3D1 does fix=
=20
the bug. I'll not try to make a patch for my device.

Cheers,
=C3=89ric

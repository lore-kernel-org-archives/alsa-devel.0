From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [alsa-devel] [PATCH v2] soc/lapis: add machine driver
Date: Tue, 6 Dec 2011 02:11:40 +0000
Message-ID: <057C8CCF-453E-4DC2-8E22-3D260973D35E@cirrus.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
	<20111202153401.GX8245@opensource.wolfsonmicro.com>
	<CANKRQniyjT_2Ko=EYmffu3_NzDJQTMm9nY6rUp-DQ70e6AVQpA@mail.gmail.com>
	<20111205183223.GB7467@opensource.wolfsonmicro.com>,<CANKRQnhEFvubv0b63z34=_xn4x4q=20enofqPrMsFetj1x7-NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANKRQnhEFvubv0b63z34=_xn4x4q=20enofqPrMsFetj1x7-NQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, "qi.wang@intel.com" <qi.wang@intel.com>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yong.y.wang@intel.com" <yong.y.wang@intel.com>, "kok.howg.ewe@intel.com" <kok.howg.ewe@intel.com>, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, "joel.clark@intel.com" <joel.clark@intel.com>
List-Id: alsa-devel@alsa-project.org



On Dec 5, 2011, at 8:01 PM, "Tomoya MORINAGA" <tomoya.rohm@gmail.com> wrote:

> 2011/12/6 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>>> According to "machine.txt", I created this machine driver referring
>>> corgi.c/spitz.c.
>>> However, corgi.c/spitz.c. don't look obeying your saying.
>> 
>> You really need to look at current drivers to make sure you're following
>> current best practice - older drivers, particularly for obsolte hardware
>> like the Zaurus machines, may well not reflect the current best practices.
> 
> I see.
> I won't read this docs.
> 
> BTW, Let me know the best practice of machine driver?
> I can't identify which driver is modern or not.
> 
> 
Check the OMAP and Samsung directories. Those are pretty current

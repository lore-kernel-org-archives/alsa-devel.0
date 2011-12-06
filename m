From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Tue, 6 Dec 2011 11:37:52 +0900
Message-ID: <CANKRQniQSUWyaKUcn24ungmAu0ABHhBZ1=YhGz5jAp02X=KTAA@mail.gmail.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
	<20111202153401.GX8245@opensource.wolfsonmicro.com>
	<CANKRQniyjT_2Ko=EYmffu3_NzDJQTMm9nY6rUp-DQ70e6AVQpA@mail.gmail.com>
	<20111205183223.GB7467@opensource.wolfsonmicro.com>
	<CANKRQnhEFvubv0b63z34=_xn4x4q=20enofqPrMsFetj1x7-NQ@mail.gmail.com>
	<057C8CCF-453E-4DC2-8E22-3D260973D35E@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 727A6103B05
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 03:37:54 +0100 (CET)
Received: by dadi2 with SMTP id i2so5229685dad.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 18:37:53 -0800 (PST)
In-Reply-To: <057C8CCF-453E-4DC2-8E22-3D260973D35E@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, "qi.wang@intel.com" <qi.wang@intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yong.y.wang@intel.com" <yong.y.wang@intel.com>, "kok.howg.ewe@intel.com" <kok.howg.ewe@intel.com>, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, "joel.clark@intel.com" <joel.clark@intel.com>
List-Id: alsa-devel@alsa-project.org

2011/12/6 Austin, Brian <Brian.Austin@cirrus.com>:
>
> On Dec 5, 2011, at 8:01 PM, "Tomoya MORINAGA" <tomoya.rohm@gmail.com> wrote:
>
>> 2011/12/6 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>>>> According to "machine.txt", I created this machine driver referring
>>>> corgi.c/spitz.c.
>>>> However, corgi.c/spitz.c. don't look obeying your saying.
>>>
>>> You really need to look at current drivers to make sure you're following
>>> current best practice - older drivers, particularly for obsolte hardware
>>> like the Zaurus machines, may well not reflect the current best practices.
>>
>> I see.
>> I won't read this docs.
>>
>> BTW, Let me know the best practice of machine driver?
>> I can't identify which driver is modern or not.
>>
>>
> Check the OMAP and Samsung directories. Those are pretty current
>
Thanks.  However, i2c access code is not included in Samsung.
Though OMAP includes i2c access code like below,
  omap/sdp3430.c: twl_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
  omap/sdp3430.c: twl_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
this code doesn't seem applicable for me.

Could you show best practice for i2c access of machine driver?

thanks,
tomoya

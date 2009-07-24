From: "Laurent ." <sid6582@msn.com>
Subject: Re: Help with multichannel High Speed USB audio device
Date: Fri, 24 Jul 2009 15:32:22 -0700
Message-ID: <SNT121-W2357C6A5D3CDAD3D7A7536B2190@phx.gbl>
References: <SNT121-W363BA2CA76A9BB36ABA8A6B2190@phx.gbl>
	<4A697B10.1020601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from snt0-omc4-s15.snt0.hotmail.com (snt0-omc4-s15.snt0.hotmail.com
	[65.55.90.218]) by alsa0.perex.cz (Postfix) with ESMTP id 3691D2413B
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Jul 2009 00:32:24 +0200 (CEST)
In-Reply-To: <4A697B10.1020601@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org




----------------------------------------
> Date: Fri, 24 Jul 2009 11:12:48 +0200
> From: clemens@ladisch.de
> To: sid6582@msn.com
> CC: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Help with multichannel High Speed USB audio dev=
ice
>
> Laurent . wrote:
>> I made an embedded device that has a CODEC with 6 inputs connected to an=
 ARM9
>> micro-controller that has an integrated high-speed USB controller.
>> Now, I need to write the USB code on that micro-controller so that i can=
 capture those
>> channels in real-time at 24bits / 48 KHz with low latency (ie. sub 10ms)=
, on a computer.
>>
>> I only need my device to work with Linux, and if possible, I would like =
to avoid writing a device
>> driver on the Linux-side.
>>
>> Is there already such a USB audio driver available that I could nearly u=
se "as is" and to which
>> i would conform ?
>
> Yes, snd-usb-audio.
>
>> Would you have some general guideline on how to write the high-speed USB=
 device code ?
>
> Just conform to the USB (2.0) and USB Audio (1.0) specifications.
>
>> For simplicity, my device is going to be the "clock master" of the syste=
m since it is already has
>> the exact clock that drives the CODEC.
>
> So you'd use an asynchronous endpoint.
>
>
> Best regards,
> Clemens

_________________________________________________________________
Bing=99 brings you maps, menus, and reviews organized in one place. Try it =
now.
http://www.bing.com/search?q=3Drestaurants&form=3DMLOGEN&publ=3DWLHMTAG&cre=
a=3DTXT_MLOGEN_Local_Local_Restaurants_1x1

From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [uclinux-dist-devel] [PATCH 3.0]ASoC: ad193x: add
 spi_hw_read, fix sysclk and register definition
Date: Fri, 12 Aug 2011 12:10:25 +0800
Message-ID: <CAHG8p1D8MrLZ6rGHOoc6QiEioYD3nYJftp7AedM2ja5uuWuDRw@mail.gmail.com>
References: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
	<20110811133432.GA6067@kroah.com> <s5hpqkc83o2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EF49B103968
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 06:10:25 +0200 (CEST)
Received: by qwf7 with SMTP id 7so1443982qwf.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2011 21:10:25 -0700 (PDT)
In-Reply-To: <s5hpqkc83o2.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Greg KH <greg@kroah.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "Zhang,
	Sonic" <Sonic.Zhang@analog.com>, "stable@kernel.org" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

2011/8/11 Takashi Iwai <tiwai@suse.de>:
> At Thu, 11 Aug 2011 06:34:32 -0700,
> Greg KH wrote:
>>
>> On Thu, Aug 11, 2011 at 04:52:18AM -0400, Zhang, Sonic wrote:
>> >
>> >
>> > >-----Original Message-----
>> > >From: uclinux-dist-devel-bounces@blackfin.uclinux.org
>> > >[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On
>> > >Behalf Of Scott Jiang
>> > >Sent: Thursday, August 11, 2011 4:27 PM
>> > >To: Greg Kroah-Hartman
>> > >Cc: uclinux-dist-devel@blackfin.uclinux.org;
>> > >alsa-devel@alsa-project.org; stable@kernel.org
>> > >Subject: [uclinux-dist-devel] [alsa-devel][PATCH 3.0]ASoC:
>> > >ad193x: add spi_hw_read, fix sysclk and register definition
>> > >
>> > >asoc cache layer can't support this kind of spi registers, so
>> > >bypass cache and read regiters directly
>> > >
>> >
>> > This patch is against stable kernel 3.0 only, the ASOC framework in ke=
rnel 3.1 and later are different.
>>
>> Then I need some acks from all of the relevant maintainers before I can
>> apply it to the stable kernel tree.
>>
>> Is there a corrisponding patch in Linus's tree that does the same thing
>> already?
>
> Not yet, even neither in sound git tree.
>
> We're handling the same patch now for 3.1. =A0As the patch is likely
> applicable to 3.0 as is, putting Cc to stable would be enough, I
> suppose.
>
>
> Scott, the patch to stable kernel must have been applied to the
> upstream tree beforehand. =A0Read Documentation/stable_kernel_rules.txt.
>
Thanks, Takashi. I should send patch for 3.1 and cc stable tree.
I have a question here that patch for 3.1 and 3.0 is different, who is
responsible for the back patch?

Scott

From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: commit bd5389278c96f585afcac4058420e4f3ac201d2a
 introduce big problem
Date: Tue, 15 Nov 2011 15:45:22 +0800
Message-ID: <CAHG8p1B7w4ar1OjYbnzYR7YtdPvy8ER82ybAwXZOEprxBnLFzA@mail.gmail.com>
References: <CAHG8p1DmEcTs7Mzmy8F0Aon3SGog9q+CpOX7SS+vFFkmeVWGcw@mail.gmail.com>
	<s5hbosngd04.wl%tiwai@suse.de>
	<CAHG8p1BZ5gV3xAb5QRgc1eEMQ9gB44y+8aoMPcP3R-Th5PESJw@mail.gmail.com>
	<CAHG8p1AHr6Z7VY+6zVhGk6AkbZxdS+firK4eFVrg81NWJnEVNA@mail.gmail.com>
	<s5h8vni6ac4.wl%tiwai@suse.de>
	<CAHG8p1BnW6v9uqFJq_UHif5Hqu9K9qZ_QZYL0SbBFxF+iJVhHA@mail.gmail.com>
	<s5h39dpdfw1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A4C4103862
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 08:45:23 +0100 (CET)
Received: by vcbfy13 with SMTP id fy13so6589290vcb.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 23:45:23 -0800 (PST)
In-Reply-To: <s5h39dpdfw1.wl%tiwai@suse.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2011/11/15 Takashi Iwai <tiwai@suse.de>:
> At Tue, 15 Nov 2011 14:08:36 +0800,
> Scott Jiang wrote:
>>
>> 2011/11/14 Takashi Iwai <tiwai@suse.de>:
>> > At Mon, 14 Nov 2011 17:53:10 +0800,
>> > Does your driver support mmap?
>>
>> No, our tdm driver doesn't support mmap.
>
> OK, then could you try the latest alsa-lib git?
> I committed the possible fix for your problem.
>
I confirm the patch works. Thanks.
Scott

From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Thu, 31 Dec 2009 12:20:43 +0800
Message-ID: <4f3252890912302020k35efb96eu686fb16d47783ec5@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
	<1261869811.30924.69.camel@localhost.localdomain>
	<4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>
	<1261947691.24632.29.camel@localhost.localdomain>
	<4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>
	<1262058553.20808.15.camel@localhost.localdomain>
	<4f3252890912292307qc3c4b29m98c7d6e4c8fd6a7d@mail.gmail.com>
	<1262192170.11628.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f185.google.com (mail-px0-f185.google.com
	[209.85.216.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 944D010381F
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 05:20:44 +0100 (CET)
Received: by pxi15 with SMTP id 15so8924013pxi.23
	for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2009 20:20:43 -0800 (PST)
In-Reply-To: <1262192170.11628.13.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/31 Chris <cpollock@embarqmail.com>

> On Wed, 2009-12-30 at 15:07 +0800, Raymond Yau wrote:
> > Please post the output of alsa-info.sh
> Raymond, I can't seem to locate that script.
>

http://git.alsa-project.org/?p=alsa-driver.git;a=blob_plain;f=utils/alsa-info.sh



> > Do your VIA 8237/ens1371 has any digital output/input ?
> That I can't answer
>

Do your motherboard/sound card  has optical/coaxial spdif ?



> Sorry, not much help I know
>
>
> --
> KeyID 0xE372A7DA98E6705C
>
>
> Did PA developer tell you the meaning of those messages ?

D: memblock.c: Pool full

and

W: asyncq.c: q overrun, queuing locally

There are another message which need the PA developer to explain the meaning
of "Underrun on "*/*.ogg" 0 bytes in queue "


D: protocol-native.c: Requesting rewind due to end of underrun.
D: alsa-sink.c: Requested to rewind 17632 bytes.
D: alsa-sink.c: Limited to 17600 bytes.
D: alsa-sink.c: before: 4400
D: alsa-sink.c: after: 4400
D: alsa-sink.c: Rewound 17600 bytes.
D: sink.c: Processing rewind...
D: sink-input.c: Have to rewind 17600 bytes on render memblockq.
D: source.c: Processing rewind...
D: protocol-native.c: Underrun on
'/usr/share/sounds/gnome/default/alerts/sonar.ogg', 0 bytes in queue.

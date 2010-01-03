From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Sun, 3 Jan 2010 08:49:16 +0800
Message-ID: <4f3252891001021649v59b1add5q6e786e5fedfc1c2@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
	<1261869811.30924.69.camel@localhost.localdomain>
	<4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>
	<1261947691.24632.29.camel@localhost.localdomain>
	<4f3252890912272114t6dcfa58bj4d5b5e6e606c5004@mail.gmail.com>
	<1262058553.20808.15.camel@localhost.localdomain>
	<4f3252890912292307qc3c4b29m98c7d6e4c8fd6a7d@mail.gmail.com>
	<hhi2m3$26b$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 21B2D1037FE
	for <alsa-devel@alsa-project.org>; Sun,  3 Jan 2010 01:49:20 +0100 (CET)
Received: by ywh33 with SMTP id 33so14254672ywh.23
	for <alsa-devel@alsa-project.org>; Sat, 02 Jan 2010 16:49:16 -0800 (PST)
In-Reply-To: <hhi2m3$26b$1@ger.gmane.org>
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

2009/12/31 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 30/12/09 07:07 did gyre and gimble:
> > Why do PA server try to open an non-existing device iec958 so many times
> ?
>
> It has to try and open the device several times to probe for available
> profiles. This is only done at startup and then cached for the duration
> of the run in the form of a list of available profiles.
>
> Col
>
> --
>


what is the meaning of those messages in pulseaudio log ?

1) D: memblock.c: Pool full

2) W: asyncq.c: q overrun, queuing locally

3)  D: protocol-native.c: Requesting rewind due to end of underrun.

4)  D: alsa-sink.c: Requested to rewind 17632 bytes.

5)  D: alsa-sink.c: Limited to 17600 bytes.

D: alsa-sink.c: before: 4400
D: alsa-sink.c: after: 4400
D: alsa-sink.c: Rewound 17600 bytes.
D: sink.c: Processing rewind...

6) D: sink-input.c: Have to rewind 17600 bytes on render memblockq.

D: source.c: Processing rewind...

7) D: protocol-native.c: Underrun on '/usr/share/sounds/gnome/
default/alerts/sonar.ogg', 0 bytes in queue.

From: Denis Kup <dener.kup@gmail.com>
Subject: Re: Acer Aspire 7730G support
Date: Thu, 25 Jun 2009 01:36:34 +0400
Message-ID: <376f0d430906241436k20912428o3cd8ea5d83b300ce@mail.gmail.com>
References: <376f0d430906240509w7b8e23d4m92e3fc99fabd528@mail.gmail.com>
	<s5heit9ajvk.wl%tiwai@suse.de>
	<376f0d430906240941k699e494cr325f1c091a609f19@mail.gmail.com>
	<376f0d430906241052i1e37904bo9c90b98e0dca6077@mail.gmail.com>
	<d54969c50906241339u7a4a41cbvbc66643e794436b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CCEF103839
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 23:36:35 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so1188117fge.21
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 14:36:34 -0700 (PDT)
In-Reply-To: <d54969c50906241339u7a4a41cbvbc66643e794436b9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/6/25 Emilio L=F3pez <buhitoescolar@gmail.com>
>
> I posted a new patch some time ago, can you try it?

Sorry but i have problems with drivers now, after trying your patch i
decided to reinstall drivers with my patch. I install by

su
./configure
make
make install

But after install alsamixer shows that chip of standart device is
NVIDIA mcp78 hdmi (it's is HDMI output). And there is no ALC888
device. I don't know what to do. Any ideas? (please dont send them to
maillist it's not about this theme)

> > - 2) there is only 1 map for jacks: front/ext mic/ (something i dont
> > know, it should be line in)
>
> My laptop, Aspire 6930, has a black jack (headphones), a pink one
> (external mic) and a light blue one (line in). What's the difference
> with your laptop?

In my laptop various functions can be assigned to jacks. For ex. blue
can be side(in 4 channel and 6 channel modes) or line in (in 2channel
mode). So there are 3 maps: for 2, 4, 6 channel modes. In 6 channel
mode i can connect laptop with 5.1 speakers for ex, in 4 ch i can use
quadro speakers and ext mic, in 2ch i can use headphones,ext mic and
line in.

> > - 3) there no side and center channels
>
>>Subwoofer is LFE, the other speaker is Front. Is any other speaker missin=
g?

I think you understand me already (read my second answer)

> > - 3) internal mic dont work
>
> It works here, did you choose "Int mic" and raised the volume to max?
>

Yes, of course.
> > - 4) there no line in in input source menu in mixer
> > + 5) Subwoofer controls with LFE channel in mixer
> > ? 7) i dont know how spdif works, because i have not any spdif speakers=
 in house
>
> Same here, unfortunately.
>
> BTW, I'm Emilio, with "E" hehe

Sorry, Emilio! ))

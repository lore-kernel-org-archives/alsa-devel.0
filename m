From: "=?ISO-8859-1?Q?Andreas_P=E5hlsson?=" <andreas@pahlsson.info>
Subject: Re: Avoid overload of PCM volume on Cx5045 codec
Date: Thu, 19 Jun 2008 21:30:31 +0200
Message-ID: <fff10a40806191230j39eec6cat4d709eeb37824330@mail.gmail.com>
References: <fff10a40806181258t20e5c5f5rfd9fc234a91770d8@mail.gmail.com>
	<s5hk5gl92hi.wl%tiwai@suse.de>
	<fff10a40806190434u6998dbfaq23d2f0148704be85@mail.gmail.com>
	<s5hprqd7f5w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 4360824451
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 21:30:33 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so5535330rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2008 12:30:32 -0700 (PDT)
In-Reply-To: <s5hprqd7f5w.wl%tiwai@suse.de>
Content-Disposition: inline
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

2008/6/19 Takashi Iwai <tiwai@suse.de>:
>> compiling a kernelmodule. As per the comment to the patch the sound
>> can become very distorted without it. 6 dB works fine for me.
>
> Hm, but it has far higher values.  Do they also work fine (suppose you
> reverted the amp override patch)?

They do work but give distorted sound.

For my test I just removed the amp override patch but I would really
want to do-the-right-thing.

> It's just a matter of name.  In general, "PCM" volume means that the
> volume control path specific to the PCM, not for other sources.  In
> the case of Conexant codec, there is no loopback route, so it doesn't
> matter, though.

Ok.

Andreas P=E5hlsson

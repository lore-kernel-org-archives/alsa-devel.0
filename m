From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDAudio period/buffer sizes
Date: Sun, 14 Aug 2011 09:44:26 +0800
Message-ID: <CAN8ccib_61bF=KGN47DTop-Ow0st2rwi9KJ2iXw1DpUnP150CA@mail.gmail.com>
References: <CABGFaBtLnbeHHYc4=oO=skmpiAZ3dpqWbavN8JYM-NLuVGovUg@mail.gmail.com>
	<s5hk4b5384x.wl%tiwai@suse.de> <s5haac08f13.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4135E245CD
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 03:44:27 +0200 (CEST)
Received: by fxh10 with SMTP id 10so3147708fxh.38
	for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2011 18:44:26 -0700 (PDT)
In-Reply-To: <s5haac08f13.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/7/27 Takashi Iwai <tiwai@suse.de>:
> At Tue, 26 Jul 2011 14:23:40 -0500,
> Pierre-Louis Bossart wrote:
>>
>> that the buffer itself was already aligned to 128 bytes from the
>> > very beginning as it's allocated via dma_alloc_coherent().
>> > The fact that the commit fixes the real problem means that the buffer
>> > size must be aligned, too, at least for some hardware.
>>
>> I checked internally and the reply was "There is no requirement the buff=
er
>> must be 128 byte multiples. =A0As long as it is integer number of sample=
s, we
>> are good."
>>
>> What's the best way to deal with it? Add a driver option? A compilation
>> option?
>
> I'd say a driver option since this must be dynamically adjustable.
> Care to make a patch?
>
> For 3.2 (after 3.1 merge window), we can disable 128-bytes limit as
> default again for testing. =A0If someone hits the problem, he can switch
> easily and we can investigate more at this time.
>
>
The patch seem fix the problem of
snd_pcm_hw_params_set_period_time_near() to 120ms at 11025Hz for those
ad198x codec which are the only HDA codecs which support 11025Hz and
22050Hz

Does it mean that the period_bytes_min =3D128 can also be removed to
achieve lowest latency ?

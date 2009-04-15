From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: [PATCH] add missing definitions(letters) to
	HD-Audio.txt
Date: Wed, 15 Apr 2009 08:35:18 -0700
Message-ID: <dd18b0c30904150835l6d246bbes648ad50e20690e7e@mail.gmail.com>
References: <dd18b0c30904141431x231a3251v438e365d512f9f95@mail.gmail.com>
	<s5hiql618mt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id E1089244AA
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 17:35:20 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id c5so2449895rvf.32
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 08:35:19 -0700 (PDT)
In-Reply-To: <s5hiql618mt.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 15, 2009 at 4:03 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 14 Apr 2009 14:31:21 -0700,
> Justin Mattock wrote:
>>
>> impact: Add missing definitions(letters).
>>
>> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
>
> Thanks, applied now.
>
> (BTW, your patch couldn't be applied cleanly, partly because of
> =A0a wrong format and partly because of your MUA breaking the lines...)
>
>
> Takashi
>
>>
>> ---
>> =A0Documentation/sound/alsa/HD-Audio.txt | 3 +++
>> =A01 files changed,3 insertions(+),0 deletions(-)
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> ---- Documentation/sound/alsa/HD-Audio.txt =A0 =A0 =A0 =A02009-04-14
>> 17:03:14.000000000 -0700
>> ++++ Documentation/sound/alsa/HD-Audio.txt =A0 =A0 =A0 =A02009-04-14
>> 21:15:22.000000000 -0700
>> @@ -162,7 +162,7 @@
>> =A0What `model` option values are available depends on the codec chip.
>> =A0Check your codec chip from the codec proc file (see "Codec Proc-File"
>> =A0section below). =A0It will show the vendor/product name of your codec
>> -chip. =A0Then, see Documentation/sound/alsa/HD-Audio-Modelstxt file,
>> +chip. =A0Then, see Documentation/sound/alsa/HD-Audio-Models.txt file,
>> =A0the section of HD-audio driver. =A0You can find a list of codecs
>> =A0and `model` options belonging to each codec. =A0For example, for Real=
tek
>> =A0ALC262 codec chip, pass `model=3Dultra` for devices that are compatib=
le
>> @@ -170,7 +170,7 @@
>>
>> =A0Thus, the first thing you can do for any brand-new, unsupported and
>> =A0non-working HD-audio hardware is to check HD-audio codec and several
>> -different `model` option values. =A0If you have a luck, some of them
>> +different `model` option values. =A0If you have any luck, some of them
>> =A0might suit with your device well.
>>
>> =A0Some codecs such as ALC880 have a special model option `model=3Dtest`.
>>
>>
>>
>> --
>> Justin P. Mattock
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>

I went diff -u file.old file.new
(I'm not sure how to generate the
1 files changed,2 etc... stuff)
And yes I will be honest I didn't test the patch.
(figured it wasn't that complicated, and I was tired).

If I find more I'll let you know.
(back to trying to get sound working on my imac).

-- =

Justin P. Mattock

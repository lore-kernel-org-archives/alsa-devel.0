From: Guilherme <grlongo.ireland@gmail.com>
Subject: Re: Understanding _snd_pcm_channel_area Struct (PCM
 Interface)!
Date: Tue, 30 Jun 2009 12:01:53 -0300
Message-ID: <4A4A28E1.8040201@gmail.com>
References: <4A3DEAF9.80508@free.fr>	<4A406AD3.2050002@gmail.com>	<s5hljnjb3so.wl%tiwai@suse.de>	<4A458A6B.2070305@gmail.com>	<s5hzlbu872y.wl%tiwai@suse.de>	<4A4A23D4.4090505@gmail.com>
	<s5h3a9h940t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f200.google.com (mail-px0-f200.google.com
	[209.85.216.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EDDD1037E3
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 17:00:44 +0200 (CEST)
Received: by pxi38 with SMTP id 38so159679pxi.16
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 08:00:43 -0700 (PDT)
In-Reply-To: <s5h3a9h940t.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hum...

so .. the code

if ((areas[chn].step % 16) !=3D0 )

is because a 16bits format's been used.

If I wanted a 32bits sample format I should change that for
if ((areas[chn].step % 32) !=3D0 ) ??

and the offset for the first doen's need any changes, is it?


Just a opinion about all this, I think that alsa developers should design g=
raphs for these things, as has in gstreamer documentation. =

It is a lot easer to understand that way. =


It is because I dont understand very well yet, but as I am going to work wi=
th sound stuff especially in linux environment, Ill be very soon offering h=
elp for this!

;o) =




 =


Tks!

-------------------

Guilherme Longo
Dept. Eng. da Computa=E7=E3o
Unaerp

Linux User - #484927

*Before Asking
http://www.istf.com.br/?page=3Dperguntas

!- I'd rather die on my feet than live on my knees -!



Takashi Iwai wrote:
> At Tue, 30 Jun 2009 11:40:20 -0300,
> Guilherme wrote:
>   =

>> Tks takashi....
>>
>> The doubt comes from this block of code:
>>
>> for (chn =3D 0; chn < channels; chn++) {
>>             if ((areas[chn].first % 8) !=3D 0) {
>>                     printf("areas[%i].first =3D=3D %i, abortando...\n", =
chn, =

>> areas[chn].first);
>>                     exit(EXIT_FAILURE);
>>             }
>>             //pega endere=E7o e offset da area
>>             samples[chn] =3D /*(signed short *)*/(((unsigned char =

>> *)areas[chn].addr) + (areas[chn].first / 8));
>>            =

>>          if ((areas[chn].step % 16) !=3D 0) {
>>                 printf("areas[%i].step =3D=3D %i, aborting...\n", chn, =

>> areas[chn].step);
>>                 exit(EXIT_FAILURE);
>>          }
>>            =

>>                 steps[chn] =3D areas[chn].step / 8;
>>                 samples[chn] +=3D offset * steps[chn];
>>         }
>>
>> first:
>>
>> areas[chn].first % 8   ( I am using chn =3D 1). So for the only area tha=
t =

>> I have, if I get the value of the parameter 'first' isn't divisible by =

>> 8, the program exits.
>> The  same doubt happens with "areas[chn].step % 16"  and  =

>> "areas[chn].step / 8".
>>
>> This is the parameter I am using:
>>
>> static snd_pcm_format_t format =3D SND_PCM_FORMAT_S16;   //sample format =

>> unsigned 16 bit endian
>>
>> Perhaps with this practical example I can understand better.
>>     =

>
> Oops, I wrote wrongly.  The first and step fields are not in bytes but
> bits.  That's why 8 and 16 appear there, corresponding to 1 byte and 2
> bytes.
>
>
> Takashi
>
>   =

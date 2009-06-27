From: Guilherme <grlongo.ireland@gmail.com>
Subject: Re: Understanding _snd_pcm_channel_area Struct (PCM
 Interface)!
Date: Fri, 26 Jun 2009 23:56:43 -0300
Message-ID: <4A458A6B.2070305@gmail.com>
References: <4A3DEAF9.80508@free.fr>	<4A406AD3.2050002@gmail.com>
	<s5hljnjb3so.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 4269424445
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 04:55:46 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3277348qyk.16
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2009 19:55:44 -0700 (PDT)
In-Reply-To: <s5hljnjb3so.wl%tiwai@suse.de>
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

Takashi...

The base_address and the step sounds pretty clear to me.... just the =

offset I could not understand.

What the difference in being  .first =3D 0 or .first =3D 2??? Could you =

provide please a more in depth explanation. I tried really hard find =

this but there is nothing related in the documentation.

area[0].addr =3D base_address;
	addr[0].first =3D 0;
	addr[0].step =3D 4;
	addr[1].addr =3D base_address;
	addr[1].first =3D 2;
	addr[1].step =3D 4;

P.S. being a stereo or a mono pipeline I understand... just the way the off=
set works that is not so clear to me.

Thanks in advanced!


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
> At Tue, 23 Jun 2009 02:40:35 -0300,
> Guilherme wrote:
>   =

>> Hi all.
>>
>> I am a bit confused on what I get with this function.
>> I finished my first project but I did not understand what exactly the
>>
>> _snd_pcm_channel_area at
>>
>>  http://www.alsa-project.org/alsa-doc/alsa-lib/struct__snd__pcm__channel=
__area.html
>>
>> does.
>>
>> There are 3 fields in the documentation.
>>
>> addr, first and step.
>>
>> It seems that addr is the memory address of the channel samples... so =

>> far so good. The "step" is the distance between 2 sample (but I am not =

>> sure) and the least, "first", I could not figure out what does it means.
>>     =

>
> This information is needed to understand how the multi-channel samples
> are assigned in a stream.  The first is the offset of the channel
> position to the given addr.  The step is the bytes to the next sample
> of that channel.
>
> For example, suppose you have a 2-channel stereo interleaved stream
> with 16bit samples.  Then you'll have an array of snd_pcm_channel_area
> with two elements, for left and right channels, containing like
>
> 	area[0].addr =3D base_address;
> 	addr[0].first =3D 0;
> 	addr[0].step =3D 4;
> 	addr[1].addr =3D base_address;
> 	addr[1].first =3D 2;
> 	addr[1].step =3D 4;
>
> Both channels share the same base address but have the different
> "first" offset bytes.  The step size is 4 =3D #chanel * sample-size.
>
> For a non-interleaved stereo stream, it'll look like
>
> 	addr[0].addr =3D base_addr_0;
> 	addr[0].first =3D 0;
> 	addr[0].step =3D 2;
> 	addr[1].addr =3D base_addr_1;
> 	addr[1].first =3D 0;
> 	addr[1].step =3D 2;
>
> Thus it looks like two mono streams with 16bit samples.
>
>
> HTH,
>
> Takashi
>
>   =

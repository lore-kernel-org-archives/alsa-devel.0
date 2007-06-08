From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [ASoC] machine driver and channel configuration
Date: Fri, 08 Jun 2007 17:55:03 +0200
Message-ID: <46697BD7.50104@parrot.com>
References: <loom.20070608T161908-148@post.gmane.org>
	<46697657.2000302@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toronto.xi-lite.net (co202.xi-lite.net [149.6.83.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 22F4A243BB
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 17:59:04 +0200 (CEST)
In-Reply-To: <46697657.2000302@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Timur Tabi a =E9crit :
> Matthieu CASTET wrote:
>> Hi,
>>
>> If the platform/cpu_dai driver and codec support capture and playback =

>> channels.
>> But on the board only the playback link is connected.
>>
>> In this configuration, the codec and platform/cpu_dai driver shouldn't =

>> try to
>> use the capture path (and the resource associated to this).
>>
>>
>> Is there a way to do something like that ?
> =

> I'm just learning about ASoC myself, but using wm8731.c as an example, =

> wouldn't this work:
> =

> struct snd_soc_codec_dai wm8731_dai =3D {
>     .name =3D "WM8731",
>     .playback =3D {
>         .stream_name =3D "Playback",
>         .channels_min =3D 1,
>         .channels_max =3D 2,
>         .rates =3D WM8731_RATES,
>         .formats =3D WM8731_FORMATS,},
>     .capture =3D {
>         .stream_name =3D "Capture",
>         .channels_min =3D 1,
>         .channels_max =3D 2,
>         .rates =3D WM8731_RATES,
>         .formats =3D WM8731_FORMATS,},
> =

> Just change capture.channels_min and channels_max to 0.
> =


Hum, yes I could change channel info at runtime before doing the =

platform_device_add in machine driver.

I'll try that.

Thanks.
Matthieu

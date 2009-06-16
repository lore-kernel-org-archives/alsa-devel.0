From: Guilherme <grlongo.ireland@gmail.com>
Subject: Re: Playback open error: Device or resource busy
Date: Tue, 16 Jun 2009 20:44:21 -0300
Message-ID: <4A382E55.2050003@gmail.com>
References: <4A36C12A.7070408@gmail.com> <4A376494.1080004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 67A0524499
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 01:43:24 +0200 (CEST)
Received: by qyk1 with SMTP id 1so6080224qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2009 16:43:23 -0700 (PDT)
In-Reply-To: <4A376494.1080004@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tks for your tip... however it seem that changing the device name =

doesn't help, instead I get SEGFAULT

static char *device =3D "plughw:0,0";        =

Playback open error: Device or resource busy

static char *device =3D "default";
Segmentation fault


I been through a great number of docs trying to find answers, but I =

don't find any!

Tks!

-------------------

Guilherme Longo
Dept. Eng. da Computa=E7=E3o
Unaerp

Linux User - #484927

*Before Asking
http://www.istf.com.br/?page=3Dperguntas

!- I'd rather die on my feet than live on my knees -!



Clemens Ladisch wrote:
> Guilherme wrote:
>   =

>> Playback device is plughw:0,0
>> Playback open error: Device or resource busy
>>     =

>
> That program should use "default" instead of "plughw:0,0".
>
>
> HTH
> Clemens
>
>   =

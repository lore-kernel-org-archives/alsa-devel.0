From: =?ISO-8859-1?Q?J=E9r=E9my_Lal?= <kapouer@melix.org>
Subject: Re: No line out on latest Mac Mini
Date: Sat, 22 Oct 2011 14:18:36 +0200
Message-ID: <4EA2B49C.6090001@melix.org>
References: <654DF80AD31A344E93DBCC6280BD6DEF2226DCB3@NL0230MBX08N1.DIR.slb.com>
Reply-To: kapouer@melix.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 65CFE10382F
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 14:18:38 +0200 (CEST)
In-Reply-To: <654DF80AD31A344E93DBCC6280BD6DEF2226DCB3@NL0230MBX08N1.DIR.slb.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Frankish <j-frankish@slb.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
i have an imac 12,2 (2011) and i had to change GPIO with hda_analyzer to ge=
t some sound
on line out.

J=E9r=E9my.


On 22/10/2011 14:14, John Frankish wrote:
> I posted this to the alsa-user list a couple of weeks ago but did not get=
 an answer
> =

> I've been trying to get analog line out to work to headphones or =

> powered speakers with the latest Mac Mini, but so far the best I've =

> managed to achieve is to get the internal speaker to work. Line out
> works with the Mac OS.
> =

> I've also tried the HDA analyser mentioned here:
> =

> http://www.alsa-project.org/main/index.php/HDA_Analyzer
> =

> but no matter what I do, there is no way to get sound from the line out
> jack to headphones or powered speakers.
> =

> I'm guessing I need one or more obscure options to load the module snd-hd=
a-intel,
> but nothing I've tried so far has worked. The kernel documentation does n=
ot
> mention the mac mini 5,3 the Intel Corporation 6 Series/C200 Series Chips=
et nor the
> combination of Cirrus Logic CS4206 and Intel CougarPoint HDMI - does anyb=
ody know
> where I might find more details?
> =

> Details below:
> ----------
> DMI: Apple Inc. Macmini5,3/Mac-7BA5B2794B2CDB12, BIOS
> MM51.88Z.0075.B00.1106271442 06/27/2011
> Alsa modules from linux-3.0.3
> Alsa-1.0.23
> =

> $ lspci -knn
> 00:1b.0 Audio device [0403]: Intel Corporation 6 Series/C200 Series =

> Chipset Family High Definition Audio Controller [8086:1c20] (rev 05)
>         Subsystem: Intel Corporation Device [8086:7270]
>         Kernel driver in use: HDA Intel
>         Kernel modules: snd-hda-intel
> =

> $ aplay -l
> **** List of PLAYBACK Hardware Devices **** card 0: PCH [HDA Intel =

> PCH], device 0: Cirrus Analog [Cirrus Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 1: Cirrus Digital [Cirrus Digital]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> =

> $ head -n 1 /proc/asound/card0/codec*
> =3D=3D> /proc/asound/card0/codec#0 <=3D=3D
> Codec: Cirrus Logic CS4206
> =3D=3D> /proc/asound/card0/codec#3 <=3D=3D
> Codec: Intel CougarPoint HDMI
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

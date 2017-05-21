From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: HDA Intel ALC889A optical optical spdif in
Date: Sun, 21 May 2017 15:00:22 +0200
Message-ID: <12E027DF-A28D-436C-97E6-6AF0E5EF699D@exactcode.de>
References: <4D425EDE-3FF5-4895-B469-58977B887FAC@exactcode.de>
 <C4DF4DD1-F0E9-4537-B68E-6635FD8902E6@exactcode.de>
 <55213C5F-29CA-49C6-AE16-283BAE9534DF@exactcode.de>
 <s5ho9vpmygb.wl-tiwai@suse.de>
 <0F0E6DC8-D7B8-4EF9-BD47-8AAC124E3665@exactcode.de>
 <6FF6B7F4-9C39-4E3C-BB79-D47507DE6C11@exactcode.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB6A266838
 for <alsa-devel@alsa-project.org>; Sun, 21 May 2017 15:15:49 +0200 (CEST)
In-Reply-To: <6FF6B7F4-9C39-4E3C-BB79-D47507DE6C11@exactcode.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello again,

as it is Sunday I thought it is a good time to further play with this annoy=
ing optical in issue.
I plugged the fibre into a MacPro2,1 that we otherwise use as file server a=
nd such.
Unfortunately ALSA indicates the same Realtek codec is used on it:

	Chip: Realtek ALC889A =


And, no surprise, capturing something on it:

	arecord -D iec958 -f dat > rec.wav

yields nothing useful. Interestingly it yields not zeros, but another stati=
c pattern:

# hexdump -C rec.wav =

00000000  52 49 46 46 24 00 00 80  57 41 56 45 66 6d 74 20  |RIFF$...WAVEfm=
t |
00000010  10 00 00 00 01 00 02 00  80 bb 00 00 00 ee 02 00  |..............=
..|
00000020  04 00 10 00 64 61 74 61  00 00 00 80 1b 08 1b 91  |....data......=
..|
00000030  1b 08 1b 91 1b 08 1b 91  1b 08 1b 91 1b 08 1b 91  |..............=
..|
*
00088020  1b 08 1b 91 1b 08 1b 91  1b 08 1b 91              |............|
0008802c

As I said before, according to the slightly mangled MacBook schematics the =
spdif
pin at least on those looks directly connected with the optical receiver mo=
dule.

Any tip of to debug this in the Linux driver would be welcome!

Also, I powered up the G5, to my surprise the ALSA sound-by-layout module d=
oes
not even have spdif capture controls for that at all, (yes, the G5 also has=
 optical
in and out) =85 :-/

So in total about everything I could find around me has non working optical=
 input
with the ALSA drivers, =85

	Ren=E9

On Apr 22, 2017, at 0:04, Ren=E9 Rebe <rene@exactcode.de> wrote:

> Hi,
> On Apr 21, 2017, at 22:29, Ren=E9 Rebe <rene@exactcode.de> wrote:
> =

>> Hi,
>> =

>> On Apr 21, 2017, at 20:01, Takashi Iwai <tiwai@suse.de> wrote:
>> =

>>> On Fri, 21 Apr 2017 19:22:16 +0200,
>>> Ren=E9 Rebe wrote:
>>>> =

>>>> On Apr 21, 2017, at 18:37, Ren=E9 Rebe <rene@exactcode.de> wrote:
>>>> =

>>>>> Hello again,
>>>>> =

>>>>> so I checked the MacBook schematics and it looks like the optical inp=
ut should be directly connected to pin 47 (GPIO3/SPDIFIN)
>>>>> =

>>>>> Maybe EAPD get=92s accidentally / wrongly enabled? - Maybe someone ca=
n point me how to double check this in ALSA?
>>>> =

>>>> I the meantime I finally figured out how this debug verb setting shoul=
d work via:
>>>> =

>>>> # hda-verb /dev/snd/hwC0D0 0x14 0x70C 0
>>>> nid =3D 0x14, verb =3D 0x70c, param =3D 0x0
>>>> value =3D 0x0
>>>> # hda-verb /dev/snd/hwC0D0 0x15 0x70C 0
>>>> nid =3D 0x15, verb =3D 0x70c, param =3D 0x0
>>>> value =3D 0x0
>>>> =

>>>> which made no difference either, and the ALC889 spec reads =93when pin
>>>> widget  SPDIF-IN is not connected via the programming configuration
>>>> register.=94
>>>> =

>>>> Could that be a missing bit?
>>>> =

>>>> Any pointer or verbs I should poke welcome :-/
>>> =

>>> Well, from the codec POV, the SPDIF in is straightly connected from
>>> the pin to the audio in widget, so there should be no special thing
>>> there.  The possibly missing setup is the vendor-specific things, and
>>> Apple has been implementing the stuff always in a wild manner,
>>> e.g. doing via VREF, GPIO or whatever.
>> =

>> Did you check anything in this proc file codec setup I posted?
>> =

>> As far as I can see on schematics for the MacBook (e.g.. google returned
>> a APPLE_M42C_FA522_Macbook.pdf) the optical module RX output
>> seems to be =93directly" attached to the codec=92s spdif-in pin.
>> =

>> Yet on both, the MacBook as well on the MacBook Pro
>> I found no way to get any digital input captured. The same setup
>> works when booted in macOS, as well as when I plug
>> in my digital audio source into my aging maudio delta 1010,
>> with Linux, which, however, I do not want to continuously use for
>> this setup, =85
>> =

>> It=92s a pity, I don=92t think there are so many other laptops with
>> optical input :-/
> =

> For the MacBook Pro I googled the i/o board schematics
> (820-2273 LIO.pdf) - unfortunately some lines are crippled / strange
> rectangles. However, it most likely spdif-in is directly connected like in
> the MacBook. The schematic calls the codec a ALC885 instead of the
> ALC889A as indicated by ALSA, =85  And the schematic labels the
> codec spdif innput pin SPDIFI/EAPD/MIDI-I/DMIC-R. However,
> the public ALC885 spec has a footnote =93MIDI function is not
> supported as pins 46 and 48 are assigned as S/PDIF IO=94 and for the
> DMIC: =93pin 47 can be configured to support a secondary digital mic
> input (DMIC-R). It is supported via a customized Realtek driver=94
> =

> It is not getting better, =85
> =

> 	:-/
> =

> -- =

> ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
> http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://=
t2-project.org | http://rene.rebe.de
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 DE Legal: Amtsgericht Berlin (Charlottenburg) HRB 105123B, Tax-ID#: DE2516=
02478
 Managing Director: Ren=E9 Rebe
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de

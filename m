From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: HDA Intel ALC889A optical optical spdif in
Date: Fri, 21 Apr 2017 22:29:44 +0200
Message-ID: <0F0E6DC8-D7B8-4EF9-BD47-8AAC124E3665@exactcode.de>
References: <4D425EDE-3FF5-4895-B469-58977B887FAC@exactcode.de>
 <C4DF4DD1-F0E9-4537-B68E-6635FD8902E6@exactcode.de>
 <55213C5F-29CA-49C6-AE16-283BAE9534DF@exactcode.de>
 <s5ho9vpmygb.wl-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 17AC126727F
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 22:29:58 +0200 (CEST)
In-Reply-To: <s5ho9vpmygb.wl-tiwai@suse.de>
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

Hi,

On Apr 21, 2017, at 20:01, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 21 Apr 2017 19:22:16 +0200,
> Ren=E9 Rebe wrote:
>> =

>> On Apr 21, 2017, at 18:37, Ren=E9 Rebe <rene@exactcode.de> wrote:
>> =

>>> Hello again,
>>> =

>>> so I checked the MacBook schematics and it looks like the optical input=
 should be directly connected to pin 47 (GPIO3/SPDIFIN)
>>> =

>>> Maybe EAPD get=92s accidentally / wrongly enabled? - Maybe someone can =
point me how to double check this in ALSA?
>> =

>> I the meantime I finally figured out how this debug verb setting should =
work via:
>> =

>> # hda-verb /dev/snd/hwC0D0 0x14 0x70C 0
>> nid =3D 0x14, verb =3D 0x70c, param =3D 0x0
>> value =3D 0x0
>> # hda-verb /dev/snd/hwC0D0 0x15 0x70C 0
>> nid =3D 0x15, verb =3D 0x70c, param =3D 0x0
>> value =3D 0x0
>> =

>> which made no difference either, and the ALC889 spec reads =93when pin
>> widget  SPDIF-IN is not connected via the programming configuration
>> register.=94
>> =

>> Could that be a missing bit?
>> =

>> Any pointer or verbs I should poke welcome :-/
> =

> Well, from the codec POV, the SPDIF in is straightly connected from
> the pin to the audio in widget, so there should be no special thing
> there.  The possibly missing setup is the vendor-specific things, and
> Apple has been implementing the stuff always in a wild manner,
> e.g. doing via VREF, GPIO or whatever.

Did you check anything in this proc file codec setup I posted?

As far as I can see on schematics for the MacBook (e.g.. google returned
a APPLE_M42C_FA522_Macbook.pdf) the optical module RX output
seems to be =93directly" attached to the codec=92s spdif-in pin.

Yet on both, the MacBook as well on the MacBook Pro
I found no way to get any digital input captured. The same setup
works when booted in macOS, as well as when I plug
in my digital audio source into my aging maudio delta 1010,
with Linux, which, however, I do not want to continuously use for
this setup, =85

It=92s a pity, I don=92t think there are so many other laptops with
optical input :-/

	Ren=E9

-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de

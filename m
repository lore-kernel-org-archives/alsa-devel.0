From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: hda: sink info in case of AMD Radeon GPU card (no
	ELD?)
Date: Wed, 17 Apr 2013 14:08:00 +0200
Message-ID: <CACna6ryEYmqv7_6qpcUouABsK-QtnBdJnLzaRsJC7eDW8WsbJg@mail.gmail.com>
References: <CACna6rymTWUCcaibDzV8tXN509xmRTXh31SYb7C89cQX=5RJcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c249f65b3d5504da8d567a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B325B261639
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 14:08:01 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id k14so1495082oag.38
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 05:08:00 -0700 (PDT)
In-Reply-To: <CACna6rymTWUCcaibDzV8tXN509xmRTXh31SYb7C89cQX=5RJcg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001a11c249f65b3d5504da8d567a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2013/1/19 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>:
> Hello,
>
> I'm interested in polishing HDMI audio support for Radeon cards and I
> hope to get some help here. One of the current problems is that hda
> has no information about TV audio capabilities. It results in a well
> known:
> ALSA sound/pci/hda/hda_eld.c:337 HDMI: ELD buf size is 0, force 128
> ALSA sound/pci/hda/hda_eld.c:356 HDMI: invalid ELD data byte 0
> It's expected, as radeon (GPU driver) doesn't pass ELD struct anywhere
> to the GPU and it's not done automatically neither.
>
> Unfortunately it doesn't seem to be trivial to solve. You may be
> familiar with other GPUs like Nvidia or Intel, where it's done in a
> pretty simple way, for example:
>> for (i =3D 0; i < len; i++)
>>       I915_WRITE(hdmiw_hdmiedid, *((uint32_t *)eld + i));
> but it can't be handled that way on Radeon cards.
>
> If you take a look at evergreend.h [0] you can see we can't simply
> write ELD to the GPU buffer, but we have to fill specific registers
> which look more like SADs (Short Audio Descriptors).
>
> My question is how to handle this on the alsa side. We can't just read
> ELD, we probably have to read some registers from the audio card. Is
> something like that implemented anywhere else? Did anyone started
> working on it? Anyone interested in it?
>
> [0] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dbl=
ob;f=3Ddrivers/gpu/drm/radeon/evergreend.h;hb=3DHEAD

I tried hacking this sink info problem again. I've installed "fglrx"
on my AMD Radeon HD 6970M (BARTS =3D=3D DCE5) and verified it sets SAD
registers:
5f84        7f077f07
5f88        00500705
5f8c        00000001
5f90        00000001
5f94        00000001
5f98        00000001
5f9c        00c01e05
5fa0        00000001
5fa4        00000001
5fa8        00000607
5fac        00017e07
5fb0        00007e07
5fb4        00000001
5fb8        00000001

Reading ELD of course doesn't work (that's why we get warning in
dmesg) and I did some manual confirmation with hda-verb (reading ELD
length):
$ sudo ./hda-verb /dev/snd/hwC1D0 3 0xf2e 0x8
nid =3D 0x3, verb =3D 0xf2e, param =3D 0x8
value =3D 0x0

Plus (just for sure) reading first byte of ELD (in case length is
always zero, but data is available):
$ sudo ./hda-verb /dev/snd/hwC1D0 3 0xf2f 0 | grep val
value =3D 0x0
$ sudo ./hda-verb /dev/snd/hwC1D0 3 0xf2f 1 | grep val
value =3D 0x0
$ sudo ./hda-verb /dev/snd/hwC1D0 3 0xf2f 2 | grep val
value =3D 0x0

So it seems ELD is really not available in this configuration. I
thought about vendor specific verbs. Maybe values from the GPU
registers are just copied to the audio? I've tried reading every
possible vendor specific verb with the attached script (verbs.php).

Unfortunately any verb didn't return anything interesting :(
> grep value verbs.txt | sort | uniq -c
9336832 value =3D 0x0
  18432 value =3D 0x1
   6144 value =3D 0x40
   2048 value =3D 0x415f
  55296 value =3D 0x86
   2048 value =3D 0xa6
  16384 value =3D 0xb6

Does anyone have any idea how we can/should read that values from GPU
in the audio driver? :| I guess the must be copied somewhere, but
can't find the correct place.

--=20
Rafa=C5=82

--001a11c249f65b3d5504da8d567a
Content-Type: application/x-httpd-php; name="verbs.php"
Content-Disposition: attachment; filename="verbs.php"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hfmghh0k0

PD9waHAKZm9yICgkdmVyYiA9IDB4ZjcwOyAkdmVyYiA8IDB4MTAwMDsgJHZlcmIrKykgewoJZm9y
ICgkbmlkID0gMzsgJG5pZCA8IDQ7ICRuaWQrKykgewoJCWZvciAoJHBhciA9IDB4MDAwMDsgJHBh
ciA8IDB4MTAwMDA7ICRwYXIrKykgewoJCQkkY21kID0gc3ByaW50Zigic3VkbyAuL2hkYS12ZXJi
IC9kZXYvc25kL2h3QzFEMCAlZCAweCV4ICVkXG4iLCAkbmlkLCAkdmVyYiwgJHBhcik7CgkJCXN5
c3RlbSgkY21kKTsKCQl9Cgl9Cn0KPz4K
--001a11c249f65b3d5504da8d567a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a11c249f65b3d5504da8d567a--

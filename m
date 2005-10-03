From: "Peter Zubaj" <pzad@pobox.sk>
Subject: Re: Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
Date: Mon, 03 Oct 2005 08:23:28 +0200
Message-ID: <7a5967f2d895440aa1ca2fa1d201c380__11261.0591961586$1128320798$gmane$org@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from paegas2.mail-atlas.net (paegas2.mail-atlas.net [212.47.13.187])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B8F451B9
	for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2005 08:23:49 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Jones <davej@redhat.com>
Cc: alsa-devel@alsa-project.org, James@superbug.co.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

AFAIK this was fixed in CVS=2E Two cards have same model id (one has AC=
97, one not)=2E

Fix:

http://sourceforge=2Enet/mailarchive/forum=2Ephp?thread_id=3D8360485&fo=
rum_id=3D33141

Peter Zubaj

>-----P?vodn? spr?va-----
>Od: Dave Jones [mailto:davej@redhat=2Ecom]
>Odoslan?: 3=2E okt?bra 2005 1:28
>Komu: Linux Kernel Mailing List
>K?pia: alsa-devel@alsa-project=2Eorg; James@superbug=2Eco=2Euk; perex@=
suse=2Ecz
>Predmet: [Alsa-devel] Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a err=
or recognising the SB Live Platinum=2E
>
>
>On Tue, Sep 13, 2005 at 12:07:43PM -0700, Linux Kernel wrote:
>> tree b885c7a937061624c7f7e34444122b96cced5c16
>> parent 1b44c28dc180f4d0ea109e1fe4339b3403c2d530
>> author James Courtier-Dutton <James@superbug=2Eco=2Euk> Sat, 10 Sep =
2005 10:24:10 +0200
>> committer Jaroslav Kysela <perex@suse=2Ecz> Mon, 12 Sep 2005 10:48:3=
2 +0200
>>
>> [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Li=
ve Platinum=2E
>>
>> EMU10K1/EMU10K2 driver
>> The card does not have an AC97 chip=2E
>> =2Esubsystem =3D 0x80611102
>>
>> Signed-off-by: James Courtier-Dutton <James@superbug=2Eco=2Euk>
>>
>>  sound/pci/emu10k1/emu10k1_main=2Ec |    5 ++---
>>  1 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/pci/emu10k1/emu10k1_main=2Ec b/sound/pci/emu10k1/=
emu10k1_main=2Ec
>> --- a/sound/pci/emu10k1/emu10k1_main=2Ec
>> +++ b/sound/pci/emu10k1/emu10k1_main=2Ec
>> @@ -754,12 +754,11 @@ static emu_chip_details_t emu_chip_detai
>>  =09 =2Eemu10k1_chip =3D 1,
>>  =09 =2Eac97_chip =3D 1,
>>  =09 =2Esblive51 =3D 1} ,
>> -=09/* Tested by alsa bugtrack user "hus" 12th Sept 2005 */
>> +=09/* Tested by alsa bugtrack user "hus" bug #1297 12th Aug 2005 */
>>  =09{=2Evendor =3D 0x1102, =2Edevice =3D 0x0002, =2Esubsystem =3D 0x=
80611102,
>> -=09 =2Edriver =3D "EMU10K1", =2Ename =3D "SBLive! Player 5=2E1 [SB0=
060]",
>> +=09 =2Edriver =3D "EMU10K1", =2Ename =3D "SBLive! Platinum 5=2E1 [S=
B0060]",
>>  =09 =2Eid =3D "Live",
>>  =09 =2Eemu10k1_chip =3D 1,
>> -=09 =2Eac97_chip =3D 1,
>>  =09 =2Esblive51 =3D 1} ,
>>  =09{=2Evendor =3D 0x1102, =2Edevice =3D 0x0002, =2Esubsystem =3D 0x=
80511102,
>>  =09 =2Edriver =3D "EMU10K1", =2Ename =3D "SBLive! Value [CT4850]",
>
>That last line change reverts=2E=2E
>
>tree efc4e418c80bf61beb2e1cfd1b2db405b471111f
>parent 9970dce56686d7b71310388025d8925d3d29e6ec
>author Takashi Iwai <tiwai@suse=2Ede> Fri, 26 Aug 2005 17:26:40 +0200
>committer Jaroslav Kysela <perex@suse=2Ecz> Tue, 30 Aug 2005 08:47:46 =
+0200
>
>[ALSA] emu10k1 - Add missing ac97 support on SBLive! Player 5=2E1
>
>EMU10K1/EMU10K2 driver
>Added the missing ac97 support on SBLive! Player 5=2E1=2E
>
>And makes peoples volume sliders disappear, which tends to upset folks=
=2E
>See https://bugzilla=2Eredhat=2Ecom/bugzilla/show_bug=2Ecgi?id=3D16915=
2
>for reference=2E
>
>Signed-off-by: Dave Jones <davej@redhat=2Ecom>
>
>--- linux-2=2E6=2E13/sound/pci/emu10k1/emu10k1_main=2Ec~=092005-10-02 =
21:26:40=2E000000000 -0400
>+++ linux-2=2E6=2E13/sound/pci/emu10k1/emu10k1_main=2Ec=092005-10-02 2=
1:26:57=2E000000000 -0400
>@@ -759,6 +759,7 @@ static emu_chip_details_t emu_chip_detai
>=2Edriver =3D "EMU10K1", =2Ename =3D "SBLive! Platinum 5=2E1 [SB0060]"=
,
>=2Eid =3D "Live",
>=2Eemu10k1_chip =3D 1,
>+=09 =2Eac97_chip =3D 1,
>=2Esblive51 =3D 1} ,
>{=2Evendor =3D 0x1102, =2Edevice =3D 0x0002, =2Esubsystem =3D 0x805111=
02,
>=2Edriver =3D "EMU10K1", =2Ename =3D "SBLive! Value [CT4850]",
>
>
>
>-------------------------------------------------------
>This SF=2ENet email is sponsored by:
>Power Architecture Resource Center: Free content, downloads, discussio=
ns,
>and more=2E http://solutions=2Enewsforge=2Ecom/ibmarch=2Etmpl
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists=2Esourceforge=2Enet
>https://lists=2Esourceforge=2Enet/lists/listinfo/alsa-devel



Aktivujte si neobmedzenu mailovu schranku na www.pobox.sk!




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

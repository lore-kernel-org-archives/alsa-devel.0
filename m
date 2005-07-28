From: Nicolas GRAZIANO <nicolas.graziano@wanadoo.fr>
Subject: Re: [PATCH] hda driver, correct bug in model "auto"
Date: Thu, 28 Jul 2005 20:32:41 +0200
Message-ID: <42E924C9.6070602@wanadoo.fr>
References: <42DD71DC.1090002@wanadoo.fr>	<s5hirywlhdf.wl%tiwai@suse.de>	<42E7D338.60904@wanadoo.fr> <s5hk6jbti30.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix4-2.free.fr (postfix4-2.free.fr [213.228.0.176])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5663E15D
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2005 20:32:44 +0200 (MEST)
In-Reply-To: <s5hk6jbti30.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai a =E9crit :

>At Wed, 27 Jul 2005 20:32:24 +0200,
>Nicolas GRAZIANO wrote:
> =20
>
>>Takashi Iwai a =E9crit :
>>   =20
>>
>>>At Tue, 19 Jul 2005 23:34:20 +0200,
>>>Nicolas GRAZIANO wrote:
>>>     =20
>>>
>>>>- Correct the channels order in model autodetection (not sure of this
>>>>part, I need validation)
>>>>  =20
>>>>
>>>>       =20
>>>>
>>>I think this is not correct (although I'm not 100% sure, too).
>>>The association order is front/clfe/surround/side.
>>>(The comment in hda_codec.c is wrong.)
>>>
>>>     =20
>>>
>>I make the modification because I was thinking than the order was
>>front/clfe/side/back (aka surround ?) and the text on back panel of my
>>motherboard (ASUS P5AD2) make me more confident (with my modification
>>the channels are at the right place). Can we check with an other
>>card/codec ?
>>   =20
>>
>
>Hmm, interesting.  So, on your board, the association 3 (4th)
>corresponds to a surround jack?
>
> =20
>
I am not sure to understand what you mean.=20
But perhaps the following information will help.
On the back pannel the inscription are :
Green ()-> Front
Orange ()-> Ctr Bass
Black ()-> Side SPK
Grey ()-> Rear SPK

Extract of the /proc/asound/Intel/codec#0 order by the sequence number
(last byte of Pincap):

Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green

Node 0x1f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01016012: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Orange

Node 0x0e [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x081033f: IN OUT HP
  Pin Default 0x01011014: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Black

Node 0x20 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01012016: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Grey


with my modification :

$speaker-test -D hw:0,0 -c8
 0 - Front Left  --> Green Jack
 4 - Center    --> Orange left
 1 - Front Right  --> Green Jack
 7 - Side Right   --> Black Jack
 3 - Rear Right  --> Grey Jack
 2 - Rear Left   --> Grey Jack
 6 - Side Left  --> Black Jack
 5 - LFE   --> nothing

without  my modification (actual cvs code):

$speaker-test -D hw:0,0 -c8
 0 - Front Left  -->  Green Jack
 4 - Center    --> black Jack
 1 - Front Right  -->  Grenn Jack
 7 - Side Right   -->   nothing
 3 - Rear Right  --> orange Jack
 2 - Rear Left   --> orange Jack
 6 - Side Left  -->  Grey Jack
 5 - LFE   --> black Jack

I hope this information will help.


>Sure, just add a hda_board_config entry for the corresponding pci
>subids.  See patch_realtek.c.
>
> =20
>
I try the following path for my ASUS P5AD2 and it's working.
thanks

Nicolas

Index: pci/hda/patch_cmedia.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_cmedia.c,v
retrieving revision 1.11
diff -u -r1.11 patch_cmedia.c
--- pci/hda/patch_cmedia.c      27 Jul 2005 16:25:08 -0000      1.11
+++ pci/hda/patch_cmedia.c      28 Jul 2005 18:22:45 -0000
@@ -647,6 +647,8 @@
        { .modelname =3D "min_fp", .config =3D CMI_MIN_FP },
        { .modelname =3D "full", .config =3D CMI_FULL },
        { .modelname =3D "full_dig", .config =3D CMI_FULL_DIG },
+       { .pci_subvendor =3D 0x1043, .pci_subdevice =3D 0x813d, .config =3D
CMI_FULL_DIG },
+
        { .modelname =3D "allout", .config =3D CMI_ALLOUT },
        { .modelname =3D "auto", .config =3D CMI_AUTO },
        {} /* terminator */








-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

From: =?ISO-8859-1?Q?Jean-Pierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Wed, 04 Feb 2009 18:01:26 +0100
Message-ID: <4989C9E6.7070902@wanadoo.fr>
References: <4983FE7A.1040201@wanadoo.fr> <49840333.2080303@wanadoo.fr>
	<200902021620.52104.herton@mandriva.com.br>
	<49884B73.7050906@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp20.orange.fr (smtp20.orange.fr [80.12.242.26])
	by alsa0.perex.cz (Postfix) with ESMTP id BDA3B1038D4
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 18:01:28 +0100 (CET)
In-Reply-To: <49884B73.7050906@wanadoo.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, tim.barnette@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Herton,

I have identified why applying your patch broke the sound worse on my
computer, by reverting each individual modification until the sound
comes back. It has not brought overall improvements for me, but this
might help you getting it right.

On my computer, the main problem is an IRQ one, which I knew you did
not address, but I still wanted to know if something would improve
(see below)

Jean-Pierre Andr=E9 wrote:
> Hi Herton,
>
> Thank you for trying to sort his out,
>
> Herton Ronaldo Krzesinski wrote:
>> Em S=E1bado 31 Janeiro 2009, =E0s 05:52:19, Jean-Pierre Andr=E9 escreveu:
>>  =

>>> Hi,
>>>
>>>    =

>>>> Hi all, I have an HP DV4 1155-SE, I've been unable to get sound =

>>>> working
>>>> through the speakers, although it does work through the headhpones. =

>>>> I ran
>>>> alsa-.upgrade which downloaded compiled, and installed 1.0.19 - =

>>>> still no
>>>> luck.
>>>>         =

>>> I have the same IDT codec 92HD71B7X on another
>>> HP DV4 model, and I have tracked the problem to be
>>> the kernel configuring IRQ 22 through the APIC, but
>>> interrupts triggerring IRQ 20 (on kernel 2.6.27 and
>>> alsa 1.0.19). It would be interesting if you could
>>> confirm this by analyzing /proc/interrupts.
>>>
>>> The workarounds I know of are :
>>> - adding irqpoll to the boot options,
>>> - or adding noapic to the boot options,
>>> - using mplayer to play music.
>>>
>>> There are with option "snd-hda-intel model=3Dhp-m4"
>>> (this option is for HP DV5/DV7, but HP DV4
>>> is probably different)
>>>
>>> I have not enough knowledge to tell where the problem
>>> lies : kernel, apic, alsa.
>>>     =

>>
>> It looks like some of these HP laptops have some sort of IRQ issue =

>> indeed, to me it was reported that enabling pci MSI (both system wide =

>> and with enable_msi=3D1 given to snd-hda-intel) cured issues in some =

>> cases, along with some changes to sigmatel codec handling code in =

>> snd-hda-intel   =

>
> Thank you for your suggested patches. I had some difficulties in
> applying them as your reference version is not from the lasted build.
> (for instance from alsa-driver-1.0.19.0.g5aa59.6.gb162b.tar.bz2)
> Actually, to get patch_sigmatel to compile, I had to reintegrate
> old deprecated code. Attached are the patches I really applied.
>
> And the result is worse than before : no sound at all, using option
> "model hp-m4-2", as I see in the patch that this was designed for
> my sound device (subsystem id 0x30f7). I am also using option
> enable_msi=3D1.

Your patch contained the following, mostly deleting code which was =

replaced :

-    switch (spec->board_config) {
-    case STAC_HP_M4:
-        /* enable internal microphone */
-        stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
-        stac92xx_auto_set_pinctl(codec, 0x0e,
-            AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
-        /* fallthru */
-    case STAC_DELL_M4_2:
-        spec->num_dmics =3D 0;
-        spec->num_smuxes =3D 0;
-        spec->num_dmuxes =3D 0;
-        break;
-    case STAC_DELL_M4_1:
-    case STAC_DELL_M4_3:
-        spec->num_dmics =3D 1;
-        spec->num_smuxes =3D 0;
-        spec->num_dmuxes =3D 0;
-        break;
-    default:
-        spec->num_dmics =3D STAC92HD71BXX_NUM_DMICS;
-        spec->num_smuxes =3D ARRAY_SIZE(stac92hd71bxx_smux_nids);
-        spec->num_dmuxes =3D ARRAY_SIZE(stac92hd71bxx_dmux_nids);
-    };
 =

     spec->multiout.num_dacs =3D 1;
     spec->multiout.hp_nid =3D 0x11;
     spec->multiout.dac_nids =3D stac92hd71bxx_dac_nids;
-    if (spec->dinput_mux)
-        spec->private_dimux.num_items +=3D
+    spec->private_dimux.num_items +=3D
             spec->num_dmics -
                 (ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1);

The main bad thing is the following line which is indicated as
unchanged, but which does not appear in alsa 1.0.19, so I cannot
tell if this line is wrong by itself or if this line requires some
other code not present in alsa 1.0.19. With this line present I
get no sound at all :

     spec->multiout.num_dacs =3D 1;

The second point is you have deleted and not replaced the
following :

-        /* enable internal microphone */
-        stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
-        stac92xx_auto_set_pinctl(codec, 0x0e,
-            AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);

This line is required to get a PCM control in the sound volume
controls. It is also related to getting the following in the syslog :

Line In at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/input/input61

To me, "internal microphone", "PCM control" and "Line In at Ext Rear Jack"
are different things (and in my computer there is no rear jack !), so
there must be something wrong in the configuration.

With these two changes to your patch, I get the same results as with
alsa 1.0.19.

This was tested on a HP dv4-1115ef, with a sound device identified as :

Codec: IDT 92HD71B7X
Codec: Generic 10de ID 3
vendor id : 111d76b2
subsyst id  103c30f7
revis  id     100302


Regards

Jean-Pierre

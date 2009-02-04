From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Wed, 4 Feb 2009 15:49:53 -0200
Message-ID: <200902041549.54154.herton@mandriva.com.br>
References: <4983FE7A.1040201@wanadoo.fr> <49884B73.7050906@wanadoo.fr>
	<4989C9E6.7070902@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id C61B61038DA
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 18:49:39 +0100 (CET)
In-Reply-To: <4989C9E6.7070902@wanadoo.fr>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, tim.barnette@gmail.com, Jean-Pierre =?iso-8859-1?q?Andr=E9?= <jean-pierre.andre@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

Em Quarta-feira 04 Fevereiro 2009, =E0s 15:01:26, Jean-Pierre Andr=E9 escre=
veu:
> Hi Herton,
>
> I have identified why applying your patch broke the sound worse on my
> computer, by reverting each individual modification until the sound
> comes back. It has not brought overall improvements for me, but this
> might help you getting it right.

Hmm yes, for now just disregard my original patch, I think the default pin =

configs inside it are not right/needed for HP laptops.

>
> On my computer, the main problem is an IRQ one, which I knew you did
> not address, but I still wanted to know if something would improve
> (see below)

<snip>

> Your patch contained the following, mostly deleting code which was
> replaced :
>
> -    switch (spec->board_config) {
> -    case STAC_HP_M4:
> -        /* enable internal microphone */
> -        stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
> -        stac92xx_auto_set_pinctl(codec, 0x0e,
> -            AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
> -        /* fallthru */
> -    case STAC_DELL_M4_2:
> -        spec->num_dmics =3D 0;
> -        spec->num_smuxes =3D 0;
> -        spec->num_dmuxes =3D 0;
> -        break;
> -    case STAC_DELL_M4_1:
> -    case STAC_DELL_M4_3:
> -        spec->num_dmics =3D 1;
> -        spec->num_smuxes =3D 0;
> -        spec->num_dmuxes =3D 0;
> -        break;
> -    default:
> -        spec->num_dmics =3D STAC92HD71BXX_NUM_DMICS;
> -        spec->num_smuxes =3D ARRAY_SIZE(stac92hd71bxx_smux_nids);
> -        spec->num_dmuxes =3D ARRAY_SIZE(stac92hd71bxx_dmux_nids);
> -    };
>
>      spec->multiout.num_dacs =3D 1;
>      spec->multiout.hp_nid =3D 0x11;
>      spec->multiout.dac_nids =3D stac92hd71bxx_dac_nids;
> -    if (spec->dinput_mux)
> -        spec->private_dimux.num_items +=3D
> +    spec->private_dimux.num_items +=3D
>              spec->num_dmics -
>                  (ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1);
>
> The main bad thing is the following line which is indicated as
> unchanged, but which does not appear in alsa 1.0.19, so I cannot
> tell if this line is wrong by itself or if this line requires some
> other code not present in alsa 1.0.19. With this line present I
> get no sound at all :
>
>      spec->multiout.num_dacs =3D 1;
>
> The second point is you have deleted and not replaced the
> following :
>
> -        /* enable internal microphone */
> -        stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
> -        stac92xx_auto_set_pinctl(codec, 0x0e,
> -            AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
>
> This line is required to get a PCM control in the sound volume
> controls. It is also related to getting the following in the syslog :
>
> Line In at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/input/input61
>
> To me, "internal microphone", "PCM control" and "Line In at Ext Rear Jack"
> are different things (and in my computer there is no rear jack !), so
> there must be something wrong in the configuration.

I don't know now if the default pin configs in my patch had something =

missing/wrong, or something in current patch_sigmatel.c autoconfig code nee=
ds =

this additional forced line-in to avoid hitting some case, but I thought it=
's =

better to let away the pin configs I added. In the new patches I rebased an=
d =

posted the forced line-in is left unchanged.

>
> With these two changes to your patch, I get the same results as with
> alsa 1.0.19.
>
> This was tested on a HP dv4-1115ef, with a sound device identified as :
>
> Codec: IDT 92HD71B7X
> Codec: Generic 10de ID 3
> vendor id : 111d76b2
> subsyst id  103c30f7
> revis  id     100302
>
>
> Regards
>
> Jean-Pierre

--
[]'s
Herton

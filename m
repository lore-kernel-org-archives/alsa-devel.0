From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: Patches to azx/patch_realtek.c
Date: Wed, 15 Dec 2004 14:34:44 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE435@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai [mailto:tiwai@suse.de]=20
>=20
> At Wed, 15 Dec 2004 13:47:26 -0800,
> Stephen Warren wrote:
> >=20
> > * realtek.4.diff
> >=20
> > spec->front_panel is no longer used, after Takashi's latest=20
> changes. So,
> > remove it from the structure.
>=20
> I'd like to keep this information in case we'll need some hacks for
> the front panel switching or any boards without front panel in
> future.

OK. I can put that back in. But looking at your latest code, it says
this:

	switch (spec->board_config) {
	case ALC880_3ST_DIG:
	case ALC880_5ST_DIG:
		spec->digital =3D 1;
		spec->front_panel =3D 1;
		break;
	case ALC880_3ST:
	case ALC880_5ST:
		spec->front_panel =3D 1;
		break;
	}

Which would set front_panel all the time, except for ACL880_MINIMAL. Is
this correct?

> > * realtek.5.diff
> >=20
> > Stop functions directly referencing global variables for=20
> configuration
> > tables - put pointers to the tables into the spec data structure.
> >=20
> > This allows alc880_init to point spec at different sets of data
> > structures if it needs, and also stops code from knowing about
> > spec->five_stack, and doing different things depending on the board
> > type.
>=20
> If we do this, let's merge alc260 code, too :)

That's the next patch in the series:-)

> Maybe it's better to use the array of mixer elem lists than
> having separate spec->base_mixer and spec->side_mixer as the
> generalization.

So, have this: ?

struct alc_mixer {
    snd_kcontrol_new_t *controls;
    int num_controls;
};

struct alc_spec {
    struct alc_mixer mixers[2];
    int num_mixers;
};

And have all the code loop over mixers[0..num_mixers-1]

By the way, when an array of had_verb is passed to
snd_hda_sequence_write, this function looks for a "blank" entry in the
array to stop at. However, when passing arrays of snd_kcontrol_new_t to
snd_hda_add_new_ctls, we have to tell it the size, which means we have
to store that too. Can we make the utility code that processes arrays of
snd_kcontrol_new_t look for empty entries too?

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

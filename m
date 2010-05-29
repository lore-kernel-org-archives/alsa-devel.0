From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Sat, 29 May 2010 09:31:17 +0800
Message-ID: <AANLkTinOlPwLDEY8hVHnzLDk_nJ9UNs6qepuoyxoe1SK@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
	<4BF658C6.4030404@ladisch.de>
	<AANLkTik7mD1DAVWkOwM7sNu0EfgGApvzX9WRXWBOO4PI@mail.gmail.com>
	<4BFB8E3E.3010209@ladisch.de>
	<AANLkTin7CGFuW_fhHEbhaDB77DLbKoTvck7YvuzVzGUw@mail.gmail.com>
	<4BFBE056.9000706@ladisch.de>
	<AANLkTinxF-OdPg_mZabDfupb_knV0uh2bslOQeBXyDgp@mail.gmail.com>
	<4BFFCEF3.9060309@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BE50243F0
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 03:31:18 +0200 (CEST)
Received: by pzk40 with SMTP id 40so922761pzk.23
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2010 18:31:17 -0700 (PDT)
In-Reply-To: <4BFFCEF3.9060309@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/5/28 Clemens Ladisch <clemens@ladisch.de>

> Raymond Yau wrote:
> > 2010/5/25 Clemens Ladisch <clemens@ladisch.de>
> > > Raymond Yau wrote:
> > > > I have doubt about DECLARE_TLV_DB_LINEAR(ak4396_db_scale,
> TLV_DB_GAIN_MUTE, 0);
> > > >
> > > > since the datasheet mention that dB range is only -48dB to 0dB
> > > >
> > > > ATT =3D 20 log10 (ATT_DATA / 255) [dB]
> > > >
> > > > How can AK4396 has scale of -inf DB to 0dB in the driver code  ?
> > >
> > > When ATT_DATA =3D 0, there is no output, which is an attenuation of -=
inf.
> > > The next value, ATT_DATA =3D 1, results in ATT =3D -48 dB.
> >
> > refer to ice1712/prodigy_hifi.c , why the comment is -64dB to 0dB  ?
> >
> > /*
> >  * DAC volume attenuation mixer control (-64dB to 0dB)
> > */
>
> Apparently just copied from pontis.c.
>
> > static int ak4396_dac_vol_info(struct snd_kcontrol *kcontrol, struct
> snd_ctl_elem_info *uinfo)
> > {
> >         uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
> >         uinfo->count =3D 2;
> >         uinfo->value.integer.min =3D 0;   /* mute */
> >         uinfo->value.integer.max =3D 0xFF; /* linear */
> >        return 0;
> > }
> > ...
> > static const DECLARE_TLV_DB_SCALE(db_scale_wm_dac, -12700, 100, 1);
>
> And this defines a dB scale from -127 dB to +128 dB, which will break
> PulseAudio's volume calculations.
>
> > > This is true regardless of the precision of the multiplier.  Even a
> one-
> > > bit factor behaves like this; in fact, this would describe a mute
> switch.
> >
> > This mean that the dB range should be calculated from the next step abo=
ve
> > the min_dB and max_dB when min_dB regarded as a mute switch
>
> No; the AK4396 datasheet mentions -48 dB only because this is the minimum
> attenuation that isn't completely mute.  The minimum of the ATT_DATA
> registers _is_ zero, i.e. -inf dB, and therefore TLV_DB_GAIN_MUTE is the
> correct minimum for the dB range.
>
>
The AK4396 includes channel independent digital output volumes (ATT) with
256 levels at linear step including MUTE.
These volumes are in front of the DAC and can attenuate the input data from
0dB to =9648dB and mute.

It only mention the volume can be attenuate to -48dB and MUTE

some driver are using SMUTE (soft mute) and soft mute enable : default is
OFF

As James said , DB_LINEAR is limited to 0dB as Max , how can you provide a
dB scale for the capture volume control of pulseaudio

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - alsa-lib] tlv: Check dB range only within
	the control's volume range
Date: Wed, 19 May 2010 10:28:55 +0300
Message-ID: <201005191028.55258.peter.ujfalusi@nokia.com>
References: <1274249966-31030-1-git-send-email-peter.ujfalusi@nokia.com>
	<alpine.LNX.2.00.1005190854200.6856@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id F17B324560
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 09:30:18 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1005190854200.6856@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 19 May 2010 09:55:40 ext Jaroslav Kysela wrote:
> On Wed, 19 May 2010, Peter Ujfalusi wrote:
> > The DB_RANGE need to be used on some HW, since the gain on
> > volume control is not continuous, and has to be divided into
> > several sub DB_SCALE ranges.
> > ASoC has a feature to override the HW default volume range,
> > and in this case when the volume range is less than the
> > HW maximum we do not need to go through the whole DB_RANGE,
> > but we need to stop where the kcontrol's maximum tell us.
> > =

> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> =

> Unfortunately, it does not look like a clean way in my eyes. If the driver
> pushes some limits to the control (volume) range, it should do it also
> for TLVs.

My thinking was that the snd_tlv_get_dB_range SNDRV_CTL_TLVT_DB_RANGE case =

should obey the control's range provided by the driver, similarly how the =

SNDRV_CTL_TLVT_DB_SCALE is using the rangemax, rangemin.
In case of SNDRV_CTL_TLVT_DB_RANGE, we should not go beyond the control's =

rangemax.

In this way both of the following volume control is going to be handled =

correctly:

1.
static DECLARE_TLV_DB_SCALE(dac_digivol_tlv, -6350, 50, 0);

static const struct snd_kcontrol_new dac33_snd_controls[] =3D {
	SOC_DOUBLE_R_TLV("DAC Digital Playback Volume",
		DAC33_LDAC_DIG_VOL_CTRL, DAC33_RDAC_DIG_VOL_CTRL,
		0, 0x7f, 1, dac_digivol_tlv),
};

Original range (127): -63.5 .. 0 dB
Limited range  (100): -63.5 .. -13.5 dB

2.
static const unsigned int tpa6140_tlv[] =3D {
	TLV_DB_RANGE_HEAD(3),
	0, 8, TLV_DB_SCALE_ITEM(-5900, 400, 0),
	9, 16, TLV_DB_SCALE_ITEM(-2500, 200, 0),
	17, 31, TLV_DB_SCALE_ITEM(-1000, 100, 0),
};

static const struct snd_kcontrol_new tpa6140a2_controls[] =3D {
	SOC_SINGLE_EXT_TLV("TPA6140A2 Headphone Playback Volume",
		       TPA6130A2_REG_VOL_MUTE, 1, 0x1f, 0,
		       tpa6130a2_get_volsw, tpa6130a2_put_volsw,
		       tpa6140_tlv),
};

Original range (31): -59 .. 4 dB
Limited range  (21): -59 .. -6 dB
Limited range  (16): -59 .. -11 dB

In case of DB_SCALE in theory the maximum gain depends on the maximum volum=
e =

possible on the control.
When the gain is not linear, it has to divided into sub DB_SCALE sections t=
o get =

accurate mapping.
Now, if the kernel code for the limiting has to do more than changing the =

maximum volume, than it means that it _has_ to rewrite the TLV table in a c=
lever =

way, or provide a new one which fits with the limited volume.
Rewriting the TLV table taking into account all possible cases is not that =
safe, =

and I'm sure there could be still some corners, where it would fail.

I think the patch provides uniform, and error prone way of handling this =

situation, while not breaking any existing parts.

-- =

P=E9ter

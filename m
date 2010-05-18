From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: RFC:
Date: Tue, 18 May 2010 15:39:20 +0300
Message-ID: <201005181539.20802.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 83D06103867
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 14:39:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I apologize for the long mail, but I feel that I need to explain this in a =
bit =

longish way...

ASoC core recently gained support for limiting the volume control's range =

(maximum), which is really useful in embedded systems.
The implementation for this is really simple:
The codec drivers are implementing the full range the HW can support. Machi=
ne =

drivers can than override the maximum volume on a given control if it is =

necessary.
This works well with most of the controls:
Volume controls without dB scale.
Volume controls with DECLARE_TLV_DB_SCALE()

Problems started to emerge, when the volume is limited on control, which ha=
s =

SNDRV_CTL_TLVT_DB_RANGE (from the sound/soc/codecs/tpa6130a2.c):

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

The original HW supported range is 0 .. 31 (-59 .. +4 dB).
When the machine driver sets the limit to 21 (-6 dB), than the volume range=
 is =

reported correctly as 0 .. 21, but snd_mixer_selem_get_playback_dB_range() =

reports range of -59 .. +4 dB. This is not correct, it should report: -59 .=
. -6 =

dB.
If the control has single DECLARE_TLV_DB_SCALE() after the limiting both vo=
lume =

and dB range is reported correctly.

The explanation for this is in the alsa-lib:
src/control/tlv.c:

/**
 * \brief Get the dB min/max values
 * \param tlv the TLV source returned by #snd_tlv_parse_dB_info()
 * \param rangemin the minimum value of the raw volume
 * \param rangemax the maximum value of the raw volume
 * \param min the pointer to store the minimum dB value (in 0.01dB unit)
 * \param max the pointer to store the maximum dB value (in 0.01dB unit)
 * \return 0 if successful, or a negative error code
 */
int snd_tlv_get_dB_range(unsigned int *tlv, long rangemin, long rangemax,
                         long *min, long *max)
{
        int err;

        switch (tlv[0]) {
        case SND_CTL_TLVT_DB_RANGE: {
                unsigned int pos, len;
                len =3D int_index(tlv[1]);
                if (len > MAX_TLV_RANGE_SIZE)
                        return -EINVAL;
                pos =3D 2;
                while (pos + 4 <=3D len) {
                        long rmin, rmax;
                        rangemin =3D (int)tlv[pos];
                        rangemax =3D (int)tlv[pos + 1];
                        err =3D snd_tlv_get_dB_range(tlv + pos + 2,
                                                   rangemin, rangemax,
                                                   &rmin, &rmax);
                        if (err < 0)
                                return err;
                        if (pos > 2) {
                                if (rmin < *min)
                                        *min =3D rmin;
                                if (rmax > *max)
                                        *max =3D rmax;
                        } else {
                                *min =3D rmin;
                                *max =3D rmax;
                        }
                        pos +=3D int_index(tlv[pos + 3]) + 4;
                }
                return 0;
        }
        case SND_CTL_TLVT_DB_SCALE: {
                int step;
                *min =3D (int)tlv[2];
                step =3D (tlv[3] & 0xffff);
                *max =3D *min + (long)(step * (rangemax - rangemin));
                return 0;
        }
        case SND_CTL_TLVT_DB_MINMAX:
        case SND_CTL_TLVT_DB_MINMAX_MUTE:
        case SND_CTL_TLVT_DB_LINEAR:
                *min =3D (int)tlv[2];
                *max =3D (int)tlv[3];
                return 0;
        }
        return -EINVAL;
}

In case of DECLARE_TLV_DB_SCALE(), the SND_CTL_TLVT_DB_SCALE case is taken,=
 and =

the control's maximum, and minimum range are used for the dB scale limit =

calculation.
But, when SNDRV_CTL_TLVT_DB_RANGE is used (tpa6130a2 driver), than that cas=
e =

will dismisses the control's maximum and minimum range, and goes through th=
e =

whole TLV struct, and reports the HW supported range.
If it would stop at the driver reported maximum, than the dB range reported =

would be correct.
So a 'simple' patch to alsa-lib would solve this. But what happens, if we w=
ant =

to limit control, which has DB_MINMAX, DB_MINMAX_MUTE, or DB_LINEAR?
There is no way to actually limit those in a way, that the dB scale reporte=
d =

would be correct. We just stretch the steps bigger, like what happens with =
the =

SNDRV_CTL_TLVT_DB_RANGE in the tpa6130a2 driver.

When looking for users of DB_LINEAR I have found 8 drivers, DB_MINMAX is us=
ed by =

usbmixer only, the DB_MINMAX_MUTE has no users at all.

Since both DB_LINEAR and DB_MINMAX can be presented as DB_SCALE, and the ef=
fort =

to convert the drivers should not be that big.

In this way, we will only have drivers using DB_SCALE in kernel, we can mar=
k the =

other DB_ types as deprecated (but keeping the support for out of tree driv=
ers), =

and the alsa-lib's tlv code can be adjusted to support properly the volume =

limiting. If there is interest, than the ALSA core could also gain support =
for =

platform/configuration dependent volume limiting.

If this is too big change to ALSA (which I think it is not, since for the u=
ser =

it makes no difference, and the volume range, dB scale not going to be chan=
ged), =

than probably cleaning up the sound/soc/ to use _only_ DB_SCALE type for vo=
lume =

controls might be the solution, since the volume limiting feature is only i=
n =

ASoC AFAIK.

Either way, the alsa-lib's src/control/tlv.c:snd_tlv_get_dB_range function =
in =

case of SND_CTL_TLVT_DB_RANGE needs some fix to handle the situation, when =
the =

volume range is _not_ at the HW supported range.

To summarize, I'd like to do (or ask help to do) one of the following
[1] Replace the use of DB_LINEAR, DB_MINMAX with DB_SCALE in all drivers un=
der
    sound/
    Document, that the now unused DB_ types are deprecated
    Fix alsa-lib to support the volume limiting in regards of dB scale
[2] Replace the use of DB_LINEAR with DB_SCALE in all drivers under
    sound/soc/
    Fix alsa-lib to support the volume limiting in regards of dB scale


What do you think?

--
P=E9ter

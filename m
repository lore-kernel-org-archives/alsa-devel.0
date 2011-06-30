From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Via Codecs: functions mute_aa_path() and
 is_aa_path_mute() (file patch_via.c) seem to support different codecs.
Date: Thu, 30 Jun 2011 18:43:19 +0200
Message-ID: <BANLkTi=yAJ3dPSuPVUVDc4fsY3Tk9faxww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 69593103843
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 18:43:20 +0200 (CEST)
Received: by wwi14 with SMTP id 14so952597wwi.2
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2011 09:43:20 -0700 (PDT)
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>, lydiawang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

These functions seem to support different codecs through different
switch statements:

mute_aa_path:

...
	/* get nid of MW0 and start & end index */
	switch (spec->codec_type) {
	case VT1708:
		nid_mixer = 0x17;
		start_idx = 2;
		end_idx = 4;
		break;
	case VT1709_10CH:
	case VT1709_6CH:
		nid_mixer = 0x18;
		start_idx = 2;
		end_idx = 4;
		break;
	case VT1708B_8CH:
	case VT1708B_4CH:
	case VT1708S:
	case VT1716S:
		nid_mixer = 0x16;
		start_idx = 2;
		end_idx = 4;
		break;
	case VT1718S:
		nid_mixer = 0x21;
		start_idx = 1;
		end_idx = 3;
		break;
	default:
		return;
	}



is_aa_path_mute:

...
	/* get nid of MW0 and start & end index */
	switch (spec->codec_type) {
	case VT1708B_8CH:
	case VT1708B_4CH:
	case VT1708S:
	case VT1716S:
		nid_mixer = 0x16;
		start_idx = 2;
		end_idx = 4;
		break;
	case VT1702:
		nid_mixer = 0x1a;
		start_idx = 1;
		end_idx = 3;
		break;
	case VT1718S:
		nid_mixer = 0x21;
		start_idx = 1;
		end_idx = 3;
		break;
	case VT2002P:
	case VT1812:
	case VT1802:
		nid_mixer = 0x21;
		start_idx = 0;
		end_idx = 2;
		break;
	default:
		return 0;
	}



It would seem that AA-path can be muted but not inquired for mute
state for codecs VT1708, VT1709_10CH and VT1709_6CH, vice-versa for
codecs VT1702, VT2002P, VT1812, VT1802. If this is the real way such
codecs work, I wonder if analog_input_switch_put() works as expected
for codec VT1708, in which case, perhaps, it should be modified:


static int analog_input_switch_put(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	int change = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);

	set_widgets_power_state(codec);
	analog_low_current_mode(snd_kcontrol_chip(kcontrol), -1);
	if (snd_hda_get_bool_hint(codec, "analog_loopback_hp_detect") == 1) {
		if (is_aa_path_mute(codec))
			vt1708_start_hp_work(codec->spec);
		else
			vt1708_stop_hp_work(codec->spec);
	}
	return change;
}


Since is_aa_path_mute() always returns 0 for codec VT1708 (default
case), and both vt1708_start_hp_work() and vt1708_stop_hp_work() only
execute for such a codec (due to an if statement checking for codec
type and returning from the function if that's not VT1708),
vt1708_stop_hp_work() is the only one that can be executed, so perhaps
the code could be clearer without the if statement checking
is_aa_path_mute() result. Moreover:


static void vt1708_stop_hp_work(struct via_spec *spec)
{
	if (spec->codec_type != VT1708 || spec->autocfg.hp_pins[0] == 0)
		return;
	if (snd_hda_get_bool_hint(spec->codec, "analog_loopback_hp_detect") == 1
	    && !is_aa_path_mute(spec->codec))
		return;
	snd_hda_codec_write(spec->codec, 0x1, 0, 0xf81,
			    !spec->vt1708_jack_detectect);
	cancel_delayed_work_sync(&spec->vt1708_hp_work);
}


Since !is_aa_path_mute(spec->codec) is always true for VT1708, there
is no real dependence on it in the if statement above, thus it should
be removed. But this also means that, if
snd_hda_get_bool_hint(spec->codec, "analog_loopback_hp_detect") == 1,
then analog_input_switch_put() will call vt1708_stop_hp_work(), which
in turn will return without performing any operation, so that it would
seem useless, unless any reconfiguration might happen just in time
between the first call to snd_hda_get_bool_hint in
analog_input_switch_put() and the second call within
vt1708_stop_hp_work().


Otherwise, if those switch statements should match against each other,
they could be replaced with a call to a new inline function, so that a
single switch could be moved within it and become easier to maintain.
For instance:


static inline int get_supported_aa_mute_info( const struct via_spec *
const spec,
				hda_nid_t *mixer, int *first_idx, int *last_idx )
{
	/* get correct nid of mixer and start & end index */
	switch (spec->codec_type) {
		case VT1708:
				*mixer = 0x17;
				*first_idx = 2;
				*last_idx = 4;
				return 0;
		case VT1709_10CH:
		case VT1709_6CH:
				*mixer = 0x18;
				*first_idx = 2;
				*last_idx = 4;
				return 0;
		case VT1708B_8CH:
		case VT1708B_4CH:
		case VT1708S:
		case VT1716S:
				*mixer = 0x16;
				*first_idx = 2;
				*last_idx = 4;
				return 0;
		case VT1702:
				*mixer = 0x1a;
				*first_idx = 1;
				*last_idx = 3;
				return 0;
		case VT1718S:
				*mixer = 0x21;
				*first_idx = 1;
				*last_idx = 3;
				return 0;
		case VT2002P:
		case VT1812:
		case VT1802:
				*mixer = 0x21;
				*first_idx = 0;
				*last_idx = 2;
				return 0;
		default:
				return -EINVAL;
	}
}



In mute_aa_path:

...
	if( get_supported_aa_mute_info( spec, &nid_mixer, &start_idx, &end_idx ) < 0 )
		return;


In is_aa_path_mute:


...
	if( get_supported_aa_mute_info( spec, &nid_mixer, &start_idx, &end_idx ) < 0 )
		return 0;


It happens that the list of codec types tested by is_aa_path_mute() is
the same tested by function analog_low_current_mode(); however, there
should be no dependence on that, because whatever is_aa_path_mute()
returned for any other codec would be filtered out by the switch
statement within analog_low_current_mode().

Regards.

From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Questions about Multi-streaming playback with HDA
	codec ad1988b
Date: Thu, 13 Jan 2011 10:09:43 +0800
Message-ID: <AANLkTi=_xGmLUz24UUPvZGdzFJXU0HcpdsxTuU2C=uta@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CB8F244AA
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 03:09:45 +0100 (CET)
Received: by eyg24 with SMTP id 24so603421eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 18:09:44 -0800 (PST)
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

The patch is to provide a new model which front panel headphone of a
6stack-dig desktop can be used for playback a stereo stream independent of
the rear panel

ad1988b is a HDA codec support  10 channel ( enough DAC for stereo +
surround71 )

1) Is this approach to create a new model correct or just need to implement
a switch for activatie the "independent head phone" like those VIA codecs ?

struct ad198x_spec {

+    hda_nid_t *alt_dac_nid;
+    struct hda_pcm_stream *stream_analog_alt_playback;

}

+static hda_nid_t ad1988_6stack_alt_dac_nid[1] = {
+   0x03
+};

static const char *ad1988_models[AD1988_MODEL_LAST] = {
    [AD1988_6STACK]        = "6stack",
    [AD1988_6STACK_DIG]    = "6stack-dig",
+  [AD1988_6STACK_DIG_FP]    = "6stack-dig-fp",
    [AD1988_3STACK]        = "3stack",
    [AD1988_3STACK_DIG]    = "3stack-dig",
    [AD1988_LAPTOP]        = "laptop",
    [AD1988_LAPTOP_DIG]    = "laptop-dig",
    [AD1988_AUTO]        = "auto",
};

enum {
    AD1988_6STACK,
    AD1988_6STACK_DIG,
+  AD1988_6STACK_DIG_FP,
    AD1988_3STACK,
    AD1988_3STACK_DIG,
    AD1988_LAPTOP,
    AD1988_LAPTOP_DIG,
    AD1988_AUTO,
    AD1988_MODEL_LAST,
};


2) do the driver need to define .prepare and .cleanup function or just need
to use "hda_pcm_default_prepare() and hda_pcm_default_cleanup()

static int ad198x_alt_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
                struct hda_codec *codec,
                unsigned int stream_tag,
                unsigned int format,
                struct snd_pcm_substream *substream)
{
    struct ad198x_spec *spec = codec->spec;
    snd_hda_codec_setup_stream(codec, spec->alt_dac_nid[0], stream_tag, 0,
format);
        return 0;
}

static int ad198x_alt_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
                struct hda_codec *codec,
                struct snd_pcm_substream *substream)
{
    struct ad198x_spec *spec = codec->spec;
    snd_hda_codec_cleanup_stream(codec, spec->alt_dac_nid[0]);
    return 0;
}

static struct hda_pcm_stream ad198x_pcm_analog_alt_playback = {
    .substreams = 1,
    .channels_min = 2,
    .channels_max = 2,
    /* NID is set in ad198x_build_pcms */
        .ops = {
        .prepare = ad198x_alt_playback_pcm_prepare,
            .cleanup = ad198x_alt_playback_pcm_cleanup
    },
};

3) Is it correct to use device 2 for analog alternate playback since some
HDA codec implement this feature on "hw:0,0,1" and realtek driver create
alternate capture on "hw:0,2" ,  this seem create a lot of problem of the
application (e.g. PA server ) ?

static int ad198x_build_pcms(struct hda_codec *codec)
{

    if (spec->alt_dac_nid && spec->stream_analog_alt_playback) {
        codec->num_pcms++;
        info = spec->pcm_rec + 2;
        info->name = "AD198x Alternate Analog";
        info->pcm_type = HDA_PCM_TYPE_AUDIO;
        info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
*spec->stream_analog_alt_playback;
        info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->alt_dac_nid[0];
        }
}

static struct snd_kcontrol_new ad1988_6stack_fp_mixers[] = {
    HDA_CODEC_VOLUME("Front Playback Volume", 0x04, 0x0, HDA_OUTPUT),
    HDA_CODEC_VOLUME("Surround Playback Volume", 0x06, 0x0, HDA_OUTPUT),
    HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x05, 1, 0x0,
HDA_OUTPUT),
    HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x05, 2, 0x0, HDA_OUTPUT),
    HDA_CODEC_VOLUME("Side Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
    HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),

    HDA_BIND_MUTE("Front Playback Switch", 0x29, 2, HDA_INPUT),
    HDA_BIND_MUTE("Surround Playback Switch", 0x2a, 2, HDA_INPUT),
    HDA_BIND_MUTE_MONO("Center Playback Switch", 0x27, 1, 2, HDA_INPUT),
    HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x27, 2, 2, HDA_INPUT),
    HDA_BIND_MUTE("Side Playback Switch", 0x28, 2, HDA_INPUT),
    HDA_BIND_MUTE("Headphone Playback Switch", 0x22, 2, HDA_INPUT),
    HDA_BIND_MUTE("Mono Playback Switch", 0x1e, 2, HDA_INPUT),

    HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x6, HDA_INPUT),
    HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x6, HDA_INPUT),
    HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x20, 0x0, HDA_INPUT),
    HDA_CODEC_MUTE("Front Mic Playback Switch", 0x20, 0x0, HDA_INPUT),
    HDA_CODEC_VOLUME("Line Playback Volume", 0x20, 0x1, HDA_INPUT),
    HDA_CODEC_MUTE("Line Playback Switch", 0x20, 0x1, HDA_INPUT),
    HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x4, HDA_INPUT),
    HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x4, HDA_INPUT),

    HDA_CODEC_VOLUME("Analog Mix Playback Volume", 0x21, 0x0, HDA_OUTPUT),
    HDA_CODEC_MUTE("Analog Mix Playback Switch", 0x21, 0x0, HDA_OUTPUT),

    HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
    HDA_CODEC_VOLUME("Mic Boost Volume", 0x3c, 0x0, HDA_OUTPUT),

    { } /* end */
};

static struct hda_verb ad1988_6stack_fp_init_verbs[] = {
    /* Front, Surround, CLFE, side DAC; unmute as default */
    {0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    {0x06, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    {0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    {0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
        /* Headphone; unmute as default */
    {0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    /* Port-A front headphon path */
    {0x37, AC_VERB_SET_CONNECT_SEL, 0x00}, /* DAC:03h */
    {0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
    {0x22, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
    {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    {0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
    /* Port-D line-out path */
    {0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
    {0x29, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
    {0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
    /* Port-F surround path */
    {0x2a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
    {0x2a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
    {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    {0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
    /* Port-G CLFE path */
    {0x27, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
    {0x27, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
    {0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    {0x24, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
    /* Port-H side path */
    {0x28, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
    {0x28, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
    {0x25, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
    {0x25, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
    /* Mono out path */
    {0x36, AC_VERB_SET_CONNECT_SEL, 0x1}, /* DAC1:04h */
    {0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
    {0x1e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
    {0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
    {0x13, AC_VERB_SET_AMP_GAIN_MUTE, 0xb01f}, /* unmute, 0dB */
    /* Port-B front mic-in path */
    {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
    {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
    {0x39, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
    /* Port-C line-in path */
    {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
    {0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
    {0x3a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
    {0x33, AC_VERB_SET_CONNECT_SEL, 0x0},
    /* Port-E mic-in path */
    {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
    {0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
    {0x3c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
    {0x34, AC_VERB_SET_CONNECT_SEL, 0x0},
    /* Analog CD Input */
    {0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
    /* Analog Mix output amp */
    {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x1f}, /* 0dB */

    { }
};

static int patch_ad1988(struct hda_codec *codec)
{


        switch (board_config) {
        case AD1988_6STACK_DIG_FP:
                spec->multiout.max_channels = 8;
        spec->multiout.num_dacs = 4;
        spec->multiout.dac_nids = ad1988_6stack_dac_nids;
        spec->alt_dac_nid = ad1988_6stack_alt_dac_nid;
        spec->stream_analog_alt_playback = &ad198x_pcm_analog_alt_playback;
        spec->input_mux = &ad1988_6stack_capture_source;
        spec->num_mixers = 1;
        spec->mixers[0] = ad1988_6stack_fp_mixers;
        spec->num_init_verbs = 1;
        spec->init_verbs[0] = ad1988_6stack_fp_init_verbs;
        spec->multiout.dig_out_nid = AD1988_SPDIF_OUT;
        spec->dig_in_nid = AD1988_SPDIF_IN;
        break;

3) What functions are still missing in this model ?
a), do this new model need to disable hp_automute() function
b) any change in ad198x_power_eapd_xxx() functions ?
c) idenifty ad1988a and ad1988b

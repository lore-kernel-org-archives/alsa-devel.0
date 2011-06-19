From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Sun, 19 Jun 2011 14:44:16 +0200
Message-ID: <BANLkTikpNMvr2a34m=M2nA7-1Qr_2JvBww@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
	<BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
	<BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
	<BANLkTi=-dE0hvTN96yCvdNzsM59MY=csfA@mail.gmail.com>
	<BANLkTinwNT_bbvSkd5Q106c9SoEmPURzng@mail.gmail.com>
	<BANLkTimJb-UMD5Nk3d+_GW-b9Cir13PjMw@mail.gmail.com>
	<BANLkTimgZTT_0sEiSHmOMrTGdKA-hx-HBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DE1D424797
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Jun 2011 14:44:16 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2909167wwf.20
	for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2011 05:44:16 -0700 (PDT)
In-Reply-To: <BANLkTimgZTT_0sEiSHmOMrTGdKA-hx-HBA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/18 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/6/8 alex dot baldacchino dot alsasub at gmail dot com
> <alex.baldacchino.alsasub@gmail.com>:
>>
>>
>> Adding a few printk()'s to file "patch_via.c" showed me function
>> via_hp_build() is called before via_build_pcms() (unless front panel
>> is disabled in BIOS, in which case via_hp_build() isn't invoked at
>> all), therefore, when a control "Independent HP" is created, it should
>> be 'visible' by via_build_pcms(); however,
>> snd_hda_find_mixer_ctl(codec, "Independent HP") fails to find it until
>> the following loop is executed inside via_build_controls:
>>
>
>> and via_build_controls() is called after via_build_pcms(), but then
>> it's too late (or seemed to be such) to modify the number of playback
>> substreams. At last, I've tried the following, which worked:
>>
>
> The fix is to check spec->multiout.hp_nid =A0since "Independent HP" need
> the extra DAC for HP when there is no HP if front panel is disabled by
> BIOS
>
>
>
> static int via_build_pcms(struct hda_codec *codec)
> {
> ...
>
> =A0 =A0 =A0 =A0info->name =3D spec->stream_name_analog;
> =A0 =A0 =A0 =A0info->stream[SNDRV_PCM_STREAM_PLAYBACK] =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*(spec->stream_analog_playback);
> =A0 =A0 =A0 =A0info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->multiout.dac_nids[0];
> + =A0 =A0 info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.hp_nid ? 2 : 1;
> =A0 =A0 =A0 =A0info->stream[SNDRV_PCM_STREAM_CAPTURE] =3D *(spec->stream_=
analog_capture);
> =A0 =A0 =A0 =A0info->stream[SNDRV_PCM_STREAM_CAPTURE].nid =3D spec->adc_n=
ids[0];
>
> =A0 =A0 =A0 =A0info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->multiout.max_channels;
>
>

It might work, but might also fail, I guess. Even if everything else
went ok during initialization, and multiout.hp_nid were set in
vtxxxx_auto_create_hp_ctls(), via_hp_build() could fail to create an
Independent HP control, because of either a failure allocating memory
for it, when calling via_clone_control():


	knew =3D via_clone_control(spec, &via_hp_mixer[0]);
	if (knew =3D=3D NULL)
		return -ENOMEM;

or because the nid corresponding to the Independent HP control hasn't
got enough connections:


	if (spec->codec_type !=3D VT1708) {
		nums =3D snd_hda_get_connections(codec, nid,
					       conn, HDA_MAX_CONNECTIONS);
		if (nums <=3D 1)
			return 0;
	}


As I understand it, without a control "Independent HP" with its proper
.get and .put methods, that's not possible to switch between single-
and multi-streaming, thus the problem is here, I think.

But perhaps, if there are not enough connections to switch from/to, it
might happen that autocfg.hp_pins[0] is 0, so that:


static int vtXXXX_parse_auto_config(struct hda_codec *codec)
{
...

      err =3D vtXXX_auto_create_hp_ctls(spec, spec->autocfg.hp_pins[0]);
...


triggered:


static int vtXXX_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
{
...

	if (!pin)
		return 0;
...


before spec->multiout.hp_nid is set, but it may also not happen,
because, regardless of support for multi-streaming, there can be
support for a front panel line-out in redirected output (refer to
commit 3d83e577a8206f0f3822a3840e12f76477142ba2 and
ee3c35c0827de02de414d08b2ddcbb910c2263ab, if there is need to solve
that problem in via_hp_build(), it should mean that
spec->multiout.hp_nid is not null in such scenarios).

However, that wouldn't solve the memory failure risk, or the risk
via_hp_build is not called at all because spec->hp_mux wasn't created
(though, this latter risk is fixable by moving assignment to
spec->multiout.hp_nid at the end of vtXXX_auto_create_hp_ctls, and
using local variables before), and anyway, in doubt, I think a safe
choice is to add a proper field, I've called
independent_front_panel_out, to struct via_spec, initialize it to 0
and set it to 1 in via_hp_build() after via_clone_control(spec,
&via_hp_mixer[0]) succeeds, so that in via_build_pcms():


info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =3D 1 +
spec->independent_front_panel_out;


I was using it also in patch_vtXXXX() (for a few codecs, not all) to
create a "Front Mic Boost Volume" control dynamically only when the
front panel exist (but that's wrong, I've modified it to check for
spec->autocfg.hp_pins[0], which seems to be 0 when there's no front
panel seen by the BIOS).

More code is in my last mail for this thread, before this one, I've
changed since then:

front_panel_out renamed independent_front_panel_out, and
vt_add_front_mic_boost() now is:


static int vt_add_front_mic_boost( struct via_spec *spec, const struct
snd_kcontrol_new *fmb_ctl ){
	struct snd_kcontrol_new *knew;

	if( spec->autocfg.hp_pins[0] ){ /* if there is a front audio panel */
		knew =3D via_clone_control( spec, fmb_ctl );
		if( knew =3D=3D NULL )
			return -ENOMEM;
		return 1;
	}
	=

	return 0;
}


(here, it would be the same to check for spec->multiout.hp_nid being
set, but only if the position of the assignment to
spec->multiout.hp_nid is not moved around in
vtxxx_auto_create_hp_ctls)


> However there is a bug in using subdevice 1 for "Independent HP" and
> subdevice 0 for multi-channels
>
> The channel count reported by snd_pcm_hw_params_get_channels_max() or
> snd_pcm_hw_params_test_channel() for subdevice 1 is also equal to
> spec->multiout.max_channels but this subdevice 1 only support stereo


I haven't understood all of the pcm layer, but I guess that issue
could be hard to fix without touching it at some level, or creating a
separate pcm (struct snd_pcm) to handle multi-outs and hp separately,
with a careful inspection of the code needed to handle them in tandem
(via_playback_pcm_open() and so on).

struct hda_pcm can hold only 2 struct hda_pcm_stream elements (one
actually used for playback, the other for capture):

/* for PCM creation */
struct hda_pcm {
	char *name;
	struct hda_pcm_stream stream[2];
...

and at least snd_hda_attach_pcm() (hda_codec.c) counts on it:

static int snd_hda_attach_pcm(struct hda_codec *codec, struct hda_pcm *pcm)
{
	struct hda_bus *bus =3D codec->bus;
	struct hda_pcm_stream *info;
	int stream, err;

	if (snd_BUG_ON(!pcm->name))
		return -EINVAL;
	for (stream =3D 0; stream < 2; stream++) {
		info =3D &pcm->stream[stream];
		if (info->substreams) {
			err =3D set_pcm_default_values(codec, info);
			if (err < 0)
				return err;
		}
	}
	return bus->ops.attach_pcm(bus, codec, pcm);
}


Moreover, only one pcm is created for a VIA codec, to handle analog
outputs, plus one if there are digital connections:

(file patch_via.c)

static int via_build_pcms(struct hda_codec *codec)
{
	struct via_spec *spec =3D codec->spec;
	struct hda_pcm *info =3D spec->pcm_rec;

	codec->num_pcms =3D 1;
	codec->pcm_info =3D info;
....

	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
		codec->num_pcms++;
		info++;
...


(file hda_codec.c)

int snd_hda_codec_build_pcms(struct hda_codec *codec)
{
	unsigned int pcm;
	int err;
...

	for (pcm =3D 0; pcm < codec->num_pcms; pcm++) {
		struct hda_pcm *cpcm =3D &codec->pcm_info[pcm];
		int dev;
...

		if (!cpcm->pcm) {
			dev =3D get_empty_pcm_device(codec->bus, cpcm->pcm_type);
			if (dev < 0)
				continue; /* no fatal error */
			cpcm->device =3D dev;
			err =3D snd_hda_attach_pcm(codec, cpcm);
...


snd_hda_attach_pcm() calls bus->ops.attach_pcm(), that is (in file
hda_intel.c) azx_attach_pcm_stream():


static int
azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
		      struct hda_pcm *cpcm)
{
	struct azx *chip =3D bus->private_data;
	struct snd_pcm *pcm;
	struct azx_pcm *apcm;
	int pcm_dev =3D cpcm->device;
	int s, err;
...

	err =3D snd_pcm_new(chip->card, cpcm->name, pcm_dev,
			  cpcm->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams,
			  cpcm->stream[SNDRV_PCM_STREAM_CAPTURE].substreams,
			  &pcm);
...

	apcm->chip =3D chip;
	apcm->codec =3D codec;
	pcm->private_data =3D apcm;
...

	cpcm->pcm =3D pcm;
	for (s =3D 0; s < 2; s++) {
		apcm->hinfo[s] =3D &cpcm->stream[s];
		if (cpcm->stream[s].substreams)
			snd_pcm_set_ops(pcm, s, &azx_pcm_ops);
	}
...


again counting on two streams only:

(hda_intel.c):

struct azx_pcm {
	struct azx *chip;
	struct hda_codec *codec;
	struct hda_pcm_stream *hinfo[2];
};


(pcm.h):

struct snd_pcm {
...
	struct snd_pcm_str streams[2];
...
	void *private_data;
...


struct snd_pcm_str {
	int stream;				/* stream (direction) */
	struct snd_pcm *pcm;
	/* -- substreams -- */
	unsigned int substream_count;
	unsigned int substream_opened;
	struct snd_pcm_substream *substream;
...


struct snd_pcm_substream {
	struct snd_pcm *pcm;
	struct snd_pcm_str *pstr;
	void *private_data;		/* copied from pcm->private_data */
...

	/* -- hardware operations -- */
	struct snd_pcm_ops *ops;
	/* -- runtime information -- */
	struct snd_pcm_runtime *runtime;

(notice above comment about field private_data, from file)


struct snd_pcm_runtime {
...
	/* -- hardware description -- */
	struct snd_pcm_hardware hw;
	struct snd_pcm_hw_constraints hw_constraints;
...


struct snd_pcm_hardware {
...
	unsigned int channels_min;	/* min channels */
	unsigned int channels_max;	/* max channels */
...

(pcm.c):

int snd_pcm_new(struct snd_card *card, const char *id, int device,
		int playback_count, int capture_count,
	        struct snd_pcm ** rpcm)
{
	struct snd_pcm *pcm;
	int err;
...

	if ((err =3D snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK,
playback_count)) < 0) {
...
	if ((err =3D snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_CAPTURE,
capture_count)) < 0) {
...


int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
{
	int idx, err;
	struct snd_pcm_str *pstr =3D &pcm->streams[stream];
	struct snd_pcm_substream *substream, *prev;
...

	pstr->stream =3D stream;
	pstr->pcm =3D pcm;
	pstr->substream_count =3D substream_count;
...
	for (idx =3D 0, prev =3D NULL; idx < substream_count; idx++) {
		substream =3D kzalloc(sizeof(*substream), GFP_KERNEL);
...

		substream->pcm =3D pcm;
		substream->pstr =3D pstr;
		substream->number =3D idx;
		substream->stream =3D stream;
....


int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
			     struct file *file,
			     struct snd_pcm_substream **rsubstream)
{
	struct snd_pcm_str * pstr;
	struct snd_pcm_substream *substream;
	struct snd_pcm_runtime *runtime;
...

	runtime =3D kzalloc(sizeof(*runtime), GFP_KERNEL);
...

	substream->runtime =3D runtime;
	substream->private_data =3D pcm->private_data;
...
	*rsubstream =3D substream;
	return 0;
}



This one called by: (pcm_native.c):


int snd_pcm_open_substream(struct snd_pcm *pcm, int stream,
			   struct file *file,
			   struct snd_pcm_substream **rsubstream)
{
	struct snd_pcm_substream *substream;
	int err;

	err =3D snd_pcm_attach_substream(pcm, stream, file, &substream);
...

	if ((err =3D substream->ops->open(substream)) < 0)
		goto error;

	substream->hw_opened =3D 1;
...

	*rsubstream =3D substream;
...


called by snd_pcm_open_file(), in turn called by snd_pcm_open(), in
turn called by snd_pcm_{playback, capture}_open(), which are
'exported' as file_operations; substream->ops->open(), as set by
azx_attach_pcm_stream(), is:

(hda_intel.c):

static int azx_pcm_open(struct snd_pcm_substream *substream)
{
	struct azx_pcm *apcm =3D snd_pcm_substream_chip(substream);
	struct hda_pcm_stream *hinfo =3D apcm->hinfo[substream->stream];
	struct azx *chip =3D apcm->chip;
	struct azx_dev *azx_dev;
	struct snd_pcm_runtime *runtime =3D substream->runtime;
...

	runtime->hw.channels_min =3D hinfo->channels_min;
	runtime->hw.channels_max =3D hinfo->channels_max;
...


In file pcm.h:

#define snd_pcm_substream_chip(substream) ((substream)->private_data)

since substream->private_data is shared by all substreams of the same
snd_pcm, in case of playback (substream->stream =3D=3D
SNDRV_PCM_STREAM_PLAYBACK), hinfo is spec->stream_analog_playback, and
.channel_{min, max} fields hold same values for both multi-out and
Independent HP subdevices (if I'm not mistaken, of course).

If my interpretation above is correct, something should change in that
chain in order to have different values retrieved for different
substreams of the same stream of the same pcm.

On the other hand, using separate pcms could require less invasive,
yet careful, changes (affecting only patch_via.c, or one patch at a
time, to test it better), but could affect any application eventually
counting on analog outputs being handled by the same pcm.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

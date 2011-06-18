From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Sat, 18 Jun 2011 16:29:20 +0800
Message-ID: <BANLkTimgZTT_0sEiSHmOMrTGdKA-hx-HBA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BE2371037EC
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Jun 2011 10:29:21 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1504302fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2011 01:29:20 -0700 (PDT)
In-Reply-To: <BANLkTimJb-UMD5Nk3d+_GW-b9Cir13PjMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/6/8 alex dot baldacchino dot alsasub at gmail dot com
<alex.baldacchino.alsasub@gmail.com>:
>
>
> Adding a few printk()'s to file "patch_via.c" showed me function
> via_hp_build() is called before via_build_pcms() (unless front panel
> is disabled in BIOS, in which case via_hp_build() isn't invoked at
> all), therefore, when a control "Independent HP" is created, it should
> be 'visible' by via_build_pcms(); however,
> snd_hda_find_mixer_ctl(codec, "Independent HP") fails to find it until
> the following loop is executed inside via_build_controls:
>

> and via_build_controls() is called after via_build_pcms(), but then
> it's too late (or seemed to be such) to modify the number of playback
> substreams. At last, I've tried the following, which worked:
>

The fix is to check spec->multiout.hp_nid  since "Independent HP" need
the extra DAC for HP when there is no HP if front panel is disabled by
BIOS



static int via_build_pcms(struct hda_codec *codec)
{
...

	info->name = spec->stream_name_analog;
	info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
		*(spec->stream_analog_playback);
	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
		spec->multiout.dac_nids[0];
+     info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =
+             spec->multiout.hp_nid ? 2 : 1;
	info->stream[SNDRV_PCM_STREAM_CAPTURE] = *(spec->stream_analog_capture);
	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];

	info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
		spec->multiout.max_channels;


However there is a bug in using subdevice 1 for "Independent HP" and
subdevice 0 for multi-channels

The channel count reported by snd_pcm_hw_params_get_channels_max() or
snd_pcm_hw_params_test_channel() for subdevice 1 is also equal to
spec->multiout.max_channels but this subdevice 1 only support stereo

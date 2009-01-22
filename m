From: "John L. Utz III" <jutz@dmx.com>
Subject: CMI8788/AV200/Oxygen Volume Controls in alsamixer
 (oxygen_mixer.c:dac_volume_get())
Date: Thu, 22 Jan 2009 15:36:52 -0800
Message-ID: <49790314.10607@dmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D82F103804
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 00:38:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens and all;

( To those following along at home, kindly open
alsa-driver-1.0.18a/alsa-kernel/pci/oxygen/oxygen_mixer.c and look at 
dac_volume_get() and dac_volume_put() )


It appears to me that these functions are attempting to work on all of 
the channels at once instead of just choosing Master, Front, Rear, 
Surround, or what have you:

static int dac_volume_get(struct snd_kcontrol *ctl,
			  struct snd_ctl_elem_value *value)
{
	struct oxygen *chip = ctl->private_data;
	unsigned int i;

	mutex_lock(&chip->mutex);
	for (i = 0; i < chip->model.dac_channels; ++i)
		value->value.integer.value[i] = chip->dac_volume[i];
	mutex_unlock(&chip->mutex);
	return 0;
}


This is then surfaced to userland thusly in the controls array:

static const struct snd_kcontrol_new controls[] = {
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Master Playback Volume",
		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
		.info = dac_volume_info,
		.get = dac_volume_get,
		.put = dac_volume_put,
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Master Playback Switch",
		.info = snd_ctl_boolean_mono_info,
		.get = dac_mute_get,
		.put = dac_mute_put,
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Stereo Upmixing",
		.info = upmix_info,
		.get = upmix_get,
		.put = upmix_put,
	},
         { blah },
	{ blah },
         { blah }
};


this leads to a rather awkward result in alsamixer where there are 5 
volume controls called "Master":


< Master >  Master    Master    Master    Master


IMHO, it would be more desirable for them to say:


< Master >  Front     C/LFE     Surround  Rear Surr


Our app would certainly be much happier :-)

So, i *think* that i can fix this thusly:

static const struct snd_kcontrol_new controls[] = {
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Master Playback Volume",
		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
		.info = dac_volume_info,
		.get = dac_volume_get,
		.put = dac_volume_put,
		.private_value = 0
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Master Playback Switch",
		.info = snd_ctl_boolean_mono_info,
		.get = dac_mute_get,
		.put = dac_mute_put,
		.private_value = 0
	},
         {
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Front Playback Volume",
		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
		.info = dac_volume_info,
		.get = dac_volume_get,
		.put = dac_volume_put,
		.private_value = 1
	},
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Front Playback Switch",
		.info = snd_ctl_boolean_mono_info,
		.get = dac_mute_get,
		.put = dac_mute_put,
		.private_value = 1
	},


and alter dac_volume_*() to not use a for() loop and just work off the 
private_value.

anybody have any opinions?

i'll probably have tried this already before anybody responds but it 
seemed reasonable to surface the idea.

tnx!

johnu

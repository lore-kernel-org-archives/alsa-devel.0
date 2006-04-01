From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: More mixer questions
Date: Sun, 02 Apr 2006 00:18:27 +0100
Message-ID: <1143933507.9228.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 266A318F
	for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2006 01:18:36 +0200 (MEST)
Received: from bossclass ([192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.4/Debian-3) with ESMTP id k31NIXSo024460
	for <alsa-devel@alsa-project.org>; Sun, 2 Apr 2006 00:18:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry to hit the list with another question about the mixer/control
stuff, but I'm pretty puzzled as to what I am getting wrong.

I am using mpg123 compiled to only hack oss, so I am reliant on oss
emulation.

I have the control code attached below, which defines both master and
pcm functions (mapped together as the device only plays PCM).

By default I get this:

/ # cat /proc/asound/card0/oss_mixer
VOLUME "" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "" 0
SPEAKER "" 0
LINE "" 0
MIC "" 0
CD "" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "" 0
OGAIN "" 0
LINE1 "" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "" 0
PHONEOUT "" 0
VIDEO "" 0
RADIO "" 0
MONITOR "" 0

ie nothing mapped against oss. But if I do this:
echo 'VOLUME "PCM" 0' > /proc/asound/card0/oss_mixer
or
echo 'VOLUME "Master" 0' > /proc/asound/card0/oss_mixer

Then I get control of gain... so why doesn't the mapping work by
default?


/* Mixer controls */
static int aica_pcmswitch_info(snd_kcontrol_t * kcontrol,
			       snd_ctl_elem_info_t * uinfo)
{
	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
	uinfo->count = 1;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = 1;
	return 0;
}

static int aica_pcmswitch_get(snd_kcontrol_t * kcontrol,
			      snd_ctl_elem_value_t * ucontrol)
{
	ucontrol->value.integer.value[0] = 1;	/* TO DO: Fix me */
	return 0;
}

static int aica_pcmswitch_put(snd_kcontrol_t * kcontrol,
			      snd_ctl_elem_value_t * ucontrol)
{
	if (ucontrol->value.integer.value[0] == 1)
		return 0;	/* TO DO: Fix me */
	else
		aica_chn_halt();
	return 0;
}

static snd_kcontrol_new_t snd_aica_masterswitch_control __devinitdata =
{
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Master Playback Switch",
	.info = aica_pcmswitch_info,
	.get = aica_pcmswitch_get,
	.put = aica_pcmswitch_put
};

static snd_kcontrol_new_t snd_aica_pcmswitch_control __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "PCM Playback Switch",
	.index = 0,
	.info = aica_pcmswitch_info,
	.get = aica_pcmswitch_get,
	.put = aica_pcmswitch_put
};




static int aica_pcmvolume_info(snd_kcontrol_t * kcontrol,
			       snd_ctl_elem_info_t * uinfo)
{

	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
	uinfo->count = 1;
	uinfo->value.integer.min = 0;
	uinfo->value.integer.max = 0xFF;

	return 0;
}

static int aica_pcmvolume_get(snd_kcontrol_t * kcontrol,
			      snd_ctl_elem_value_t * ucontrol)
{
	if (!channel)
		return -ETXTBSY;	/* we've not yet been set up */
	ucontrol->value.integer.value[0] = channel->vol;
	return 0;
}

static int aica_pcmvolume_put(snd_kcontrol_t * kcontrol,
			      snd_ctl_elem_value_t * ucontrol)
{
	if (!channel) {
		snd_printk("No channel yet\n");
		return -ETXTBSY;	/* too soon */
	}

	else if (channel->vol == ucontrol->value.integer.value[0])
		return 0;

	else {
		channel->vol = ucontrol->value.integer.value[0];
		dreamcastcard->master_volume = ucontrol->value.integer.value[0];
		spu_memload(AICA_CHANNEL0_CONTROL_OFFSET,
			    (uint8_t *) channel, sizeof(aica_channel_t));
	}
	return 1;
}

static snd_kcontrol_new_t snd_aica_mastervolume_control __devinitdata =
{
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Master Playback Volume",
	.info = aica_pcmvolume_info,
	.get = aica_pcmvolume_get,
	.put = aica_pcmvolume_put
};

static snd_kcontrol_new_t snd_aica_pcmvolume_control __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "PCM Playback Volume",
	.index = 0,
	.info = aica_pcmvolume_info,
	.get = aica_pcmvolume_get,
	.put = aica_pcmvolume_put
};






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

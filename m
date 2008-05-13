From: Peter Wurmsdobler <peter@wurmsdobler.org>
Subject: From snd_kcontrol_new_t to amixer
Date: Tue, 13 May 2008 19:12:06 +0100
Message-ID: <4829D9F6.205@wurmsdobler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox84.server-home.net (webbox84.server-home.net
	[195.137.212.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 344C71037F5
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 20:12:08 +0200 (CEST)
Received: from [127.0.0.1] (unknown [212.44.20.206])
	by webbox84.server-home.net (Postfix) with ESMTP id 5385F160BFC
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 20:12:02 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hello,

I am puzzled by an observation that runs against my common sense. The 
pmic-alsa-mixer.c provides 6 (six) snd_kcontrol_new_t controls with 
their callback functions, name and other members, then registers 
themusing snd_ctl_add(...). However, amixer shows only 5 (five), and all 
with different names. What is the process of generating these names if 
not from the kernel structures?

By looking through the mixer related code in alsa-utils and alsa-libs, I 
see that somehow the library loads the mixer controls and possibly 
retrieves all the information provided by them, including their names. 
Either some piece of code shortens the names defined in the driver, or 
it maps them to some generic controls. Any suggestions?

The system I am working on uses a Freescale imx27 in conjunction with an 
MC13783 power management IC, also responsible for audio (it provides a 
voice codec and a stereo dac). The kernel used is a 2.6.19.2 as part of 
ltib from Freescale. amixer tells me:

mx27# amixer
Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined cvolume
   Playback channels: Mono
   Capture channels: Mono
   Limits: Playback 0 - 100 Capture 0 - 100
   Mono: Playback 0 [0%] Capture 0 [0%]
Simple mixer control 'Master Balance',0
   Capabilities: pvolume pvolume-joined
   Playback channels: Mono
   Limits: Playback 0 - 100
   Mono: Playback 50 [50%]
Simple mixer control 'Master Input',0
   Capabilities: cvolume
   Capture channels: Mono
   Limits: Capture 0 - 7
   Mono: Capture 1 [14%]
Simple mixer control 'Master Monoconfig',0
   Capabilities: pvolume pvolume-joined
   Playback channels: Mono
   Limits: Playback 0 - 3
   Mono: Playback 0 [0%]
Simple mixer control 'Master Output',0
   Capabilities: pvolume pvolume-joined
   Playback channels: Mono
   Limits: Playback 0 - 15
   Mono: Playback 12 [80%]


snd_kcontrol_new_t pmic_control_pb_vol __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Master Playback Volume",
	.index = 0x00,
	.info = pmic_pb_volume_info,
	.get = pmic_pb_volume_get,
	.put = pmic_pb_volume_put,
	.private_value = 0xffab1,
};

snd_kcontrol_new_t pmic_control_pb_bal __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Master Balance Playback Volume",
	.index = 0x00,
	.info = pmic_pb_balance_info,
	.get = pmic_pb_balance_get,
	.put = pmic_pb_balance_put,
	.private_value = 0xffab2,
};
snd_kcontrol_new_t pmic_control_pb_mono __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Master Monoconfig Playback Volume",
	.index = 0x00,
	.info = pmic_pb_monoconfig_info,
	.get = pmic_pb_monoconfig_get,
	.put = pmic_pb_monoconfig_put,
	.private_value = 0xffab2,
};
snd_kcontrol_new_t pmic_control_op_sw __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Master Output Playback Volume",
	.index = 0x00,
	.info = pmic_mixer_output_info,
	.get = pmic_mixer_output_get,
	.put = pmic_mixer_output_put,
	.private_value = 0xffab4,
};

snd_kcontrol_new_t pmic_control_cap_vol __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Master Capture Volume",
	.index = 0x00,
	.info = pmic_cap_volume_info,
	.get = pmic_cap_volume_get,
	.put = pmic_cap_volume_put,
	.private_value = 0xffab5,
};
snd_kcontrol_new_t pmic_control_ip_sw __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "Master Input Capture Volume",
	.index = 0x00,
	.info = pmic_cap_input_info,
	.get = pmic_cap_input_get,
	.put = pmic_cap_input_put,
	.private_value = 0xffab5,
};

int mxc_alsa_create_ctl(snd_card_t * card, void *p_value)
{
	int err = 0;

	if ((err = snd_ctl_add(card,
		snd_ctl_new1(&pmic_control_op_sw, p_value))) < 0)
		return err;

	if ((err = snd_ctl_add(card,
		snd_ctl_new1(&pmic_control_pb_vol, p_value))) < 0)
		return err;
	
	if ((err = snd_ctl_add(card,
		snd_ctl_new1(&pmic_control_pb_mono, p_value))) < 0)
		return err;
	
	if ((err = snd_ctl_add(card,
		snd_ctl_new1(&pmic_control_pb_bal, p_value))) < 0)
		return err;
	
	if ((err = snd_ctl_add(card,
		snd_ctl_new1(&pmic_control_cap_vol, p_value))) < 0)
		return err;
	
	if ((err = snd_ctl_add(card,
		snd_ctl_new1(&pmic_control_ip_sw, p_value))) < 0)
		return err;

	return 0;
}

Cheers,
peter

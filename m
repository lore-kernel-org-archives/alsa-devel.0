From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: softvol  plugin
Date: Sun, 20 Feb 2005 22:03:15 +0100
Message-ID: <4218FB13.2020507@gmx.de>
References: <92C0412E07F63549B2A2F2345D3DB515F7D63F@cm-msg-02.cmedia.com.tw>	 <4216EE28.6040702@gmx.de> <1108799809.9005.3.camel@krustophenia.net>	 <42178828.2020002@gmx.de> <1108840309.10705.6.camel@krustophenia.net>	 <4217AADE.6010005@gmx.de> <1108847548.10705.43.camel@krustophenia.net>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108847548.10705.43.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sat, 2005-02-19 at 22:08 +0100, thomas schorpp wrote:
> 
>>sorry, i cant get a pcm master slider on any mixer.

mmh, ok, im satisfied with 4 dxs channel sliders and no pcm master.
no more practical need for pcm master for me.

and xmmms has the softvol in, yet.

BTW, i got a CMedia 8738 - 5.1 CH pci, if someone wants testing, drop me 
a mail.

> OK, that's a separate issue (a bug).  All I was saying is that it's not
> a reason to put anything in the kernel.

no bug. all right. thx.

.. i tried to give seperate names for the 4 DXS mixer ctls:

static int snd_via8233_init_misc(via82xx_t *chip, int dev)
{
	int i, err, caps;
	unsigned char val;

	caps = chip->chip_type == TYPE_VIA8233A ? 1 : 2;
	for (i = 0; i < caps; i++) {
		snd_via8233_capture_source.index = i;
		err = snd_ctl_add(chip->card, 
snd_ctl_new1(&snd_via8233_capture_source, chip));
		if (err < 0)
			return err;
	}
	if (ac97_can_spdif(chip->ac97)) {
		err = snd_ctl_add(chip->card, 
snd_ctl_new1(&snd_via8233_dxs3_spdif_control, chip));
		if (err < 0)
			return err;
	}
	if (chip->chip_type != TYPE_VIA8233A) {
		snd_via8233_dxs_volume_control.count = 1;
		snd_via8233_dxs_volume_control.name = "PCM 1";
		err = snd_ctl_add(chip->card, 
snd_ctl_new1(&snd_via8233_dxs_volume_control, chip));
		snd_via8233_dxs_volume_control.name = "PCM 2";
		err = snd_ctl_add(chip->card, 
snd_ctl_new1(&snd_via8233_dxs_volume_control, chip));
		snd_via8233_dxs_volume_control.name = "PCM 3";
		err = snd_ctl_add(chip->card, 
snd_ctl_new1(&snd_via8233_dxs_volume_control, chip));
		snd_via8233_dxs_volume_control.name = "PCM 4";
		err = snd_ctl_add(chip->card, 
snd_ctl_new1(&snd_via8233_dxs_volume_control, chip));
		if (err < 0)
			return err;
	}

as expected they bound togehter then ;)
now i dont write several callbacks for every, is there a trick here?

this is little nebulous...

static int snd_via8233_dxs_volume_put(snd_kcontrol_t *kcontrol, 
snd_ctl_elem_value_t *ucontrol)
{
	via82xx_t *chip = snd_kcontrol_chip(kcontrol);
	unsigned int idx = snd_ctl_get_ioff(kcontrol, &ucontrol->id);
	unsigned long port = chip->port + 0x10 * idx;
	unsigned char val;
	int i, change = 0;

	for (i = 0; i < 2; i++) {
		val = ucontrol->value.integer.value[i];
		if (val > VIA_DXS_MAX_VOLUME)
			val = VIA_DXS_MAX_VOLUME;
		val = VIA_DXS_MAX_VOLUME - val;
		change |= val != chip->playback_volume[idx][i];
		if (change) {
			chip->playback_volume[idx][i] = val;
			outb(val, port + VIA_REG_OFS_PLAYBACK_VOLUME_L + i);
		}

tom


> 
> Lee
> 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

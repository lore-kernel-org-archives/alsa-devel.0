From: "John L. Utz III" <john.utz@dmx.com>
Subject: why would an scontrol think that it should have 2
 items instead of just 1?
Date: Wed, 8 Aug 2007 15:28:56 -0700
Message-ID: <20070808152856.4122183d@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 895101037FD
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 00:24:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello

The VT1618 codec has a register value that turns on the Surround Side
Output (it's off by default)

I have implemented the control, but I am getting a really weird result,
i have a bogus 'Item1' that shouldnt exist:

jutz-gntdv alsa-driver # amixer sset Side On
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch enum
  Items: 'On' 'Off'
  Item0: 'On'
  Item1: 'On'
jutz-gntdv alsa-driver # amixer sset Side Off
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch enum
  Items: 'On' 'Off'
  Item0: 'Off'
  Item1: 'On'

This wasnt always there, it just showed up during development. Is the
number of items cached in a temp file somewhere that i just need to
remove?

Here's the mixer element:

	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name  = "Side",
		.info  = snd_ac97_vt1618_surside_info,
		.get   = snd_ac97_vt1618_surside_get,
		.put   = snd_ac97_vt1618_surside_put
	},

Here's the function impls:

/* surround side power up or down */

static int snd_ac97_vt1618_surside_info(struct snd_kcontrol *kcontrol,
				     struct snd_ctl_elem_info *uinfo)
{
	static const char* texts[] = {"On", "Off"};
	return ac97_enum_text_info(kcontrol, uinfo, texts, 2);
}

static int snd_ac97_vt1618_surside_get(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value
*ucontrol) {
	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
  
	ucontrol->value.enumerated.item[0] = 
		(snd_ac97_read(pac97, 0x5c) & 0x0008) >> 3;

	return 0;
}

static int snd_ac97_vt1618_surside_put(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value
*ucontrol) {
  //0x5c,  3, 1,
	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);

	snd_ac97_update_bits(pac97, 0x5c, 0x0008,
			     ucontrol->value.enumerated.item[0] << 3);
	return 0;
}

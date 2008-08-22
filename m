From: "John L. Utz III" <john.utz@dmx.com>
Subject: i think ac97 needs an is_surback_on() function
Date: Fri, 22 Aug 2008 15:20:09 -0700
Message-ID: <op.uga6zvtg647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 722CF24398
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Aug 2008 00:20:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

ac97_patch.c provides two helper functions that wrap the channel_mode  
variable, but they only take you out to 5.1 Audio:

static inline int is_surround_on(struct snd_ac97 *ac97)
{
	return ac97->channel_mode >= 1;
}

static inline int is_clfe_on(struct snd_ac97 *ac97)
{
	return ac97->channel_mode >= 2;
}


For 7.1 Audio, i think there needs to be a test for 'Surround Back' or  
'Back Surround'

static inline int is_surback_on(struct snd_ac97 *ac97)
{
	return ac97->channel_mode >= 4;
}


Am i correct? or am i mistaken? agreement or corrections appreciated!

I think that i need this function for implementing vt1618_update_jacks()  
because vt1618 is 7.1 Audio:

static void vt1618_update_jacks(struct snd_ac97 *ac97)
{
	unsigned short usSft = 0, usMsk = 0x0003;

	if(is_surround_on(ac97))
		ac97_update_bits_page(ac97, 0x60, 0x000C,
				      ucontrol->value.enumerated.item[0]<<2,
				      0);

	if(is_clfe_on(ac97))
		ac97_update_bits_page(ac97, 0x60, 0x0030,
				      ucontrol->value.enumerated.item[0]<<4,
				      0);

	if(is_surback_on(ac97)) {
		/* toggle surround rear dac power */

		snd_ac97_update_bits(ac97, 0x5c, 0x0008,
				     ucontrol->value.enumerated.item[0] << 3);

		/* toggle aux in surround rear out jack */

		snd_ac97_update_bits(ac97, 0x76, 0x0008,
				     ucontrol->value.enumerated.item[0] << 3);
	}
}

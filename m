From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [Fwd: Re: newer C-Media CMI9761A], No PCM Master
 slider functional
Date: Sat, 19 Feb 2005 00:13:32 +0100
Message-ID: <4216769C.6000209@gmx.de>
References: <42162C3C.6000703@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <42162C3C.6000703@gmx.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

ok. got the pcm master slider. no function.

if the bitsetting is correct, theres no hardware gain driver for pcm 
master on the chip.

so back to head cvs and find out whats wrong with the pcm sound with 
patch_9761().

tom

static void check_volume_resolution(ac97_t *ac97, int reg, unsigned char 
*lo_max, unsigned char *hi_max)
{
	unsigned short cbit[3] = { 0x20, 0x10, 0x01 };
	unsigned char max[3] = { 63, 31, 15 };
	int i;

	*lo_max = *hi_max = 0;
	for (i = 0 ; i < ARRAY_SIZE(cbit); i++) {
		unsigned short val;
		snd_ac97_write(ac97, reg, 0x8080 | cbit[i] | (cbit[i] << 8));
		val = snd_ac97_read(ac97, reg);
		if (! *lo_max && (val & cbit[i]))
			*lo_max = max[i];
		if (! *hi_max && (val & (cbit[i] << 8)))
			*hi_max = max[i];
		if (*lo_max && *hi_max)
			break;
	}
	snd_printk (KERN_ERR "vol res reg %d hi %d low %d\n", reg, *lo_max, 
*hi_max);
	*lo_max = 31; *hi_max = 31;
}


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

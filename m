From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: bad page when freeing preallocated pages
Date: Wed, 26 Apr 2006 10:30:30 +0200
Message-ID: <444F2FA6.7010305@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello

I'm currently developing an alsa driver for an audio DAC used on an
embedded platform. I have come upon an issue when I try to free my
preallocated pages.

Some code snips from the driver I assume is most relevant:

static void snd_at73c213_pcm_free(snd_pcm_t *pcm)
{
	struct snd_at73c213 *chip = snd_pcm_chip(pcm);
	if (chip->pcm != 0 ) {
		snd_pcm_lib_preallocate_free_for_all(chip->pcm);
		chip->pcm = NULL;
	}
}

static int __devinit snd_at73c213_new_pcm(struct snd_at73c213 *chip, int
device)
{
	snd_pcm_t *pcm;
	int retval;

	retval = snd_pcm_new(chip->card, "AT73C213 on STK1000", device, 1, 0,
&pcm);
	if (retval < 0)
		return retval;

	pcm->private_data = chip;
	pcm->private_free = snd_at73c213_pcm_free;
	pcm->info_flags = SNDRV_PCM_INFO_BLOCK_TRANSFER;
	strcpy(pcm->name, "AT73C213 on STK1000");
	chip->pcm = pcm;

	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &at73c213_playback_ops);

	snd_pcm_lib_preallocate_pages_for_all(chip->pcm, SNDRV_DMA_TYPE_DEV,
snd_dma_continuous_data(GFP_KERNEL), 64 * 1024, 64 * 1024);

	return 0;
}

When removing the module from the kernel with rmmod I get alot of bad
pages, because the page is mapped when it's freed. The weird thing is
that the pages are mapped to address 0x00000000.

Example:
[  141.380000] Bad page state in process 'rmmod'
[17179650.992000] page:90200600 flags:0x00004000 mapping:00000000
mapcount:0 count:0

Sorry if my email is lacking information, I'll gladly provide more
information.

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: AC'97 recording on AT91sam9263
Date: Wed, 21 May 2008 14:50:29 +0200
Message-ID: <48341A95.3080902@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 088912455D
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 14:50:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to write the AC'97 driver(recording) and I encounter some 
problems.
I would like to set up some constraints but if I do so I will have a seg 
fault when running arecord.

here is my open function:

/* define the constraints */
static unsigned int rates[] = {
	8000, 44100,
};

static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
	.count	= ARRAY_SIZE(rates),
	.list	= rates,
	.mask	= 0,
};


...


static int snd_at91_ac97_capture_open(struct snd_pcm_substream *substream)
{
	at91_ac97_t *chip = snd_pcm_substream_chip(substream);
	struct snd_pcm_runtime *runtime = substream->runtime;
	int err;

	runtime->hw = snd_at91_ac97_capture_hw;
	chip->capture_substream = substream;
	chip->period = 0;

	if ((err = snd_pcm_hw_constraint_list(runtime, 0, 
SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates)) < 0)
		return err;

	snd_printd(KERN_DEBUG "%s : snd_at91_ac97_capture_open\n\r", driver_name);

	return 0;
}

I have another problem if I try to set up some constraint on the format.
Indeed I do exactly the same as for the rate, but then it will fail in 
aplay.c in the function set_params, returning the error message:"Broken 
configuration for this PCM: no configuration available."

Do I miss something when trying to set up the constraints?
Is there any particular way for setting the format constraints?

Regards,
Sedji

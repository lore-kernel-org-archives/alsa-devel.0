From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: echoaudio: cleanup of unnecessary messages
Date: Tue, 04 Nov 2014 10:28:01 -0800
Message-ID: <1415125681.23168.1.camel@perches.com>
References: <1415125074-28006-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415125074-28006-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-11-04 at 23:47 +0530, Sudip Mukherjee wrote:
> commit "b5b4a41b392960010fccf1f9ccf8334d612bd450" was dereferencing
> chip after it has been freed. This patch fixes that and at the same
> time removes some debugging messages, which are unnecessary, as they
> are just printing information about entry and exit from a function.
> This information we can easily get from ftrace.

Mostly true.

> diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
[]
> @@ -763,10 +755,8 @@ static int pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  	spin_lock(&chip->lock);
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_RESUME:
> -		dev_dbg(chip->card->dev, "pcm_trigger resume\n");
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		dev_dbg(chip->card->dev, "pcm_trigger start\n");
>  		for (i = 0; i < DSP_MAXPIPES; i++) {
>  			if (channelmask & (1 << i)) {
>  				pipe = chip->substream[i]->runtime->private_data;

These may not be useful but this switch state information
can't be got from ftrace.

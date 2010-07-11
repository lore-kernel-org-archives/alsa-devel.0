From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 3/3] sound: push BKL into open functions
Date: Sun, 11 Jul 2010 09:15:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007110913120.16744@eeebox2.perex-int.cz>
References: <1278798701-11171-1-git-send-email-arnd@arndb.de>
	<1278798701-11171-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A99AF24476
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Jul 2010 09:15:23 +0200 (CEST)
In-Reply-To: <1278798701-11171-4-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Kacur <jkacur@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Sat, 10 Jul 2010, Arnd Bergmann wrote:

> --- a/sound/core/hwdep.c
> +++ b/sound/core/hwdep.c
> @@ -94,13 +94,18 @@ static int snd_hwdep_open(struct inode *inode, struct file * file)
> 		hw = snd_lookup_oss_minor_data(iminor(inode),
> 					       SNDRV_OSS_DEVICE_TYPE_DMFM);
> #endif
> -	} else
> -		return -ENXIO;
> +	} else {
> +		err = -ENXIO;
> +		goto out;
> +	}
> +
> +	err = -ENODEV;
> 	if (hw == NULL)
> -		return -ENODEV;
> +		goto out;
>
> +	err = -EFAULT;
> 	if (!try_module_get(hw->card->module))
> -		return -EFAULT;
> +		goto out;
>
> 	init_waitqueue_entry(&wait, current);
> 	add_wait_queue(&hw->open_wait, &wait);
> @@ -147,6 +152,7 @@ static int snd_hwdep_open(struct inode *inode, struct file * file)
> 	mutex_unlock(&hw->open_mutex);
> 	if (err < 0)
> 		module_put(hw->card->module);
> +out:
> 	return err;
> }
>
> diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
> index f50ebf2..c30b1f3 100644
> --- a/sound/core/oss/mixer_oss.c
> +++ b/sound/core/oss/mixer_oss.c
> @@ -49,17 +49,19 @@ static int snd_mixer_oss_open(struct inode *inode, struct file *file)
>
> 	card = snd_lookup_oss_minor_data(iminor(inode),
> 					 SNDRV_OSS_DEVICE_TYPE_MIXER);
> -	if (card == NULL)
> -		return -ENODEV;
> -	if (card->mixer_oss == NULL)
> -		return -ENODEV;
> +	err = -ENODEV;
> +	if (card == NULL || card->mixer_oss == NULL)
> +		goto out;
> +
> 	err = snd_card_file_add(card, file);
> 	if (err < 0)
> -		return err;
> +		goto out;
> +
> 	fmixer = kzalloc(sizeof(*fmixer), GFP_KERNEL);
> 	if (fmixer == NULL) {
> 		snd_card_file_remove(card, file);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto out;
> 	}
> 	fmixer->card = card;
> 	fmixer->mixer = card->mixer_oss;
> @@ -67,9 +69,10 @@ static int snd_mixer_oss_open(struct inode *inode, struct file *file)
> 	if (!try_module_get(card->module)) {
> 		kfree(fmixer);
> 		snd_card_file_remove(card, file);
> -		return -EFAULT;
> +		err = -EFAULT;
> 	}
> -	return 0;
> +out:
> +	return err;
> }
>

I don't see any reason (benefit) to add gotos to these two functions.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.

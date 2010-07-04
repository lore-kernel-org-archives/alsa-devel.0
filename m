From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/6] sound/oss: convert to unlocked_ioctl
Date: Sun, 4 Jul 2010 13:08:35 +0200
Message-ID: <20100704110835.GA31920@merkur.ravnborg.org>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de>
	<1278195310-25590-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 4125E24150
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Jul 2010 13:08:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1278195310-25590-3-git-send-email-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>
List-Id: alsa-devel@alsa-project.org

> 
> diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
> index c1070e3..3547450 100644
> --- a/sound/oss/au1550_ac97.c
> +++ b/sound/oss/au1550_ac97.c
> @@ -824,22 +824,26 @@ mixdev_ioctl(struct ac97_codec *codec, unsigned int cmd,
>  	return codec->mixer_ioctl(codec, cmd, arg);
>  }
>  
> -static int
> -au1550_ioctl_mixdev(struct inode *inode, struct file *file,
> -			       unsigned int cmd, unsigned long arg)
> +static long
> +au1550_ioctl_mixdev(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct au1550_state *s = (struct au1550_state *)file->private_data;
>  	struct ac97_codec *codec = s->codec;
> +	int ret;
> +
> +	lock_kernel();
> +	ret = mixdev_ioctl(codec, cmd, arg);
> +	unlock_kernel();
>  
> -	return mixdev_ioctl(codec, cmd, arg);
> +	return ret;
>  }

General comment...
In several places you declare a local variable of type "int",
but the function return a long.

I know that mixdev_ioctl() return an int so nothing is lost but
it just looks wrong.

> diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
> index 3f3c3f7..b5464fb 100644
> --- a/sound/oss/dmasound/dmasound_core.c
> +++ b/sound/oss/dmasound/dmasound_core.c
> @@ -337,8 +337,8 @@ static int mixer_release(struct inode *inode, struct file *file)
>  	unlock_kernel();
>  	return 0;
>  }
> -static int mixer_ioctl(struct inode *inode, struct file *file, u_int cmd,
> -		       u_long arg)
> +
> +static long mixer_ioctl(struct file *file, u_int cmd, u_long arg)
>  {
>  	if (_SIOC_DIR(cmd) & _SIOC_WRITE)
>  	    mixer.modify_counter++;
> @@ -362,11 +362,22 @@ static int mixer_ioctl(struct inode *inode, struct file *file, u_int cmd,
>  	return -EINVAL;
>  }
>  
> +static long mixer_unlocked_ioctl(struct file *file, u_int cmd, u_long arg)
> +{
> +	int ret;
> +
> +	lock_kernel();
> +	ret = mixer_ioctl(file, cmd, arg);
> +	unlock_kernel();
> +
> +	return ret;
> +}

Here it looks like a potential but.
mixer_ioctl() return a long which is stored in an int and then we return a long.


> -static int sq_ioctl(struct inode *inode, struct file *file, u_int cmd,
> -		    u_long arg)
> +static long sq_ioctl(struct file *file, u_int cmd, u_long arg)
>  {
>  	int val, result;
>  	u_long fmt;
> @@ -1114,18 +1124,29 @@ static int sq_ioctl(struct inode *inode, struct file *file, u_int cmd,
>  		return IOCTL_OUT(arg,val);
>  
>  	default:
> -		return mixer_ioctl(inode, file, cmd, arg);
> +		return mixer_ioctl(file, cmd, arg);
>  	}
>  	return -EINVAL;
>  }
>  
> +static long sq_unlocked_ioctl(struct file *file, u_int cmd, u_long arg)
> +{
> +	int ret;
> +
> +	lock_kernel();
> +	ret = sq_ioctl(file, cmd, arg);
> +	unlock_kernel();
> +
> +	return ret;
> +}
ditto: long -> int -> long


	Sam

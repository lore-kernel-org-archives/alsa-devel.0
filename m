From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa-lib: fixed coverity reported issues
 under	"USE_AFTER_FREE" checker.
Date: Thu, 17 Mar 2011 12:22:24 +0100
Message-ID: <4D81EEF0.6010109@ladisch.de>
References: <1300349539-32209-1-git-send-email-sudarshan.bisht@nokia.com>
	<1300349539-32209-2-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 1EAFF103974
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 12:20:49 +0100 (CET)
In-Reply-To: <1300349539-32209-2-git-send-email-sudarshan.bisht@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sudarshan.bisht@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sudarshan.bisht@nokia.com wrote:
> --- a/src/control/control_hw.c
> +++ b/src/control/control_hw.c
> @@ -414,6 +414,7 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
>  	if (err < 0) {
>  		close(fd);
>  		free(hw);
> +		hw = NULL;
>  	}

In this place, it's just a "return err" that is missing.

> --- a/src/mixer/mixer.c
> +++ b/src/mixer/mixer.c
> @@ -205,7 +205,7 @@ int snd_mixer_attach(snd_mixer_t *mixer, const char *name)
>  		return err;
>  	err = snd_mixer_attach_hctl(mixer, hctl);
>  	if (err < 0) {
> -		snd_hctl_close(hctl);
> +		/* ideally hctl should be freed here, but it's taken care in snd_mixer_attach_hctl*/	
>  		return err;
>  	}

If the calloc() in snd_mixer_attach_hctl() fails, hctl is not freed.
The bug is the inconsistent error handling cleanup in
snd_mixer_attach_hctl(); I think it shouldn't free its hctl in any case.


Regards,
Clemens

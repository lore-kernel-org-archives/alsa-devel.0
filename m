From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH] alsa-lib: fixed coverity reported issues
 under	"USE_AFTER_FREE" checker.
Date: Thu, 17 Mar 2011 15:33:47 +0200
Message-ID: <1300368827.2435.72.camel@Sudarshan.research.nokia.com>
References: <1300349539-32209-1-git-send-email-sudarshan.bisht@nokia.com>
	<1300349539-32209-2-git-send-email-sudarshan.bisht@nokia.com>
	<4D81EEF0.6010109@ladisch.de>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BC8624374
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 14:35:26 +0100 (CET)
In-Reply-To: <4D81EEF0.6010109@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-17 at 12:22 +0100, ext Clemens Ladisch wrote:
> sudarshan.bisht@nokia.com wrote:
> > --- a/src/control/control_hw.c
> > +++ b/src/control/control_hw.c
> > @@ -414,6 +414,7 @@ int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
> >  	if (err < 0) {
> >  		close(fd);
> >  		free(hw);
> > +		hw = NULL;
> >  	}
> 
> In this place, it's just a "return err" that is missing.
Ok.
> 
> > --- a/src/mixer/mixer.c
> > +++ b/src/mixer/mixer.c
> > @@ -205,7 +205,7 @@ int snd_mixer_attach(snd_mixer_t *mixer, const char *name)
> >  		return err;
> >  	err = snd_mixer_attach_hctl(mixer, hctl);
> >  	if (err < 0) {
> > -		snd_hctl_close(hctl);
> > +		/* ideally hctl should be freed here, but it's taken care in snd_mixer_attach_hctl*/	
> >  		return err;
> >  	}
> 
> If the calloc() in snd_mixer_attach_hctl() fails, hctl is not freed.
> The bug is the inconsistent error handling cleanup in
> snd_mixer_attach_hctl(); I think it shouldn't free its hctl in any case.
Ok, I will remove freeing of hctl from snd_mixer_attach_hctl().
> 
> 
> Regards,
> Clemens


Br,
Sudarshan Bisht

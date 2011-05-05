From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 1/2] alsa-lib: fixed coverity reported
 issues under "USE_AFTER_FREE" checker.
Date: Thu, 05 May 2011 15:01:16 +0300
Message-ID: <1304596876.2543.171.camel@Sudarshan.research.nokia.com>
References: <1304502361-14430-1-git-send-email-sudarshan.bisht@nokia.com>
	<1304502361-14430-2-git-send-email-sudarshan.bisht@nokia.com>
	<s5h8vumpz49.wl%tiwai@suse.de>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 225B8103813
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 14:01:43 +0200 (CEST)
In-Reply-To: <s5h8vumpz49.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-05-04 at 11:57 +0200, ext Takashi Iwai wrote:
> At Wed,  4 May 2011 12:46:01 +0300,
> sudarshan.bisht@nokia.com wrote:
> > 
> > From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
> > 
> > Coverity Static Analysis helps developers find hard-to-spot,
> > yet potentially crash-causing defects early in the development phase,
> > reducing the cost,time, and risk of software errors.
> > 
> > This patch has fixes for 1) a junk assignment and 2) memory freed at wrong location.
> > 
> > ---
> >  modules/mixer/simple/python.c |    1 +
> >  src/control/control_hw.c      |    1 +
> >  src/mixer/mixer.c             |    1 -
> >  3 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/modules/mixer/simple/python.c b/modules/mixer/simple/python.c
> > index c822c52..784d9a0 100644
> > --- a/modules/mixer/simple/python.c
> > +++ b/modules/mixer/simple/python.c
> > @@ -663,6 +663,7 @@ pymixer_attach_hctl(struct pymixer *pymixer, PyObject *args)
> >  		return NULL;
> >  	err = snd_mixer_attach_hctl(pymixer->mixer, hctl);
> >  	if (err < 0) {
> > +		snd_hctl_close(hctl);
> >  		PyErr_Format(PyExc_RuntimeError, "Cannot attach hctl: %s", snd_strerror(err));
> >  		return NULL;
> >  	}
> 
> This doesn't look good.
> We did close mistakenly in snd_mixer_attach_hctl() in the error case,
> and it's fixed by your patch.  But this behavior shouldn't be inherited.
> 
Sorry but I did not understand whether you want to have this fix in
patch or not ? 

> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

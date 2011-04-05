From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 3/3 v4] alsa-lib: fixed coverity reported
 issues under "USE_AFTER_FREE" checker.
Date: Tue, 05 Apr 2011 10:44:15 +0300
Message-ID: <1301989455.16314.251.camel@Sudarshan.research.nokia.com>
References: <1301911442-10898-1-git-send-email-sudarshan.bisht@nokia.com>
	<s5hoc4mti6a.wl%tiwai@suse.de>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A98B1039DB
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 09:46:38 +0200 (CEST)
In-Reply-To: <s5hoc4mti6a.wl%tiwai@suse.de>
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

On Mon, 2011-04-04 at 12:38 +0200, ext Takashi Iwai wrote:
> At Mon,  4 Apr 2011 13:04:02 +0300,
> sudarshan.bisht@nokia.com wrote:
> > 
> > diff --git a/src/mixer/simple_abst.c b/src/mixer/simple_abst.c
> > index 9e9aaf5..c722b02 100644
> > --- a/src/mixer/simple_abst.c
> > +++ b/src/mixer/simple_abst.c
> > @@ -336,6 +336,8 @@ int snd_mixer_simple_basic_register(snd_mixer_t *mixer,
> >  		err = find_module(class, top);
> >  	if (err >= 0)
> >  		err = snd_mixer_attach_hctl(mixer, priv->hctl);
> > +		if (err < 0)
> > +			goto __error;
> >  	if (err >= 0) {
> >  		priv->attach_flag = 1;
> >  		err = snd_mixer_class_register(class, mixer);
> 
> You need braces.
> But, actually this check isn't needed.  If you follow the code below
> there, it reaches to __error properly when err < 0.
   Yes, there is no need of this check.   
> 
> thanks,
> 
> Takashi


Thanks,

Sudarshan 

From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 2/2] alsa-lib: fixed coverity reported
 issues under "RESOURCE_LEAK" checker.
Date: Thu, 05 May 2011 14:59:43 +0300
Message-ID: <1304596783.2543.170.camel@Sudarshan.research.nokia.com>
References: <1304502361-14430-1-git-send-email-sudarshan.bisht@nokia.com>
	<s5haaf2pzb1.wl%tiwai@suse.de>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id D97E0103813
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 14:00:16 +0200 (CEST)
In-Reply-To: <s5haaf2pzb1.wl%tiwai@suse.de>
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

On Wed, 2011-05-04 at 11:53 +0200, ext Takashi Iwai wrote:
> At Wed,  4 May 2011 12:46:00 +0300,
> sudarshan.bisht@nokia.com wrote:
> > 
> > diff --git a/src/conf.c b/src/conf.c
> > index ddefff6..842e5e3 100644
> > --- a/src/conf.c
> > +++ b/src/conf.c
> > @@ -638,6 +638,7 @@ static int get_char_skip_comments(input_t *input)
> >  			fd = malloc(sizeof(*fd));
> >  			if (!fd) {
> >  				free(str);
> > +				snd_input_close(in);
> >  				return -ENOMEM;
> >  			}
> >  			fd->name = str;
> 
> I don't think this is correct.  The close should be never called
> during the operation in the library function.
Ok,
> 
> 
> > diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
> > index bfa1cc8..adba7c0 100644
> > --- a/src/pcm/pcm_file.c
> > +++ b/src/pcm/pcm_file.c
> > @@ -226,7 +226,9 @@ static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
> >  					file->final_fname);
> >  			return -errno;
> >  		}
> > -		fd = fileno(pipe);
> > +		fd = dup(fileno(pipe));
> > +		if (fd >= 0)
> > +			fclose(pipe);
> 
> The error handling is missing?
Yes, in case of fd having value less then 0. 

> thanks,
> 
> Takashi

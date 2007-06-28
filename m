From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: SALSA-Lib: snd_pcm_hw_params_any clobbers memory
Date: Thu, 28 Jun 2007 14:45:02 -0400
Message-ID: <20070628144502.515c47d0.alsauser@pragmasoft.com>
References: <20070627163352.2559a026.alsauser@pragmasoft.com>
	<s5h3b0ce30v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.server.rpi.edu (smtp6.server.rpi.edu [128.113.2.226])
	by alsa0.perex.cz (Postfix) with ESMTP id ADEFE24416
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 20:41:58 +0200 (CEST)
In-Reply-To: <s5h3b0ce30v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Jun 2007 13:23:28 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 27 Jun 2007 16:33:52 -0400,
> J. Scott Merritt wrote:
> > 
> > Dear list,
> > 
> > Using SALSA-Lib 0.0.2, I call
> >    snd_pcm_open
> >    snd_pcm_hw_params_malloc
> >    snd_pcm_hw_params_any
> > 
> > The call to snd_pcm_hw_params_any appears to clobber memory beyond
> > the end of the hw_params allocated by snd_pcm_hw_params_malloc (as
> > reported by linking in -lmcheck).
> 
> Gosh, my bad.  I didn't test *_malloc() at all.
> 
> There was a stupid bug in the template I copy-n-pasted.  The fix patch
> is below.  I'll release version 0.0.3 soon later.
> 
> Thanks for reporting!
> 
> 
> Takashi

Problem resolved in SALSA-Lib 0.0.3 - thanks :)
(subsequent problem reported in new thread)

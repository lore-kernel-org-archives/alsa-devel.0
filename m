From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 15/27] ALSA: hda - Use
 timecounter_initialize interface
Date: Fri, 15 Dec 2017 08:51:25 -0800
Message-ID: <20171215165125.avkz25eek56i5md4@localhost>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-16-git-send-email-sagar.a.kamble@intel.com>
 <s5hh8ssgsaw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B3B5266BF5
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 17:51:30 +0100 (CET)
Received: by mail-pf0-f170.google.com with SMTP id m26so6519696pfj.11
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 08:51:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <s5hh8ssgsaw.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Sagar Arun Kamble <sagar.a.kamble@intel.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 15, 2017 at 12:10:47PM +0100, Takashi Iwai wrote:

> > -	struct cyclecounter *cc = &azx_dev->tc.cc;

> > -	cc->read = azx_cc_read;
> > -	cc->mask = CLOCKSOURCE_MASK(32);

> > -	cc->mult = 125; /* saturation after 195 years */
> > -	cc->shift = 0;

I want to get away from this mess of open coded structure
initialization and use a proper functional interface instead.

> >  	nsec = 0; /* audio time is elapsed time since trigger */
> > -	timecounter_init(tc, nsec);
> > +	timecounter_initialize(tc,
> > +			       azx_cc_read,
> > +			       CLOCKSOURCE_MASK(32),
> > +			       125, /* saturation after 195 years */
> > +			       0,
> > +			       nsec);
> 
> Hmm, a function with so many arguments is difficult to remember and is
> often error-prone.  By this transition, it becomes harder to read
> through.

Please suggest a better way.

Thanks,
Richard

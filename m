From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: updated patch for period_size constraint
Date: Tue, 10 Sep 2002 10:06:31 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020910170631.58483.qmail@web11504.mail.yahoo.com>
References: <s5h65xdzta2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11504.mail.yahoo.com (web11504.mail.yahoo.com [216.136.172.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id TAA29772
	for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2002 19:06:34 +0200
In-Reply-To: <s5h65xdzta2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > I modified my previous patch for supporting a period_size (rather than
> > period_bytes) constraint with Takashi's suggestion that the fields be
> > non-zero for either constraint to kick in. See file in attachment.
> > It has worked fine on my hardware for the past few days.
> 
> you don't need to modify the common code.
> my intention was not to change the common code, too, unless other
> drivers also need this constraint.

I got you wrong, sorry.

> just add the constraint in open callback, such like
> 
> int your_pcm_open(snd_pcm_substream_t *substream)
> {
> ...
> 
> err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> 			   your_period_size_min, your_period_size_max);
> ...
> }
> 
> this is the cleanest solution.

Sure, but then I also need to define .period_bytes_min and .period_bytes_max in
my snd_pcm_hardware_t, right? This is quite feasible, indeed.

Guilhem.


__________________________________________________
Yahoo! - We Remember
9-11: A tribute to the more than 3,000 lives lost
http://dir.remember.yahoo.com/tribute


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

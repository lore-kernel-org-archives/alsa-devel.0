From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 0/4] Intel HDMI audio fixes
Date: Thu, 12 Feb 2009 15:58:35 +0800
Message-ID: <20090212075835.GA15713@localhost>
References: <20090211072227.760779741@intel.com>
	<20090211223241.GA31322@csy.ca> <s5hfxik8ukn.wl%tiwai@suse.de>
	<20090212012504.GA6387@localhost> <s5hhc30m6oa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id CD0D31038BE
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 08:58:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhc30m6oa.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 12, 2009 at 09:54:29AM +0200, Takashi Iwai wrote:
> At Thu, 12 Feb 2009 09:25:04 +0800,
> Wu Fengguang wrote:
> > 
> > Before beginning our discussion, I'd like to first submit a patch for
> > speaker-test. I guess the ordering in it defines the ALSA order.
> 
> The change looks good but the patch is rejected.
> Could you create a patch based on the latest version?
 
OK. I'll resubmit it sometime later, because it's not convenient for now
to do the git pull inside company firewall...

Thanks,
Fengguang

> > ---
> > speaker-test.c - add readability comments to speaker channels
> > 
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> > ---
> > 
> > diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
> > index 57a7cbc..bf97d33 100644
> > --- a/speaker-test/speaker-test.c
> > +++ b/speaker-test/speaker-test.c
> > @@ -84,48 +84,48 @@ static const char *given_test_wav_file = NULL;
> >  static char *wav_file_dir = SOUNDSDIR;
> >  
> >  static const char        *channel_name[MAX_CHANNELS] = {
> > -  N_("Front Left"),
> > -  N_("Front Right"),
> > -  N_("Rear Left"),
> > -  N_("Rear Right"),
> > -  N_("Center"),
> > -  N_("LFE"),
> > -  N_("Side Left"),
> > -  N_("Side Right"),
> > -  N_("Channel 9"),
> > -  N_("Channel 10"),
> > -  N_("Channel 11"),
> > -  N_("Channel 12"),
> > -  N_("Channel 13"),
> > -  N_("Channel 14"),
> > -  N_("Channel 15"),
> > -  N_("Channel 16")
> > +  /*  0 */ N_("Front Left"),
> > +  /*  1 */ N_("Front Right"),
> > +  /*  2 */ N_("Rear Left"),
> > +  /*  3 */ N_("Rear Right"),
> > +  /*  4 */ N_("Center"),
> > +  /*  5 */ N_("LFE"),
> > +  /*  6 */ N_("Side Left"),
> > +  /*  7 */ N_("Side Right"),
> > +  /*  8 */ N_("Channel 9"),
> > +  /*  9 */ N_("Channel 10"),
> > +  /* 10 */ N_("Channel 11"),
> > +  /* 11 */ N_("Channel 12"),
> > +  /* 12 */ N_("Channel 13"),
> > +  /* 13 */ N_("Channel 14"),
> > +  /* 14 */ N_("Channel 15"),
> > +  /* 15 */ N_("Channel 16")
> >  };
> >  
> >  static const int	channels4[] = {
> > -  0,
> > -  1,
> > -  3,
> > -  2
> > +  0, /* Front Left  */
> > +  1, /* Front Right */
> > +  3, /* Rear Right  */
> > +  2, /* Rear Left   */
> >  };
> >  static const int	channels6[] = {
> > -  0,
> > -  4,
> > -  1,
> > -  3,
> > -  2,
> > -  5
> > -}; 
> > +  0, /* Front Left  */
> > +  4, /* Center      */
> > +  1, /* Front Right */
> > +  3, /* Rear Right  */
> > +  2, /* Rear Left   */
> > +  5, /* LFE         */
> > +};
> >  static const int	channels8[] = {
> > -  0,
> > -  4,
> > -  1,
> > -  7,
> > -  3,
> > -  2,
> > -  6,
> > -  5
> > -}; 
> > +  0, /* Front Left  */
> > +  4, /* Center      */
> > +  1, /* Front Right */
> > +  7, /* Side Right  */
> > +  3, /* Rear Right  */
> > +  2, /* Rear Left   */
> > +  6, /* Side Left   */
> > +  5, /* LFE         */
> > +};
> >  
> >  static void generate_sine(uint8_t *frames, int channel, int count, double *_phase) {
> >    double phase = *_phase;
> > 

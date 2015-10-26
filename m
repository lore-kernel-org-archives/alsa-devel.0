From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: BAT: restructuring code
Date: Mon, 26 Oct 2015 09:11:57 +0000
Message-ID: <1445850717.2487.35.camel@loki>
References: <CAG5mAdzfSiKTVZDttkr-=r48tYbwMo=0KdehRoH3GDGpj-OCqg@mail.gmail.com>
 <1445597272.2491.28.camel@loki>
 <CAG5mAdyXhtQZhMho8axExER37hGQw0svBB5G5nfd1GYCujC0qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C239D260522
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 10:12:01 +0100 (CET)
In-Reply-To: <CAG5mAdyXhtQZhMho8axExER37hGQw0svBB5G5nfd1GYCujC0qg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-10-23 at 10:54 -0700, Caleb Crome wrote:
> On Fri, Oct 23, 2015 at 3:47 AM, Liam Girdwood
> <liam.r.girdwood@linux.intel.com> wrote:
> > Hi Caleb,
> >
> > I have no problem as long as we can still support Android (via tinyalsa)
> > and Chrome (via alsa-lib) and also tinycompress. You will need to
> > justify any changes you make in your commit message.
> >
> > Btw, probably best to also CC alsa-devel mailing list for these sort of
> > questions too as other folks doing BAT patches may also be interested.
> >
> > Fwiw, a structure like your proposing could also be used for SIMD based
> > optimisations too (if we ever need them).
> >
> > Liam
> >
> > On Thu, 2015-10-22 at 17:23 -0700, Caleb Crome wrote:
> >> Hi guys,
> >>    since i've got several different tests to write, I'm basically
> >> rewriting a meaningful section of the code to make the
> >> init/generate/playout/analyze modular.
> >>
> >> To that end, I'm creating a struct like this:
> >>
> >>
> >> struct bat_ops {
> >>     (void *)(*init)(int channels, int format, float sample_rate, float
> >> *frequencies)
> >>     // generate_playout_data is called every period to, well, generate
> >> the data to be played.
> >>     int     (*generate_playout_data)(void *priv, int frames, void *buffer);
> >>     // process_capture_data is called every period to do something
> >> with the data.
> >>     int     (*process_input_data)(void *priv, int frames, const void *buffer);
> >>     // analyze is called at the end of the whole capture time.  Can be
> >> used to analyze and report results.
> >>     int     (*analyze)(void *priv);
> >>     void    (*free)(**priv);
> >> };
> >>
> >> Then, we can create a separate ops struct for each type of test, i.e.
> >> a generated sine wave, reading from a file, ramp test, etc.
> >>
> >> The alsa code is fantastically complex, so I'm not touching any of
> >> that.  :-/   Just splitting out the generate, capture, and analysis to
> >> be modular.
> >>
> >> Let me know if you think this is going to be a problem.
> >>
> >> -Caleb
> >
> >
> 
> In order to support the molecularity, I need the ability for each
> module (i.e. test type) to accept its own arguments.  In order to
> accomplish this, I think it would be better to use argp instead of
> getopt_long.  Is it okay if I switch it over?  Will that break
> android?
> 

Yes, that should be fine as long as we keep consistency with the switch
names.

This will probably be useful for the stand alone module (for IoT) that
Han is doing too. This module will not do any analysis (test execution
only) and wont have dependencies on fftw3 so will be very small and
easily installable on IoT/Android style devices. 

> Basically, I need the general options like sample rate, channels and
> format to be in the first set of arguments, but then be able to call a
> second parser to manage the module's options, like sine frequency (for
> the sine based test), or impulse response length (for an impulse
> response test).
> 
> Perhaps there's a way to do it with getopt_long, but it doesn't look
> too simple because getopt_long requires all the options to be already
> defined before parsing starts, whereas argp can bring in new parsers
> (from the ops struct previously described).
> 
> Any thoughts?

No, I think you are probably on the right track here if you need to pass
cmd line args to other modules.

Liam

> 
> -Caleb

From: Henrik Eriksson <henrik.eriksson@axis.com>
Subject: Re: [RFC PATCH] ALSA: core: do not update tstamp when
 hw ptr has not moved
Date: Mon, 20 Nov 2017 14:13:32 +0100
Message-ID: <20171120131332.GF5483@lnxhenriken2.se.axis.com>
References: <20171116124349.GA21810@lnxhenriken2.se.axis.com>
 <s5h375e2sbb.wl-tiwai@suse.de>
 <172e5ff0-472e-be36-0208-5ccc88baebfa@linux.intel.com>
 <s5h8tf69hz3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B77C266FEC
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 14:13:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8tf69hz3.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Henrik Eriksson <henriken@axis.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu,=A0Nov=A016,=A02017=A0at=A019:49:36=A0+0100, Takashi Iwai wrote:
> On Thu, 16 Nov 2017 19:11:37 +0100,
> Pierre-Louis Bossart wrote:
> > =

> > On 11/16/17 8:48 AM, Takashi Iwai wrote:
> > > On Thu, 16 Nov 2017 13:43:57 +0100,
> > > Henrik Eriksson wrote:
> > >>
> > >> This reverts a change that was part of a larger commit.  That change
> > >> broke timestamps in some application code for us as outlined in the =
log,
> > >> and reverting it obviously fixes this.  Since the original change did
> > >> not explain why the behaviour was modified I can't speak for the eff=
ects
> > >> on that use case.

> > > So this is a regression and we need to address it.
> > >
> > > I *guess* that the reason to update tstamp event at the same hwptr is
> > > that now we can get a more fine-grained tstamp.  OTOH, we have to
> > > avoid the regression by that.
> > >
> > > What about the (untested) patch like below?  It skips the tstamp
> > > update as default but follows the new standard when a better tstamp
> > > mode is deployed.
> > =

> > update_audio_tstamp() only updates the audio timestamp when the type
> > is DEFAULT already, but indeed update runtime->status->tstamp is
> > updated unconditionally.
> > =

> > I have a bit of heartburn with the suggested solutions because the
> > delay can change even with the same hw_ptr. Not updating the
> > timestamps would be going back to the days where timing updates was
> > dependent on DMA granularity.
> > =

> > Maybe we could make the tstamp update dependent on a change in
> > audio_tstamp, e.g.
> > =

> > =

> > diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> > index a93a4235a332..b606f3ea7a17 100644
> > --- a/sound/core/pcm_lib.c
> > +++ b/sound/core/pcm_lib.c
> > @@ -248,8 +248,10 @@ static void update_audio_tstamp(struct
> > snd_pcm_substream *substream,
> >                                 runtime->rate);
> >                 *audio_tstamp =3D ns_to_timespec(audio_nsecs);
> >         }
> > -       runtime->status->audio_tstamp =3D *audio_tstamp;
> > -       runtime->status->tstamp =3D *curr_tstamp;
> > +       if (runtime->status->audio_tstamp !=3D *audio_tstamp) {

This should be

if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {

> > +               runtime->status->audio_tstamp =3D *audio_tstamp;
> > +               runtime->status->tstamp =3D *curr_tstamp;
> > +       }
> =

> OK for me as long as it works.
> Henrik?

This appears to work for our use case.

How do I progress this, i.e., do I update my patch to use Pierre-Louis's
fix?  How should I attribute that?

Regards,
/henrik

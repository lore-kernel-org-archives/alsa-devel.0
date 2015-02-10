From: Nick Stoughton <nstoughton@aether.com>
Subject: Re: [PATCH v3 kernel 1/3] snd_pcm_start_at and friends.
Date: Tue, 10 Feb 2015 12:21:01 -0800
Message-ID: <CADO7NSFu+=39Q_j81kH=4-LeRu+V9iwhN4=+xy50DWMutmxKeQ@mail.gmail.com>
References: <1423239388-17745-1-git-send-email-timcussins@eml.cc>
 <54D4ECB5.5060606@linux.intel.com> <54D4F4FB.2020107@eml.cc>
 <54D52BD4.1040202@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CC5B5260547
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 21:21:02 +0100 (CET)
Received: by mail-lb0-f173.google.com with SMTP id n10so11434831lbv.4
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 12:21:02 -0800 (PST)
In-Reply-To: <54D52BD4.1040202@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tim Cussins <timcussins@eml.cc>
List-Id: alsa-devel@alsa-project.org

The most important clock is MONOTONIC_RAW, from which the audio clocks are
ultimately derived. Any system clock that is adjusted by NTP has the
problem that Pierre-Louis describes. My implementation allowed for other
clocks, but my actual use-case only uses MONOTONIC_RAW, and we are
achieving very high accuracy using it.

The primary driver (at least for me) for snd_pcm_start_at() is to be able
to have two separate devices (which are in the background exchanging
information about their respective CLOCK_MONOTONIC_RAW counters) start
playing the same audio at the same time. Therefore, we need a clock that
runs at a constant frequency and from which the I2S bit clock is derived.

*______________________________*
*Nick Stoughton*
 *Aether Things Inc *
 *San Francisco*
  +1 (510) 388 1413


On Fri, Feb 6, 2015 at 1:02 PM, Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

> On 02/06/2015 11:08 AM, Tim Cussins wrote:
> > Hi Pierre,
> >
> > You got here quick!
>
> That's what 6am flights do to you...
>
> >
> > On 06/02/15 16:32, Pierre-Louis Bossart wrote:
> >> On 02/06/2015 10:16 AM, Tim Cussins wrote:
> >>> We introduce the kernel-side of the START_AT ioctl.
> >>>
> >>> struct runtime is updated to hold information about the currently
> >>> active start_at timer, if any. This facilitates cancellation via
> >>> snd_pcm_start_at_abort(), and querying via snd_pcm_status().
> >>>
> >>> struct snd_start_at holds a startat operation and its arguments.
> >>>
> >>> Signed-off-by: Tim Cussins <timcussins@eml.cc>
> >>>
> >>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> >>> index 0e88e7a..2943e1a 100644
> >>> --- a/include/uapi/sound/asound.h
> >>> +++ b/include/uapi/sound/asound.h
> >>> @@ -421,7 +421,10 @@ struct snd_pcm_status {
> >>>       snd_pcm_state_t suspended_state; /* suspended stream state */
> >>>       __u32 reserved_alignment;    /* must be filled with zero */
> >>>       struct timespec audio_tstamp;    /* from sample counter or wall
> clock */
> >>> -    unsigned char reserved[56-sizeof(struct timespec)]; /* must be
> filled with zero */
> >>> +    int startat_pending;        /* 1 if a start_at timer is pending,
> 0 otherwise */
> >>> +    int startat_clock_type;        /* start_at clock type, if pending
> */
> >>> +    struct timespec startat_start_time;    /* start_at start time, if
> pending */
> >>> +    unsigned char reserved[48-(2*sizeof(struct timespec))]; /* must
> be filled with zero */
> >>>   };
> >>>
> >>>   struct snd_pcm_mmap_status {
> >>> @@ -473,6 +476,34 @@ enum {
> >>>       SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
> >>>   };
> >>>
> >>> +enum {
> >>> +    SNDRV_PCM_STARTAT_OP_SET = 0,
> >>> +    SNDRV_PCM_STARTAT_OP_CANCEL,
> >>> +    SNDRV_PCM_STARTAT_OP_STATUS,
> >>> +    SNDRV_PCM_STARTAT_OP_LAST = SNDRV_PCM_STARTAT_OP_STATUS,
> >>> +};
> >>> +
> >>> +enum {
> >>> +        SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY = 0,
> >>> +        SNDRV_PCM_STARTAT_CLOCK_TYPE_MONOTONIC,
> >>> +        SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK,
> >>> +        SNDRV_PCM_STARTAT_CLOCK_TYPE_LAST =
> SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK,
> >>> +};
> >>
> >> Looks like you went back to the original design with all clocks mixed.
> I think it's a better idea to split system timers and audio clocks.
> >> And you are missing MONOTONIC_RAW (no NTP corrections).
> >
> > It's not /quite/ the original design. The start_at API now has its own
> enum of clock types, which are separate from, but semantically the same as,
> timestamping clock types.
> >
> > For the implementation of snd_pcm_start_at, I genuinely prefer the
> unified approach. From the point of view of a /client/ of snd_pcm_start_at,
> system and audio clocks are merely different points in time with no other
> distinguishing characteristics. Directing users to 2 different tables of
> clocks could be considered obtuse, if not Kafkaesque :P
> >
> > Ok, so maybe that's putting it a bit too strong :D Let see if I can see
> it your way: I can see two reasons for having 2 categories of clocks.
> >
> > (1) Because the underlying implementation of snd_pcm_start_at (or some
> other API) is different.
> > (2) Because you want to gather pairs of timestamps (a_system_timestamp,
> an_audio_timestamp) in order to estimate clock drift.
> >
> > I think we'd agree that (1) is not a strong justification: We shouldn't
> allow implementation details to propagate into the API without good cause.
> >
> > The second point is interesting, but doesn't seem to preclude having an
> dedicated clock type enum for use with snd_pcm_start_at.
> >
> > I guess what I'm arguing here is that the timestamping evolutions and
> start_at aren't /required/ to use the same clock type enums, and it seems
> more sensible to me that start_at has it's own, unified, clock type enum.
> >
> > I hope I haven't mischaracterised your view on split enums. Hit me back
> with some corrections.
> >
> > More importantly, I hope I haven't stepped on your toes too much - I
> really value your efforts and feedback on this stuff!
>
> I understand the logic of making things unified to specify the start, but
> the audio or link clocks are really different in nature from the system
> ones. I guess my reaction really comes from the number of times i've had to
> explain that a system timer can't control audio playback unless the same
> oscillator is used. Pretty basic but not everyone gets it. It'd also be
> weird to define a clock type to specify the start time and use a second one
> to know the time once the stream has started.
>
> >
> >>
> >>> + woul
> >>> +struct snd_start_at {
> >>> +    int op;                /* startat operation to be performed */
> >>> +    union {                /* fields for setting a startat timer */
> >>> +        struct {
> >>> +            int clock_type;            /* clock type e.g.
> SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY */
> >>> +            struct timespec start_time;    /* start time */
> >>> +        } set;
> >>> +        struct {
> >>> +            int clock_type;
> >>> +            struct timespec current_time;
> >>> +        } status;
> >>> +    } args;
> >>> +};
> >>> +
> >>>   /* channel positions */
> >>>   enum {
> >>>       SNDRV_CHMAP_UNKNOWN = 0,
> >>> @@ -551,6 +582,8 @@ enum {
> >>>   #define SNDRV_PCM_IOCTL_READN_FRAMES    _IOR('A', 0x53, struct
> snd_xfern)
> >>>   #define SNDRV_PCM_IOCTL_LINK        _IOW('A', 0x60, int)
> >>>   #define SNDRV_PCM_IOCTL_UNLINK        _IO('A', 0x61)
> >>> +#define SNDRV_PCM_IOCTL_START_AT        _IOW('A', 0x62, struct
> snd_start_at)
> >>> +
> >>>
> >>>
>  /*****************************************************************************
> >>>    *
>          *
> >>>
> >>
> >
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

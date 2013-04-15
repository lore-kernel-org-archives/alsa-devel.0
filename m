From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH v2] ALSA: hda - Apply codec delay to
	wallclock.
Date: Mon, 15 Apr 2013 01:02:29 -0700
Message-ID: <CAEUnVG50-UFVQ6gH7JRuB6F3zi64DsMtGnDz-Q_kMFPr4ehz4Q@mail.gmail.com>
References: <1365470430-22292-1-git-send-email-dgreid@chromium.org>
 <5164E2CF.2050207@linux.intel.com>
 <CAEUnVG4g--gJo5XjUub3do8acAjqDXeu_GSrDPY=tZ0QfwLPoA@mail.gmail.com>
 <5165774C.2000507@linux.intel.com> <s5hvc7uh0we.wl%tiwai@suse.de>
 <51676096.9000003@linux.intel.com> <s5hehegm8lc.wl%tiwai@suse.de>
 <s5h4nfarers.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f47.google.com (mail-ee0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 7506126509A
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 10:02:30 +0200 (CEST)
Received: by mail-ee0-f47.google.com with SMTP id t10so2043404eei.6
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 01:02:30 -0700 (PDT)
In-Reply-To: <s5h4nfarers.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Apr 13, 2013 1:55 AM, "Takashi Iwai" <tiwai@suse.de> wrote:
>
> At Fri, 12 Apr 2013 10:55:27 +0200,
> Takashi Iwai wrote:
> >
> > At Thu, 11 Apr 2013 19:17:10 -0600,
> > Pierre-Louis Bossart wrote:
> > >
> > >
> > > >> For playback audio_timestamp = wallclk - codec_delay_in_nsec
> > > >> for capture audio_timestamp = wallclk + codec_delay_in_nsec
> > > >
> > > > Hmm...  I'm confused, too.  From a pretty generic view,
> > > >
> > > > - hwptr = the samples (frames) transferred on the (memory) buffer
> > > > - hwptr + PCM delay = the point being currently captured
> > > >
> > > > Which position does the wall clock correspond?
> > >
> > > you now have 3 positions:
> > >
> > > For capture:
> > > hwptr = sample in memory
> > > hwptr+ delay = sample recorded on link (tracked by LPIB and wallclock)
> > > hwptr+ delay + codec_delay = sample recorded by A/D
> > >
> > > For playback
> > > hwptr = next sample in memory to be DMA'ed
> > > hwptr - delay = sample pushed on link (tracked by LPIB and wallclock)
> > > hwptr - delay - codec_delay = sample played in A/D
> > >
> > > the wallclock is only at the soc/chipset level, it doesn't know
anything
> > > about the peripheral.
> > > Makes sense?
> >
> > Thanks, now it's clearer.
>
> Dylan, could you care to submit the fix patch?
>

It will be the first thing I do when I get to the office tomorrow morning.

Thanks,

Dylan

>
> thanks,
>
> Takashi

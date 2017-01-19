From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH RFC] ASoC: rt5663: use msleep() for long delay loop
Date: Thu, 19 Jan 2017 12:20:26 +0000
Message-ID: <20170119122026.GA2693@osadl.at>
References: <1484146993-25429-1-git-send-email-hofrat@osadl.org>
 <20170117193434.ik624rx3ij6hukov@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117193434.ik624rx3ij6hukov@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2017 at 07:34:34PM +0000, Mark Brown wrote:
> On Wed, Jan 11, 2017 at 04:03:13PM +0100, Nicholas Mc Guire wrote:
> > As the overall delay is in range of seconds and the wait granularity
> > is 10ms msleep() seems more reasonable than to put load on the highres
> > timer subsystem.
> 
> Thia also contains a whole bunch of other refactoring that's not
> mentioned in the changelog...
>

true - initially it was the transition to msleep and then I 
switched from counter based to time-based loop. Im actually not sure
if switching to time-based loop vs counter based loop is desired. My
assumption is that if the system was under high load then this loop
could take very long to actually timeout - which is probably not
what is desired and in the good case the behavior should not
actually be significantly different.
 
> > This does throw a checkpatch warning with:
> > WARNING: msleep < 20ms can sleep for up to 20ms;"
> > but since this is in a loop and the intended granularity is
> > 10ms with up to 2 seconds total delay this seems ok.
> 
> That does depend on how quickly the operation is expected to complete,
> the total delay is likely to be a massive overestimate.

the initial granularity of checking is 10ms (usleep_range(10000,10005))
and the loop is probing in this 10ms interval. Now msleep can overrun
a call by 10ms (in case HZ=100) but not in a loop, in the loop case
consecutive msleep(10) would not each overrun as the condition is that
you start the sleep just after jiffies was updated and then have to wait
until it changes by 2 (msleep() internally adding 1) so the effective
delays are comparable but dont use highresolution timers here.
The behavior is thus basically unchanged independent of the expected 
time of operation as it imediately probes (regmap_read()) and then
will wait at least 10ms in any case - and that behavior does not change.

Will go fix up the commit log and resend.

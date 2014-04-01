From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] drm/i915: move power domain init earlier
 during system resume
Date: Tue, 1 Apr 2014 22:26:20 +0200
Message-ID: <CAKMK7uGVowGt--qRoEGh2jdBsc_Qk23vonsnqW9dA5ZxZzc4EA@mail.gmail.com>
References: <1395396631-12243-1-git-send-email-imre.deak@intel.com>
 <1396371322-13752-1-git-send-email-imre.deak@intel.com>
 <20140401174827.GO22327@phenom.ffwll.local>
 <1396378243.2488.10.camel@ideak-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1396378243.2488.10.camel@ideak-mobl>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Imre Deak <imre.deak@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 01, 2014 at 09:50:43PM +0300, Imre Deak wrote:
> On Tue, 2014-04-01 at 19:48 +0200, Daniel Vetter wrote:
> > On Tue, Apr 01, 2014 at 07:55:22PM +0300, Imre Deak wrote:
> > > During resume the intel hda audio driver depends on the i915 driver
> > > reinitializing the audio power domain. Since the order of calling the
> > > i915 resume handler wrt. that of the audio driver is not guaranteed,
> > > move the power domain reinitialization step to the resume_early
> > > handler. This is guaranteed to run before the resume handler of any
> > > other driver.
> > >
> > > The power domain initialization in turn requires us to enable the i915
> > > pci device first, so move that part earlier too.
> > >
> > > Accordingly disabling of the i915 pci device should happen after the
> > > audio suspend handler ran. So move the disabling later from the i915
> > > resume handler to the resume_late handler.
> > >
> > > v2:
> > > - move intel_uncore_sanitize/early_sanitize earlier too, so they don't
> > >   get reordered wrt. intel_power_domains_init_hw()
> > >
> > > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=76152
> > > Signed-off-by: Imre Deak <imre.deak@intel.com>
> >
> > So this is kinda why we should have gone with something proper, like a new
> > hdmi sink platform device created by i915 and registered as a driver by
> > snd-hda. Then the power domains stuff in the device core should take care
> > of these kinds of ordering issues. Or at least snd-hda can tell it that it
> > needs to wait for the hdmi-sink power domain to go on first before it can
> > resume, I'm not really fluent on the details here.
> >
> > And having a hdmi sink bus would allow us to throw all kinds of crap into
> > a clearly-defined interface, e.g. eld handling, hdcp synchronization, hpd
> > forwarding and all the other fun stuff.
> >
> > So not sure what I should do with this here now.
>
> Right, I'm not too happy about this solution either, so if anything it
> could be considered only a stop-gap fix. What you suggest seems to be a
> cleaner way but it'd require more time to investigate/implement at least
> on my part (but I'm ok to put it on my TODO list).

We'd definitely need to discuss this with Takashi Iwai, since it would
only really be useful if it's good enough to solve the general pile of
sound/gfx coordination issues we have with hdmi. Adding him and alsa-dev.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

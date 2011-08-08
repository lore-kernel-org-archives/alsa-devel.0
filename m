From: Baek Chang <baeksan@ccrma.stanford.edu>
Subject: Re: switching pcm devices dynamically when using dmix
Date: Mon, 8 Aug 2011 10:27:32 -0700
Message-ID: <CAG3SCMsNpuQMG8p+=-QtkA0JZ8RK5g2cVuBuO4rsQ+=_cRT-CA@mail.gmail.com>
References: <CAG3SCMspSq=aVbGLwKkcp+x7syNf4a9Too+SgmQ7jJSJBH26=Q@mail.gmail.com>
	<s5hoc00f55e.wl%tiwai@suse.de>
	<CAG3SCMup3ya8NftgoYhzQM5rrMbcfEqL3xByfSGZymTHrVttmg@mail.gmail.com>
	<s5hr54vev5l.wl%tiwai@suse.de> <1312821301.3314.7.camel@CNA0741383>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 96A6324598
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 19:27:34 +0200 (CEST)
Received: by ywb26 with SMTP id 26so2984327ywb.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2011 10:27:32 -0700 (PDT)
In-Reply-To: <1312821301.3314.7.camel@CNA0741383>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'll have a look at the dynamic PCM code.  That is a fairly new feature
correct?  Perhaps I can use that as an example.

> OTOH, if it handles only the switch for the next open, it'd be just to
> change the configuration, so it sounds feasible.
This is mainly my goal. User application would know when this is switching,
close the current device, reconfigure, open the new device and then continue
streaming.

On Mon, Aug 8, 2011 at 9:35 AM, Liam Girdwood <lrg@ti.com> wrote:

> On Mon, 2011-08-08 at 18:16 +0200, Takashi Iwai wrote:
> > At Mon, 8 Aug 2011 09:08:49 -0700,
> > Baek Chang wrote:
> > >
> > > Would it be possible to implement this feature in another plugin?  For
> > > example, some plugin called "switch", that would take a parameter for
> device
> > > or card name/number that would close the current device and open the
> new
> > > requested device?  Would this be worth investigating?
> >
> > The question is whether it allows the dynamic switch of the running
> > PCM stream.  If yes, it'd be tough to implement, I suppose.
> > OTOH, if it handles only the switch for the next open, it'd be just to
> > change the configuration, so it sounds feasible.
> >
>
> Fwiw, the ASoC dynamic PCM code does something a little similar and can
> dynamically remap the PCM stream to different backend DAIs (e.g. McBSP,
> McPDM, McASP etc) at runtime based on kcontrol mixer settings. This wont
> help for routing between cards but could be useful for routing between
> different physical DAIs on the same card.
>
> Liam
>
>


-- 
-baeksanchang

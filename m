From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Thu, 24 Jul 2008 23:41:14 +0200
Message-ID: <20080724234114.a8f6bcf3.krzysztof.h1@poczta.fm>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>
	<4883632A.8090106@keyaccess.nl> <4887A28F.90506@keyaccess.nl>
	<20080724072620.4197510c.krzysztof.h1@poczta.fm>
	<4888B993.2040101@keyaccess.nl>
	<20080724204734.0ae77007.krzysztof.h1@poczta.fm>
	<4888D854.40509@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 3B341249D6
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 23:36:18 +0200 (CEST)
In-Reply-To: <4888D854.40509@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 24 Jul 2008 21:30:28 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 24-07-08 20:47, Krzysztof Helt wrote:
> 
> >> *** 0005-wss_lib-use-wss-constants-instead-of-ad1848-ones.patch
> >>
> >>> --- a/sound/isa/ad1848/ad1848_lib.c
> >>> +++ b/sound/isa/ad1848/ad1848_lib.c
> >>> @@ -283,14 +283,12 @@ static int snd_ad1848_trigger(struct snd_wss *chip, unsigned char what,
> >>>                         return 0;
> >>>                 }
> >>>                 snd_ad1848_out(chip, AD1848_IFACE_CTRL, chip->image[AD1848_IFACE_CTRL] |= what);
> >>> -               chip->mode |= AD1848_MODE_RUNNING;
> >> Is this now done in generic code? Not necessary anymore? Was no comment 
> >> in the changelog.
> > 
> > The MODE_RUNNING is not used at all in the cs4231 code. I wonder what the purpose of it.
> 
> It was used by the AD1848 code though; snd_ad1848_trigger() set/reset it 
> on start/stop and it was then tested by snd_ad1848_interrupt() to decide 
> whether or not to call snd_pcm_period_elapsed().
> 

It is not used by the cs4231. The only difference is that ad1848 does not 
call the snd_pcm_period_elapsed() after calling the snd_ad1848_open()
but before calling the snd_ad1848_trigger() (and similar restriction
after the snd_ad1848_trigger() and snd_ad1848_close().

The cs4231 does not use such restriction. I decided it does not really matter.
The interrupts are not enabled before and after the snd_ad1848_trigger().
If the cs4231 driver needed this it would be already causing problems.

If you see any possible problem, the MODE_RUNNING can be added
to the wss_lib.

> >> It's probably all fine, but snd_ad1848 function changed 
> >> very significantly in the move and I'd rather it not do that. A patch
> >> 12 alone is much easier reviewable and any possible difficulty much 
> >> easier bisectable. Could you do that?
> > 
> > It can be done but the patch which merges the code will incorrectly
> > detect chips (tested that it does). So both must be applied together.
> 
> Okay, I see this was specifically tested and all. Try and see if you can 
> put something sensible in the changelog about it. It's _very_ hard to be 
> too verbose in changelogs...
> 

OK.

> 
> > If you have any of these please post results of your tests.
> 
> Will wait for V2 and will do; make take some time. I hope to not have 
> time over the coming weekend...
> 

Please test at least these older chips you have (cmi8330 and cs4248)
so we know that patches are working on them. They carry higher risk
for the patches then newer ones (from the cs4231 family).

> I'm not surprised. The CS4232 part of your chip will advertise itself 
> with ID CSC0000 or CSC0100 in /sys/devices/pnp0/<foo>/id and you 
> probably have a CSC0010 or CSC0110 as one of the other devices in there. 
> I noticed this before when debugging someone else's system on alsa-user 
> a while ago. That latter ID is the CS4236 control port. These things 
> should really just be driven as CS4236.
> 
> If you have this laptop for long enough, we'll get that going...
> 

I can keep it quite long (few weeks).

I am not planning merging the cs4236_lib at the moment. I will
start after the wss_lib is merged. I see few things to improve
in the wss_lib which I leave untouched (they do not belong to the
patch set I sent): drop mutex_open as it is done by higher layer, 
simplify mute function, fix recording settings after driver loading
- the detection leave it in stupid state.

I want to polish the wss_lib some more before doing something else.

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e91

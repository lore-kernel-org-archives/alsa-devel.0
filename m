From: Andreas Mohr <andi@lisas.de>
Subject: Re: pcsp weirdness/report (yes,
	even with libasound 1.0.16 revert)
Date: Sat, 17 May 2008 16:18:16 +0200
Message-ID: <20080517141816.GA15040@rhlx01.hs-esslingen.de>
References: <20080516210128.GA2210@rhlx01.hs-esslingen.de>
	<482E0235.5070609@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 96F841037E3
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 16:18:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <482E0235.5070609@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: alsa-devel@alsa-project.org, Theodore Tso <tytso@mit.edu>, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, May 17, 2008 at 01:52:53AM +0400, Stas Sergeev wrote:
> Hi.
> 
> Andreas Mohr wrote:
> > Immediately tried playback, and nothing worked properly.
> > Sound is __EXTREMELY__ silent, about 15 times more silent than the
> > normal terminal beep.
> Sorry for the silly question but...
> do you have the Master volume at
> maximum?

Uh, well... NO.

Hold on... well, of course I definitely had, but - I didn't have swvol
configured (as done by your sample asound.conf.gz / .asoundrc).

Now sound is a lot better, but it's still a wee bit too silent
(piezo...).

And of course I don't quite like the fact that I'm burning 50%
user-space on my Athlon!!!
(probably caused by tasklet, and probably by excessive ALSA handling
there as well).
Do we really have to do ALSA housekeeping during every timer cycle??
Not a single standard soundcard does this, it only triggers a sound
interrupt whenever a period elapsed and _then_ calls
snd_pcm_period_elapsed().
Thus I'm strongly suspecting that we're severely overhandling things
here, but I didn't really look into it.

Anyway, 50% user-space is really excessive, I'm quite sure that
configuring my azt3328 card to fire 20000 hardware sequencer timer interrupts
per second burned about 15% CPU (sys) only! (on this very same machine,
and on a drastically older/worse kernel version already, around 2.6.15ish!)
Thus it'd seem we have a lot of overhead in this handler which one
should try to reduce, by trying to find a solution for the locking issue
and by reducing ALSA handling.

> > insmod with nforce_wa=1, no success either.
> nforce_wa is only needed if your
> speaker is completely silent otherwise.
> So you don't need it.

Yup, and with it sound deteriorated, as mentioned in the driver.

> > And mixer controls in gamix are very confusing, too.
> > E.g. when clicking on the BaseFRQ enum box, I get _two_ 18643 entries listed.
> I've seen this too, but I think this is
> a bug in that mixer gui. It doesn't seem
> to handle the ENUMERATED values right,
> IIRC. alsamixer works right.

gamix doesn't seem to handle a whole lot of things right (that's not the
first time that I'm hitting a problem there).
But OTOH all those bazillions of stupid little mixer apps out there
really aren't any better... (rather worse).

> > And I'm still not sure (haven't investigated fully)
> > why that other setting is called "treble".
> Where? In the GUI or in the code?
> It shouldn't be called as such in
> the GUI, and for the code... well, I
> don't know, that was too long ago. :)

Code. It just seemed to me that treble is something entirely different
than the thing used by the driver.

> > Oh, and why does the code order I/O sequence as
> >                         outb_p(chip->val61, 0x61);
> >                         outb_p(timer_cnt, 0x42);
> >                         outb(chip->val61 ^ 1, 0x61);
> > instead of
> >                         outb_p(chip->val61, 0x61);
> >                         outb(chip->val61 ^ 1, 0x61);
> >                         outb_p(timer_cnt, 0x42);
> > as mentioned at some other sites? Is there any reason or maybe it just
> > doesn't matter?
> I think it doesn't matter, and I did
> it that way to increase the delays
> between the port 0x61 writes. I have
> no proof that it helps or hurts.

But that doesn't happen to be the reason for the nforce breakage, right?

For me it works fine either way.

> > Thanks a lot for providing a rather important puzzle piece for
> > Linux usability!
> :)
> Ok, the problems should be solved, the
> texts should be improved, the users should
> upgrade, etc. And in a mean time, the
> warning I put there, is hopefully strong
> enough. :)
> If not, we can always depend that driver
> on CONFIG_BROKEN... but I'd like to hear
> more opinions about that option.
> Hmm, actually, why not? We can always
> un-depend it later. Thoughts?

I'm tending against CONFIG_BROKEN. The driver isn't really broken,
and it doesn't obscure regular speaker use (right?), and fixing of the nagging
usability issues (weird .asoundrc additions required, gamix problems,
high CPU use...) will happen much faster by spitting into the face
of our users, not by going out of their way :)
(since CONFIG_BROKEN would cause the driver to be invisible on pretty much
every standard distro setup)

Thanks,

Andreas Mohr

-- 
GNU/Linux. It's not the software that's free, it's you.

From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Pulseaudio UCM integration - (Was:UCM list/set/get)
Date: Thu, 03 Feb 2011 16:08:37 +0000
Message-ID: <1296749317.3456.121.camel@odin>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
	<20110131112257.GC11937@sirena.org.uk> <1296482038.3316.160.camel@odin>
	<AANLkTinbtXS4G0uHYKiu9RRjP8hVEKY53xn6gzGYLZia@mail.gmail.com>
	<alpine.LNX.2.00.1102020909000.6272@eeebox2.perex-int.cz>
	<1296679324.3333.20.camel@odin>
	<AANLkTiknZgB4Y6+yao1t=dhAabi-mAsuD9DZ2s9umBPn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B128103A85
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 17:08:41 +0100 (CET)
Received: by wwi18 with SMTP id 18so7382046wwi.2
	for <alsa-devel@alsa-project.org>; Thu, 03 Feb 2011 08:08:41 -0800 (PST)
In-Reply-To: <AANLkTiknZgB4Y6+yao1t=dhAabi-mAsuD9DZ2s9umBPn@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Margarita Olaya <magi@slimlogic.co.uk>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-03 at 09:31 -0600, pl bossart wrote:
> >> Also, more work
> >> is required to separate ALSA card from UCM card (to support virtual or
> >> mixed "soundcards").
> >
> > Agreed, but Margarita will initially be targeting a simpler system with
> > one sound card and then move on to support a virtual sound card.
> 
> I quickly looked at the code. Interesting. I was thinking of a
> different approach where a separate pulseaudio module would open the
> use case manager, get the list of cards and verbs. this would be done
> on startup. Doing this inside module-alsa-card results in redundant
> activity, you're going to re-open and read the verbs for each card.
> 

I should say that the initial design and patch implementation was
carried out before Jaroslav added the virtual card support. The initial
plan was to compute UCM values per card at startup.

This code is also experimental, Margarita planned to see what worked
best with one card at first before moving to virtual card support.

> I am also concerned about the card_set_profile() code in module-alsa-card
>    if (nd->profile->is_ucm) {
>         pa_log_debug("set UCM %s", nd->profile->name + 4);
>         return snd_use_case_set(nd->profile->uc_mgr, verb,
> nd->profile->name + 4);
>     }
> There's an awful amount of code after the return to handle multiple
> sinks that may become active for a given profile. Even if you have a
> single card, it's not clear to me how multiple devices would be
> handled (eg. voice, music, tones in the 4430 case) if you bypass this
> code. Are they considered as different sinks from a PulseAudio
> perspective? The routing and how devices allowed in a specific use
> case are exposed in PulseAudio isn't clear to me at all.
> 

I don't think Margarita has got this far yet.

> Last, looking at the code, I saw this comment
> 	/* FIXME: UCM needs to provide API to acquire verb comments */
> A change is not needed, the list of verbs already comes as verb0,
> comment0, verb1, comment1, etc.

Again, this comment was from the ancient code.

> My $0.02
> -Pierre

I've CC'ed Colin for his $0.02 too. I do agree though, that with virtual
card support it does seem right to create a new Pulseaudio module to
manage UCM.

At a high level, the new module could :-

Compute use cases for each sound device at init {
	if (ucm config exists)
		use UCM config
	else
		use existing config method
}

Whilst Pulseaudio would use computed use case values for every new
client stream (using module-intended-roles ?).

Thoughts ?

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

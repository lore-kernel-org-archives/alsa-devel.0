From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: UCM list/set/get
Date: Thu, 3 Feb 2011 09:31:18 -0600
Message-ID: <AANLkTiknZgB4Y6+yao1t=dhAabi-mAsuD9DZ2s9umBPn@mail.gmail.com>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
	<20110131112257.GC11937@sirena.org.uk>
	<1296482038.3316.160.camel@odin>
	<AANLkTinbtXS4G0uHYKiu9RRjP8hVEKY53xn6gzGYLZia@mail.gmail.com>
	<alpine.LNX.2.00.1102020909000.6272@eeebox2.perex-int.cz>
	<1296679324.3333.20.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B1B2110386C
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 16:31:21 +0100 (CET)
Received: by iye19 with SMTP id 19so1238333iye.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Feb 2011 07:31:18 -0800 (PST)
In-Reply-To: <1296679324.3333.20.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Margarita Olaya <magi@slimlogic.co.uk>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

>> Also, more work
>> is required to separate ALSA card from UCM card (to support virtual or
>> mixed "soundcards").
>
> Agreed, but Margarita will initially be targeting a simpler system with
> one sound card and then move on to support a virtual sound card.

I quickly looked at the code. Interesting. I was thinking of a
different approach where a separate pulseaudio module would open the
use case manager, get the list of cards and verbs. this would be done
on startup. Doing this inside module-alsa-card results in redundant
activity, you're going to re-open and read the verbs for each card.

I am also concerned about the card_set_profile() code in module-alsa-card
   if (nd->profile->is_ucm) {
        pa_log_debug("set UCM %s", nd->profile->name + 4);
        return snd_use_case_set(nd->profile->uc_mgr, verb,
nd->profile->name + 4);
    }
There's an awful amount of code after the return to handle multiple
sinks that may become active for a given profile. Even if you have a
single card, it's not clear to me how multiple devices would be
handled (eg. voice, music, tones in the 4430 case) if you bypass this
code. Are they considered as different sinks from a PulseAudio
perspective? The routing and how devices allowed in a specific use
case are exposed in PulseAudio isn't clear to me at all.

Last, looking at the code, I saw this comment
	/* FIXME: UCM needs to provide API to acquire verb comments */
A change is not needed, the list of verbs already comes as verb0,
comment0, verb1, comment1, etc.
My $0.02
-Pierre

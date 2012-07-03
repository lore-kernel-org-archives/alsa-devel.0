From: Monty Montgomery <xiphmont@gmail.com>
Subject: Re: A problem with USB audio devices and the UHCI
	scheduler
Date: Tue, 3 Jul 2012 14:13:15 -0400
Message-ID: <CACrD=+-NB0Lyd=BAAC7D304fUA6xj-OZOao5_9B96C5ffi2osA@mail.gmail.com>
References: <CACrD=+8BOOb=17Qs5k_2jZeEf_+N3U1dq2sm0PtwrWxkrouRLw@mail.gmail.com>
	<4FF33018.2050701@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E153A245C6
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 20:13:15 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so5167668bkc.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2012 11:13:15 -0700 (PDT)
In-Reply-To: <4FF33018.2050701@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> You cannot fix it in the audio driver; bandwidth allocation is done in
> the controller driver,

Yes, I came to this practical conclusion too.

> and that one doesn't know that your device lies
> about its bandwidth requirements.

Oh, it's not lying.  The wmaxPacketsize is accurate.  It's just for a
range of sample rates, so it's overkill for the lower ones.

> The device is supposed to use alternate settings for this.

The device does use altsets for different sample formats and
input/output channels, just not altsets for each sample rate (as
supported/encouraged by the Audio Class... or has the Audio Class
since been amended to do away with sample rate ranges?)

In any case, it obeys the Audio Class spec and uses it appropriately
to my naive reading.

> Can't you change its firmware?

Oof, that's one hairy yak.  Is it really the case that other Audio
Class devices never make use of the "multiple sample rates in an
altset" feature?

Not answering the question, but related:

I couldn't even get linux-firmware to ship *working* firmware when I
last tried a few years ago.  We're still shipping the nonfunctional
firmware that got corrupted in the pre-2.6.21 cleanup.  I submitted
updated firmware and folks wouldn't take it because emagic/Apple
didn't license it clearly (the update CD had no license text in any
form whatsoever), and then people didn't want to restore Tapio's
original working firmware either because he couldn't be contacted to
confirm a license for it...  Granted, I gave up / got distracted
pretty quickly, so the blame is mostly mine.

But that's semi-irrelevant to the technical question at hand really.
OHCI has no problem managing this device's bandwidth appropriately,
and neither Win nor Mac OS seem to overprovision on UHCI.  If this
really is just another case of "I have to package and ship custom
drivers for devices like this", I suppose I'll have to live with that.

In any case, yes I see this is a conceptually weird problem.  I'm just
looking for a practical solution that avoids me maintaining a private
fork.  Here's hoping for one :-)

Cheers,

Monty

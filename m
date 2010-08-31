From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Re-2: [PATCH 2/6] ASoC: ad1980: fix names of a few
 kcontrols
Date: Tue, 31 Aug 2010 12:34:49 +0100
Message-ID: <20100831113448.GG20849@rakim.wolfsonmicro.main>
References: <0034DBC1.4C7BB7B3@mail.fwd-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E603210380E
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 13:34:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0034DBC1.4C7BB7B3@mail.fwd-online.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: marcus.weigelt@fwd-online.de
Cc: alsa-devel@alsa-project.org, sonic.zhang@analog.com, lrg@slimlogic.co.uk, u.kleine-koenig@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 30, 2010 at 11:52:52AM +0000, marcus.weigelt@fwd-online.de wrote:

[Please fix your MUA to word wrap within paragraphs, I've reflowed the
text.  Not doing this makes your message very hard to read and reply to.]

> > It's not massively obvious that microphone and phone aren't inputs and
> > therefore don't sensibly appear in the capture tab?

> The volume controls for mic and phone are actually hw mixing volumes
> that do not affect the recording path, therefore only the record
> selector belongs to capture tab, but not the volume control.

Then these aren't playback controls either - "Bypass" would be more
appropriate.

> > What is the actual problem that is is being fixed here?

> - microphone playback could not be unmuted before, that means that the
> hw mixing path from mic in to spk out/line out could never work - fixed
> by this

Could you please provide the output of 'alsactl store -f <filename>' for
the case before your changes?  Your problem description seems very
suprising, you're saying that the control just doesn't appear to
userspace at all.

> - microphone volume was shown twice in "All" tab of Alsamixer, but
> running synchroniously, if you change one, the other will follow with
> the same value - fixed by this

Again, what is actually going on here?  You've renamed controls rather
than removing any of them so this feels like randomly changing things to
work around some other problem elsewhere in the system.

> - if microphone voulme was changed in capture tab, the volume also
>   changed in playback tab - fixed by this

What is the actual problem?  Are these different controls that are being
updated in tandem or is the control being displayed multiple times?

> - microphone was never shown as active capture source, even if it was
>   selected correctly, neither in capture tab nor in all-tab - fixed by
>   this

With these you've again not provided any analysis of the actual failure
mechanism or how your change helps so it's a bit hard to follow what you
believe your patch fixes.

> - phone was shown as selected capture source in capture tab, but
>   actually it was not selected, instead it was muted/unmuted everytime one
>   tries to select it as capture source - fixed by this

I'm having a hard time parsing this but I think you're saying that the
phone input was shown as a capture source rather than a playback source?

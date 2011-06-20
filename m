From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Mon, 20 Jun 2011 18:07:40 +0100
Message-ID: <20110620170739.GD32056@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5A3F52454A
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 19:07:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DFF4D15.6050809@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:

> I'm still new in the community in that sense that I'm not sure how
> decisions are made. But I could use the outcome of such a decision.

So, I'm still not 100% sure what the actual technical issue is here?  

> As part of that I wrote a udev patch a few days ago, which nobody
> commented on in alsa-devel [1], but was somewhat disliked by at

Having dug out the mailing list archive I guess the fact that you just
posted it to the list and didn't CC anyone on the patch didn't help
here.  Looking at the patch the main thing that jumps out at me without
any knowledge of the udev code is that the patch will end up classifying
video output jacks as audio even if they've no audio capability which is
obviously not correct.

I still don't entirely understand the technical issue you're trying to
address here - this doesn't seem specific to audio.  As far as I can
tell the issue is that some of the input devices on the system aren't
being made available to the console user, presumably because there are
some that shouldn't be made available to them, so the issue is that the
heuristics that udev uses to decide if an input device should be root
only aren't working correctly in at least this case.  It feels like if
we understood why the heuristics are making a bad call here we might be
able to come up with a better solution.

> least Kay Sievers who maintains udev [2], who preferred we would
> rewrite our input layer to do something else within ALSA.

It seems like Kay's issues are based on a misunderstanding about what a
jack might be.

> For options 2a) and 2b) I guess the existing /dev/input thing should
> be deprecated and/or removed. So part of decision should maybe be
> based on information about how widespread the usage of these devices
> are currently...?

There's a reasonable amount of usage in the embedded space.

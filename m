From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Fri, 5 Aug 2011 07:27:02 +0100
Message-ID: <20110805062702.GA20809@opensource.wolfsonmicro.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
	<20110804103558.GA25976@opensource.wolfsonmicro.com>
	<CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
	<s5hbow4peuh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D66610398D
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 08:27:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbow4peuh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 05, 2011 at 08:11:34AM +0200, Takashi Iwai wrote:

> The problem is that the current cache code doesn't take care of
> special register-index values like 16_8 case.  In 16-8 case, usually
> only the lower 8 bit indicates the real register index while the upper
> 8 bit is some (usually constant) control bits.  Thus, it worked well
> in the former version by masking with 0xff.

Oh, gods.  If that's what the code is supposed to be doing then clearly
these aren't 16x8 registers at all and it's another case like the step
size stuff where someone's done something cute but fragile and in this
case they didn't even bother to put in a comment so it just looks like
an obvious bug.  We do actually have at least one device with genuine
16x8 registers but fortunately the driver for that never tried to cache
and it's I2C only anyway.

> A quick fix would to introduce again the 0xff masking.  Of course,

I'm more inclined to say that we just don't cache for devices trying to
do this until we've got a sensible model for them, there's probably some
other code that's going to be confused by this in there.

> this isn't a right thing, but would be enough for the current code,
> as regmap will replace in future anyway.

At the minute regmap has no concept of such devices, but at the minute
it's I/O only and so it's not such an issue.  My first instinct is just
to treat these devices as having a sparse register map so probably an
rbtree cache would do the right thing.

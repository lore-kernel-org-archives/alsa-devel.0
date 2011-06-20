From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Mon, 20 Jun 2011 18:31:01 +0100
Message-ID: <20110620173101.GF32056@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110620170739.GD32056@opensource.wolfsonmicro.com>
	<s5hei2ozatm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F06CE10380B
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 19:31:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hei2ozatm.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 07:12:21PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:

> > > I'm still new in the community in that sense that I'm not sure how
> > > decisions are made. But I could use the outcome of such a decision.

> > So, I'm still not 100% sure what the actual technical issue is here?  

> The device permissions.  They are set inaccessible from the normal
> desktop user as default.

Right, I got that much but what I was trying to say in the rest of the
paragraph was that it wasn't immediately obvious to me that this was due
to needing to do something special for audio jacks.  That's certainly a
symptom but what's not clear to me is why we think the current setup is
a good call for the generic input device that udev didn't have specific
magic for.  We seem to have jumped straight into some very non-generic
solutions, skipping quite a few steps in understanding what the current
situation is.

> > There's a reasonable amount of usage in the embedded space.

> Do they use udev?  And don't they need to tweak the device permissions
> of these input-jack devices on the fly per user?

No and no.  The physical user owns the whole device and typically there
aren't user accounts in that sense on the system.

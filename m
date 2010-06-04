From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Defining "signed integer" mixer controls?
Date: Fri, 4 Jun 2010 12:28:31 +0100
Message-ID: <D191C2D2-E7E8-4258-BEF3-6D8D9EEA752F@opensource.wolfsonmicro.com>
References: <hu6v9i$v43$1@dough.gmane.org>
	<20100603112022.GA24589@sirena.org.uk>
	<20100604092700.GD3662@www.longlandclan.yi.org>
	(sfid-20100604_102713_439084_FABBE4AD)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E597243EF
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jun 2010 13:28:35 +0200 (CEST)
In-Reply-To: <20100604092700.GD3662@www.longlandclan.yi.org>
	(sfid-20100604_102713_439084_FABBE4AD)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 4 Jun 2010, at 10:27, Stuart Longland wrote:

> On Thu, Jun 03, 2010 at 12:20:24PM +0100, Mark Brown wrote:
>> Please do remember to CC maintainers on posts to mailing lists.  I've
>> had to remind you previously about dropping CCs (and see that you were
>> doing that again this morning)...

> Well no, this was a separate query to the other thread, and one of a
> more general nature (not specific to the 'AIC3204... and not necessarily
> ASoC specific either).

You're replying in the middle of the existing thread (which tends to indicate a continuation of the same discussion) and hadn't CCed anyone at all - Takashi and Jaroslav are also much more likely to notice your post if you CC them.

>> Are you looking for SOC_DOUBLE_R_SX_TLV and variants thereof by any
>> chance?  If you need variants you'd need to add them but that's
>> straightforward.

> Is this something that has been added since kernel 2.6.34?  I'll have a
> hunt around for it, but I haven't spotted that in the kernel tree I'm
> using.

Yes.

> I'm running slightly-behind bleeding edge here, since I hit a few
> regressions[1] with the latest code (ARM-wise), and rather than battle
> those in this early phase of development, I decided to move back to
> something stable, get it working, then bring it forward.  It's for this
> reason that my driver currently uses the older driver registration
> model.

The device model registration has been supported in mainline for over a year now, it's certainly there in 2.6.34.

> Once I get it working; there will likely be two forks of it -- one
> brought up to mainline to go into the tree... and one to be backported
> to kernel 2.6.28 which is what we're using in our product (as everything
> else we have works with that kernel).

For 2.6.28 you'll be as well just backporting ASoC en masse.

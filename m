From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Reforming S3C I2S towards supporting I2Sv4
Date: Wed, 10 Mar 2010 10:18:17 +0000
Message-ID: <20100310101817.GC24422@rakim.wolfsonmicro.main>
References: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
	<1268209468.3760.8.camel@odin>
	<1b68c6791003100031m7be14ecr218e4f988bd30cab@mail.gmail.com>
	<1268211847.3760.23.camel@odin>
	<1b68c6791003100122u16294a69y541f28b6cabc69a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C43FC103858
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 11:18:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003100122u16294a69y541f28b6cabc69a2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 06:22:29PM +0900, jassi brar wrote:
> On Wed, Mar 10, 2010 at 6:04 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > I don't think your reason of "co-ordination between ASoC and S3C ARCH
> > trees" can justify breaking kernel policy.

> I believe the policy is not against moving definitions of bits that are
> tightly linked to the device controller esp when we seeing more and more
> SoCs coming with standard of-the-shelf third party controllers.

Plus controllers that may be used in multiple subsystems (like the
generic serial ports a lot of SoCs have).  Some architectures also like
to keep headers for the IPs with the arch either due to preference or
due to device differences which can be hidden from the driver with arch
level compile stuff.

I personally don't mind either way for things like the I2S controller
which don't have any obvious application outside ASoC so whatever you
guys and Ben want works for me.

> Then, I really want S3C ASoC modifications to not wait on S3C
> ARCH patches appearing upstream first.

If the headers stay in arch/arm we can still deal with that by either
agreeing to merge them via ASoC (as has been done in the past) or by
creating a branch which is merged into both ASoC and Samsung trees.  It
is obviously less effort to avoid this, but it's not insurmountable.

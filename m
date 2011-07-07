From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Thu, 7 Jul 2011 08:49:34 -0700
Message-ID: <20110707154933.GB16325@opensource.wolfsonmicro.com>
References: <1309437990.15931.67.camel@matrix>
	<20110630163706.GA18120@sirena.org.uk>
	<1309509205.15931.89.camel@matrix>
	<20110701161749.GD23784@opensource.wolfsonmicro.com>
	<1309762610.15931.119.camel@matrix>
	<20110704223419.GA1030@opensource.wolfsonmicro.com>
	<1309875922.15931.169.camel@matrix>
	<20110705193711.GB8642@opensource.wolfsonmicro.com>
	<1310039407.15931.195.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13636103861
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 12:11:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1310039407.15931.195.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 07, 2011 at 05:20:07PM +0530, Ashish Chavan wrote:
> On Wed, 2011-07-06 at 01:07 +0530, Mark Brown wrote:

> > No, that's not a user visible control that's part of the internal DAPM
> > power management stuff.  You're looking for struct snd_kcontrol_new
> > stuff.

> Oh, that's correct. You may be suggesting something similar to what is
> done in sound/soc/codecs/wm8985.c for "Equalizer Function", i.e. using
> SOC_xxx_EXT version for defining custom control and putting condition
> checks in respective "_put()" function.

Or just writing a control directly.

> > The state of another control is one example of a dynamic source of
> > information.

> Can you point me to any example that shows correct way to inquire
> state/value of a custom control? I guess snd_soc_get_xxx() functions
> need to be used here but I could find only handful of usages of these
> functions in entire sound/soc/codecs dir.

Those functions are used by the core for providing readback of the
controls to userspace.  You need to provide them but your driver can use
whatever it likes to read its own state (providing it's tasteful), it
doesn't need to go through external APIs.  Any driver with a custom
control will have an example of how it chooses to read its own state.

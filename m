From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Mon, 11 Jul 2011 19:46:43 +0530
Message-ID: <1310393803.26250.15.camel@matrix>
References: <1309437990.15931.67.camel@matrix>
	<20110630163706.GA18120@sirena.org.uk>
	<1309509205.15931.89.camel@matrix>
	<20110701161749.GD23784@opensource.wolfsonmicro.com>
	<1309762610.15931.119.camel@matrix>
	<20110704223419.GA1030@opensource.wolfsonmicro.com>
	<1309875922.15931.169.camel@matrix>
	<20110705193711.GB8642@opensource.wolfsonmicro.com>
	<1310039407.15931.195.camel@matrix>
	<20110707154933.GB16325@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 1BAE2244B7
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 16:08:36 +0200 (CEST)
In-Reply-To: <20110707154933.GB16325@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-07-07 at 21:19 +0530, Mark Brown wrote:
> On Thu, Jul 07, 2011 at 05:20:07PM +0530, Ashish Chavan wrote:

> > Oh, that's correct. You may be suggesting something similar to what is
> > done in sound/soc/codecs/wm8985.c for "Equalizer Function", i.e. using
> > SOC_xxx_EXT version for defining custom control and putting condition
> > checks in respective "_put()" function.
> 
> Or just writing a control directly.

I guess both of these methods are acceptable and there is no inherent
preference for one over another.
 
> Those functions are used by the core for providing readback of the
> controls to userspace.  You need to provide them but your driver can use
> whatever it likes to read its own state (providing it's tasteful), it
> doesn't need to go through external APIs.  Any driver with a custom
> control will have an example of how it chooses to read its own state.

I see. Thanks for the insight.

I am looking at SOC_DAPM_SINGLE_W in wm8903.c, SOC_WM8350_DOUBLE_R_TLV
in wm8350.c and SOC_TWL6040_DOUBLE_TLV in twl6040.c as reference
examples. Respective xxx_get_xxx() methods are what you are trying to
point me to, right?

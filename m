From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Mon, 11 Jul 2011 23:17:44 +0900
Message-ID: <20110711141505.GB31424@opensource.wolfsonmicro.com>
References: <20110630163706.GA18120@sirena.org.uk>
	<1309509205.15931.89.camel@matrix>
	<20110701161749.GD23784@opensource.wolfsonmicro.com>
	<1309762610.15931.119.camel@matrix>
	<20110704223419.GA1030@opensource.wolfsonmicro.com>
	<1309875922.15931.169.camel@matrix>
	<20110705193711.GB8642@opensource.wolfsonmicro.com>
	<1310039407.15931.195.camel@matrix>
	<20110707154933.GB16325@opensource.wolfsonmicro.com>
	<1310393803.26250.15.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10E2F244C6
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 16:17:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1310393803.26250.15.camel@matrix>
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

On Mon, Jul 11, 2011 at 07:46:43PM +0530, Ashish Chavan wrote:
> On Thu, 2011-07-07 at 21:19 +0530, Mark Brown wrote:

> > Those functions are used by the core for providing readback of the
> > controls to userspace.  You need to provide them but your driver can use
> > whatever it likes to read its own state (providing it's tasteful), it
> > doesn't need to go through external APIs.  Any driver with a custom
> > control will have an example of how it chooses to read its own state.

> I see. Thanks for the insight.

> I am looking at SOC_DAPM_SINGLE_W in wm8903.c, SOC_WM8350_DOUBLE_R_TLV
> in wm8350.c and SOC_TWL6040_DOUBLE_TLV in twl6040.c as reference
> examples. Respective xxx_get_xxx() methods are what you are trying to
> point me to, right?

No.  Like I say in the text you quote above these are functions used to
report the control state to userspace and there's no reason why you'd
need to use those interfaces from within the driver itself.

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/20] ASoC: S3C64XX: I2S: Move RATE and
 FMT defines to header
Date: Wed, 10 Mar 2010 12:59:41 +0000
Message-ID: <20100310125941.GT24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<20100310105109.GG24422@rakim.wolfsonmicro.main>
	<1b68c6791003100452j69b003fk42815adf06a85aa9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD213103927
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:59:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003100452j69b003fk42815adf06a85aa9@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 09:52:49PM +0900, jassi brar wrote:

> Btw, I was thinking of adding RATE_KNOT too, as it is usually possible
> to achieve
> 'not so standard' 12000 and 24000 rates, besides the flag doesn't
> 'promise' anything
> about availability of rates.

Yeah, _KNOT support needs more work in the core - at the minute it's
just doing a bitmask match on the standard rates and someone needs to
sit down and see how things will work when you've got two different
drivers providing the constraints.  There's not actually been much
demand for this since most people just use the standard audio rates (and
a lot of devices aren't properly rated/supported at non-standard ones)
but it'd definitely be good if you could implement it.

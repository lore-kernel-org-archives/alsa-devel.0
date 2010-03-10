From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/20] ASoC: S3C: I2Sv2: Remove
 S3C_IIS_V2_SUPPORTED define
Date: Wed, 10 Mar 2010 10:49:13 +0000
Message-ID: <20100310104913.GF24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F90E2438E
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 11:49:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 04:48:53PM +0900, Jassi Brar wrote:
> The code in s3c-i2s-v2.c is compiled via Makefile and not implicitly
> by include'ing. Also, the driver developer anyways has to refer to the
> manual to see if the code can be reused for the SoC under consideration.
> That makes the S3C_IIS_V2_SUPPORTED retrospective rather than a check.

> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

This code is in there for pure defensiveness - since at least the
S3C64xx and S3C24xx have slightly different register maps for the block
(the ones that are currently handled are the IISMOD master settings,
there may be more) the code needs to have explicit support for the
processors.  The goal of this block is to print a #error saying exactly
what's going on rather than just have the build fail with missing
defines in order to help make it more immediately clear to users what is
going on if they try to select a processor combination they don't know
how to handle.  

Users often have a strong expectation that the driver will just work
and so relying on them consulting the processor manual isn't always
realistic.

It may be that these differences are due to some being IISv2 and some
being IISv3 or something and could easily be handled via mandatory
platform data but since none of the documentation refers to any of this
stuff and it has to be reverse engineered we've got this system based on
build time processor selection.

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/20] ASoC: SAMSUNG: I2S: Add bit
	definitions
Date: Wed, 10 Mar 2010 11:00:21 +0000
Message-ID: <20100310110020.GH24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 35F81243A2
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 12:00:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
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

On Wed, Mar 10, 2010 at 04:49:00PM +0900, Jassi Brar wrote:
> Define more bit definitions in the order of mainline support for the
> SoC.

For changes like this it'd be better if the changelog said something
like "Add register bit definitions for S5PC1xx" - this is all mainline
code so it's much clearer to say that this is adding support for a new
SoC.

One other thing I'd suggest is that when constructing a patch series
it'd be better to put the more invasive or controversial changes (like
moving the headers) last.  This makes it easer to apply bits of the
series if there is any controversy.

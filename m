From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/20] ASoC: SAMSUNG: I2S: Add bit
 definitions
Date: Wed, 10 Mar 2010 12:56:22 +0000
Message-ID: <20100310125622.GS24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
	<20100310110020.GH24422@rakim.wolfsonmicro.main>
	<1b68c6791003100424l56812e3fy69890846736acb6d@mail.gmail.com>
	<20100310123811.GQ24422@rakim.wolfsonmicro.main>
	<1b68c6791003100449m13934b66hce1cd0e8a14c42f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E7531038FC
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:56:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003100449m13934b66hce1cd0e8a14c42f3@mail.gmail.com>
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

On Wed, Mar 10, 2010 at 09:49:03PM +0900, jassi brar wrote:
> On Wed, Mar 10, 2010 at 9:38 PM, Mark Brown

> > I agree that this is the only really controversial change, but it seemed
> > like pretty much all the changes that added stuff to the headers or used
> > them could've been done pre-move so that they didn't depend on it.

> Not sure which patch you point, but it was decision of logical
> build-up and successful
> compilation after each patch that made the patch series as it is now.

Pretty much all of them - for example, patch 11 adds a bunch of new
bitfield definitions to the header.  This change didn't really need the
header to have been moved before it was made, it could have been done
pre-move.  Keeping things building is important and some of the changes
that affected both S3C24xx and S3C64xx might've needed the move for that
but not all of them.

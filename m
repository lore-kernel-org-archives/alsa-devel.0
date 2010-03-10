From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/20] ASoC: SAMSUNG: I2S: Add bit
 definitions
Date: Wed, 10 Mar 2010 14:11:58 +0000
Message-ID: <20100310141158.GY24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
	<20100310110020.GH24422@rakim.wolfsonmicro.main>
	<1b68c6791003100424l56812e3fy69890846736acb6d@mail.gmail.com>
	<20100310123811.GQ24422@rakim.wolfsonmicro.main>
	<1b68c6791003100449m13934b66hce1cd0e8a14c42f3@mail.gmail.com>
	<20100310125622.GS24422@rakim.wolfsonmicro.main>
	<1b68c6791003100503r212cc88fq998140531a35d34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04354103904
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 15:12:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003100503r212cc88fq998140531a35d34@mail.gmail.com>
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

On Wed, Mar 10, 2010 at 10:03:28PM +0900, jassi brar wrote:
> On Wed, Mar 10, 2010 at 9:56 PM, Mark Brown

> > Pretty much all of them - for example, patch 11 adds a bunch of new
> > bitfield definitions to the header. =A0This change didn't really need t=
he
> > header to have been moved before it was made, it could have been done
> > pre-move.

> Dear that wud have defeated the very purpose of header moving -- don't wa=
nna
> depend on changes surfacing via ARCH tree after too long.

Right, but the header move is itself an arch change so you're blocked on
one anyway until it goes in :/

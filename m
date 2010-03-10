From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/20] ASoC: SAMSUNG: I2S: Add bit
 definitions
Date: Wed, 10 Mar 2010 12:38:11 +0000
Message-ID: <20100310123811.GQ24422@rakim.wolfsonmicro.main>
References: <1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
	<20100310110020.GH24422@rakim.wolfsonmicro.main>
	<1b68c6791003100424l56812e3fy69890846736acb6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4394510388E
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:38:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003100424l56812e3fy69890846736acb6d@mail.gmail.com>
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

On Wed, Mar 10, 2010 at 09:24:45PM +0900, jassi brar wrote:
> On Wed, Mar 10, 2010 at 8:00 PM, Mark Brown

> > One other thing I'd suggest is that when constructing a patch series
> > it'd be better to put the more invasive or controversial changes (like
> > moving the headers) last. =A0This makes it easer to apply bits of the
> > series if there is any controversy.

> I thought I already made that sure.
> In my opinion, the only controversial patch was 'header-copying' and I co=
uldn't
> move that any further down the series or other changes without that.

I agree that this is the only really controversial change, but it seemed
like pretty much all the changes that added stuff to the headers or used
them could've been done pre-move so that they didn't depend on it.

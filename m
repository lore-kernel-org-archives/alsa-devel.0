From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] ASoC: S3C24XX: Remove I2Sv3 specific
	check
Date: Wed, 9 Dec 2009 10:59:08 +0000
Message-ID: <20091209105908.GB19851@opensource.wolfsonmicro.com>
References: <1260333001-11565-1-git-send-email-jassisinghbrar@gmail.com>
	<20091209104125.GB17832@opensource.wolfsonmicro.com>
	<1b68c6790912090248k50ddd6e4w477299c1510e60de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC10510380B
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 11:59:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790912090248k50ddd6e4w477299c1510e60de@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 07:48:58PM +0900, jassi brar wrote:
> On Wed, Dec 9, 2009 at 7:41 PM, Mark Brown

> > This is used by the S3C24xx IIS as well so they need converting over
> > before this can be removed. =A0To be honest I hadn't realised that S3C6=
4xx
> > was using this at all.

> Well, only s3c64xx was using this piece of code. s3c2412-i2s.c always pas=
sed
> physical address of I2S base. And there is no other user of this function.
> So, i think we can safely remove it.

Yes, it's the other way round to that I remembered.

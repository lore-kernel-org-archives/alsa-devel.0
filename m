From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] s3c2412-i2s: Fix dai registration
Date: Tue, 1 May 2012 13:35:40 +0200
Message-ID: <201205011335.40534.heiko@sntech.de>
References: <201204301317.21519.heiko@sntech.de>
	<20120430224605.GA27450@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gloria.sntech.de (gloria.sntech.de [95.129.55.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 7351610423D
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 13:35:47 +0200 (CEST)
In-Reply-To: <20120430224605.GA27450@opensource.wolfsonmicro.com>
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
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Am Dienstag 01 Mai 2012, 00:46:11 schrieb Mark Brown:
> On Mon, Apr 30, 2012 at 01:17:21PM +0200, Heiko St=FCbner wrote:
> > As s3c2412-i2s is using the s3c_i2sv2 it should call the more specialis=
ed
> > s3c_i2sv2_register_dai instead of simply calling snd_soc_register_dai.
> =

> Applied, thanks.  Please always use subject lines appropraite for the
> subsystem.

which should've been "ASoC:" in this case, sorry for getting it wrong

Heiko

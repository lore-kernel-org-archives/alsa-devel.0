From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
	driver
Date: Fri, 26 Aug 2011 11:08:38 +0300
Message-ID: <2063673.sBsFcVrvkn@barack>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<12518591.ESZDKfh5zZ@barack> <4E537DA2.30607@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ED07246A4
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 10:08:39 +0200 (CEST)
In-Reply-To: <4E537DA2.30607@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tuesday 23 August 2011 12:14:58 Lars-Peter Clausen wrote:
> If that doesn't convince you, ask yourself what would happen if you had t=
wo
> instances of the mcpdm driver.

I see what you mean.
I guess I was blinded by the fact that we only have one instance of the McP=
DM =

driver.
Yeah, you are right this was really bad design.
I have reworked it for v3.

Thanks,
P=E9ter

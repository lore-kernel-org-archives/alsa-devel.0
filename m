From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: s3c-i2s-v2.c needs module.h
Date: Mon, 3 Oct 2011 08:17:21 +0800
Message-ID: <CAF+7xWkfTJXwt1uUtXgkh5Go9yxWasdM5a3DuLnii_5LqB00UQ@mail.gmail.com>
References: <1317562466.4996.2.camel@phoenix>
	<20111002182605.GC2857@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id EB8782439F
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 02:17:42 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so4604435bkb.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 17:17:41 -0700 (PDT)
In-Reply-To: <20111002182605.GC2857@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/10/3 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sun, Oct 02, 2011 at 09:34:26PM +0800, Axel Lin wrote:
>> Include <linux/module.h> to fix below build error:
>>
>> =A0 CC =A0 =A0 =A0sound/soc/samsung/s3c-i2s-v2.o
>> sound/soc/samsung/s3c-i2s-v2.c:573: warning: data definition has no type=
 or storage class
>
> What tree is this for? =A0My primary development platform is based on this
> driver, I'd expect to have noticed any build issues and I rather suspect
> this isn't what you're supposed to do after all the module.h stuff has
> settled down.
>
I got the build error on linux-next (20110930).

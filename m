From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH v5] ASoC/2.6.37: fix au1x platform
Date: Sat, 28 Aug 2010 00:43:27 +0200
Message-ID: <AANLkTimNHTDFp2g8c_s5hDc_3D9QPaeWDWcFr9UCPn9-@mail.gmail.com>
References: <1282827231-17323-1-git-send-email-manuel.lauss@googlemail.com>
	<1282913484.3025.25.camel@odin>
	<1365302F-4C5D-4075-8D38-94DEEEF2583E@opensource.wolfsonmicro.com>
	<AANLkTikr3rpij1FuKAQrwR0U8kpJUnKzfVJEzeYeGEsk@mail.gmail.com>
	<20100827191428.GB6666@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E5EE1038BE
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 00:43:27 +0200 (CEST)
Received: by iwn4 with SMTP id 4so2957223iwn.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 15:43:27 -0700 (PDT)
In-Reply-To: <20100827191428.GB6666@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ian Lartey <ian@opensource.wolfsonmicro.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 27, 2010 at 9:14 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 27, 2010 at 03:32:16PM +0200, Manuel Lauss wrote:
>
>> I've found another AC97-related issue on another board (DB1300):
>> With AC97 enabled, the device warning doesn't appear but my ethernet
>> is gone instead:
>
> This seems like some sort of pin mux issue or something driver specific?

No, no.  The drivers don't touch pin config.  It is related to the AC97 parts
of ASoC, however.  Somewhere memory gets overwritten which causes
the DB1300's ethernet and the DB1200's reset code to fail.  I'll see if I
can find out exactly what's going on.  There was something similar in
the ASoC AC97 code 1-2 years ago which caused linked list corruption,
but Liam fixed that pretty quickly.

Manuel

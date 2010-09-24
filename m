From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Clean up the CODEC device as
 well as the board for SMDK WM9713
Date: Fri, 24 Sep 2010 20:10:50 +0900
Message-ID: <AANLkTi=e0LK+1cD8x6iQv+GE3awrnO1yX585e6yxhrSF@mail.gmail.com>
References: <1285252845-24171-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1285252845-24171-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=8G9jt7KWafeUhinWCQMqRtxfXY1ZxwSNZBby1@mail.gmail.com>
	<20100923145614.GJ25663@rakim.wolfsonmicro.main>
	<AANLkTiksrurq_GQOp7gmZ=NeWX8NQFq2W2cA7hvwPveP@mail.gmail.com>
	<20100924092223.GH32112@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C9E31037F8
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 13:10:54 +0200 (CEST)
Received: by bwz13 with SMTP id 13so1378104bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2010 04:10:50 -0700 (PDT)
In-Reply-To: <20100924092223.GH32112@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 24, 2010 at 6:22 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Sep 24, 2010 at 09:27:02AM +0900, Jassi Brar wrote:
>
>> Even though more needs to be done to achieve purpose of this patch,
>> this change is harmless.
>> So as is or with more changes....
>
> Could you be more specific about what other changes you believe are
> needed?

IIUIC, the aim of this patch is to be able to reload the module, which isn't
going to work simply with this chage - we need to do as well something
about the 'soc-audio' platform device added the first time ?
So IMHO, this change is a right step but not enough.

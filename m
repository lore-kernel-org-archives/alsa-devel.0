From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] AsoC/s6000: use resource_size for
	{request/release}_mem_region and ioremap
Date: Wed, 2 Jun 2010 22:02:49 +0800
Message-ID: <AANLkTikxdjFFF1HWLx2fu9sdJ9vsAzGP-uZta6TExdZl@mail.gmail.com>
References: <4C063751.2060001@gmail.com>
	<20100602105123.GB3020@opensource.wolfsonmicro.com>
	<4C065006.7030305@emlix.com> <20100602124556.GD10031@sirena.org.uk>
	<AANLkTimZV7VyQq31taz2tJOsoBD8Upi3B0ROnZI5O5xn@mail.gmail.com>
	<20100602135608.GA18071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4640D243C0
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 16:02:51 +0200 (CEST)
Received: by vws8 with SMTP id 8so1383828vws.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 07:02:50 -0700 (PDT)
In-Reply-To: <20100602135608.GA18071@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Daniel Gl?ckner <dg@emlix.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

2010/6/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Jun 02, 2010 at 09:40:13PM +0800, Wan ZongShun wrote:
>
>> Oh, it just be my worry.
>> If some codes were no longer useful or valuable, what should we do for them?
>> delete them or keep them be there yet?
>
>> If I my patch to fix a worthless codes, everything I do will be nothing.
>
> The hardware is still very much live, it's just that Daniel isn't
> working on it.

Of course, the s6000 is live, but we cannot indentify whether other
hardwares still live or not in all Linux tree.:)

>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel@lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900@googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com@gmail.com

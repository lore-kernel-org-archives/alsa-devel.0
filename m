From: Luis de Bethencourt <luis@debethencourt.com>
Subject: Re: [PATCH 00/12] ASoC: Fix module autoload for OF
	platform drivers
Date: Thu, 3 Sep 2015 15:19:19 +0100
Message-ID: <CAPA4HGWSJ5sPi5yTN-siHtaUzkXQ7VYpZzUzrL+oEDvzAf02mw@mail.gmail.com>
References: <20150903105427.GA16658@goodgumbo.baconseed.org>
 <20150903125645.GB12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
 [209.85.213.173])
 by alsa0.perex.cz (Postfix) with ESMTP id EB32F26588E
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 16:19:21 +0200 (CEST)
Received: by igbni9 with SMTP id ni9so40845426igb.0
 for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2015 07:19:20 -0700 (PDT)
In-Reply-To: <20150903125645.GB12027@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 3 Sep 2015 13:57, "Mark Brown" <broonie@kernel.org> wrote:
>
> On Thu, Sep 03, 2015 at 12:54:27PM +0200, Luis de Bethencourt wrote:
>
> > This series adds the missing MODULE_DEVICE_TABLE() for OF to eport
> > that information so modules have the correct aliases built-in and
> > autoloading works correctly.
>
> Please thread patch serieses together when submitting them (git
> send-email can do this for you).  This makes things easier to follow.

Sorry. I am new to kernel development. Will learn how to thread patch
series with git send-email.

Thanks for the review and for letting me know for next time.
Luis

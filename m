From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/3] ALSA: pxa: slightly refactor reset
	handling
Date: Fri, 18 Oct 2013 03:53:31 +0400
Message-ID: <CALT56yPKG=DXCtPYtjXXavU2y1ev7JfPpmrpm=hig21B-_SvLg@mail.gmail.com>
References: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
 <20131017233607.GW2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 71765261622
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 01:53:32 +0200 (CEST)
Received: by mail-ie0-f171.google.com with SMTP id tp5so5339895ieb.30
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 16:53:31 -0700 (PDT)
In-Reply-To: <20131017233607.GW2443@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hello,

On Fri, Oct 18, 2013 at 3:36 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 17, 2013 at 02:01:35PM +0400, Dmitry Eremin-Solenikov wrote:
>> PXA25x also shows some problems when using interrupts during reset
>> handling. Thus do not use interrupts on all pxa kinds (to detect codec
>> ready state). Instead use a common mdelay-loop on all platforms to
>> detect codecs becoming ready.
>
> Applied all, thanks.  I'm somewhat surprised nobody noticed the reset
> issues on the pxa25x before - this stuff all got really heavily tested
> back in the day.

Maybe it was some coincidence/whatever. Maybe it is some hardware issue
of exact mask version. When I first started hacking around PXA, it was known
that tosa sometimes does not reset the AC97 codec for the first time.
However it looks like nobody bothered to debug that, because in most (~3/4)
cases reset went through. Now some kernel changes made kernel hang
looping in the interrupt, if the reset is not properly handled.

-- 
With best wishes
Dmitry

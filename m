From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] V2,
	Convert bitfields in ASOC into full int width
Date: Wed, 23 Jul 2008 15:06:10 -0400
Message-ID: <9e4733910807231206y541856d2n41f7841b27a63830@mail.gmail.com>
References: <20080723174302.14968.56684.stgit@terra>
	<20080723182937.GA25367@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C32B31037F2
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 21:06:11 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so446718yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 12:06:10 -0700 (PDT)
In-Reply-To: <20080723182937.GA25367@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jul 23, 2008 at 01:43:02PM -0400, Jon Smirl wrote:
>  > Convert bitfields in ASOC into full int width. This is a
>  > simple mechanical conversion. Two places in the DAPM code
>  > were fixed to properly use mask.
>
>
>   CHECK   sound/soc/soc-core.c
>  include/sound/soc.h:71:4: error: Expected ; end of type declaration
>  include/sound/soc.h:71:4: error: got .
>  sound/soc/soc-core.c:295:6: error: undefined identifier 'SND_SOC_BIAS_PREPARE'
>  sound/soc/soc-core.c:308:6: error: undefined identifier 'SND_SOC_BIAS_STANDBY'
>  sound/soc/soc-core.c:369:7: error: undefined identifier 'SND_SOC_BIAS_STANDBY'
>  sound/soc/soc-core.c:441:28: error: undefined identifier 'SND_SOC_BIAS_ON'
>  sound/soc/soc-core.c:444:11: error: undefined identifier 'SND_SOC_BIAS_PREPARE'
>  sound/soc/soc-core.c:455:40: error: undefined identifier 'SND_SOC_BIAS_ON'
>   CC      sound/soc/soc-core.o
>  In file included from sound/soc/soc-core.c:34:
>  include/sound/soc.h:71: error: expected identifier or '(' before '.' token
>  include/sound/soc.h:71: error: expected identifier or '(' before '}' token
>
>  The fix was trivial enough so I've made and applied it (and done some
>  brief testing of my own) - please be more careful in future.

I did that making checkpatch happy. I don't have easily buildable test
cases for powerpc so I'm doing this via inspection.  I'll see if I can
mess with Kconfig and force all of the codecs to build.

So this one is ok with the \ added? Next round I need to clean
everything up to make it 32 bit safe instead of only 16 bit. It will
probably touch some of the same code and needs to apply on top of this
patch.

-- 
Jon Smirl
jonsmirl@gmail.com

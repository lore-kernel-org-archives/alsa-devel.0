From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [PATCH,
 alsa-lib] ASoC: topology: Fix bclk and fsync inversion in
 set_link_hw_format()
Date: Wed, 28 Feb 2018 21:07:52 +0100
Message-ID: <321dc0b3-0a62-0aa1-ce60-a2ac8036ffcc@gmail.com>
References: <20180227203317.17274-2-k.marinushkin@gmail.com>
 <20180227203541.17343-1-k.marinushkin@gmail.com>
 <20180228152403.GB6722@sirena.org.uk> <s5h7eqxm8th.wl-tiwai@suse.de>
 <20180228155910.GC6722@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CF6922677C0
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 21:07:38 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id t3so7372455wmc.2
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 12:07:38 -0800 (PST)
In-Reply-To: <20180228155910.GC6722@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

@Pierre-Louis

> That looks acceptable to me, Xiuli can you test with with the matching change
> in the SOF topology macros (we can keep the 'slave' in M4 files but expand to
> 'codec_slave' in the .conf to avoid making this exception visible).

I don't see any comments from Pan Xiuli in the whole mailing thread.
Do we still wait for his feedback?


@Mark

>>> Should we warn on use of "master" since it's being deprecated here (and
>>> might be confusing for users)?

>> Maybe. OTOH, it looks fully backward-compatible, so far, so it's not that
>> confusing yet.

> Not a compatibility issue, yeah - more just that we've clearly already got people
> confused so pushing people to the more explicit name might avoid further
> issues down the line.

Agree with that. I will add a warning and send it as a patch v2.


@Takashi

> Yep, please at the next time. (And, don't stick with an old thread, but refresh a
> new thread.)

Yes, I will do so. I want to do this clean, so let me clarify before I start:

1. I will start a new thread, with linux [patch v2]
2. I will send the [patch, alsa-lib v2] in-reply to that linux [patch v2]
3. I will add all currently involved people as CC

Does it look correct?

Best Regards,
Kirill

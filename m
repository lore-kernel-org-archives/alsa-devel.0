From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/7] Fix Intel audio Kconfig issues
Date: Fri, 17 Nov 2017 16:09:12 -0800
Message-ID: <CA+55aFwagrmFp1CN7+zFgL1GEYa787Zy20AqLb-ARnKwMKVKHw@mail.gmail.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 58E46267256
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:09:14 +0100 (CET)
Received: by mail-it0-f48.google.com with SMTP id m191so6050328itg.2
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 16:09:14 -0800 (PST)
In-Reply-To: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 17, 2017 at 4:01 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> At the risk of being scolded for the third time in two days by
> Linux overlords (no hard feelings), here's an attempt to clean
> things up.

Without actually testing it (just scanning through the patches) it
looks sane. I noticed a couple of "default n" (just get rid of them -
that's already the default), but other than that nothing obviously
wrong.

But testing may show something else entirely.

               Linus

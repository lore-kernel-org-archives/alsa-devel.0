From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/7] Fix Intel audio Kconfig issues
Date: Mon, 20 Nov 2017 14:28:12 +0100
Message-ID: <CAK8P3a2Mno5nhPKFfCyNrLANs06NmEQaaCOymUOdDZN_fQD1SA@mail.gmail.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <s5ho9o07xbr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 16D47266FEC
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 14:28:13 +0100 (CET)
Received: by mail-ot0-f196.google.com with SMTP id g104so7623366otg.7
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 05:28:13 -0800 (PST)
In-Reply-To: <s5ho9o07xbr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, liam.r.girdwood@linux.intel.com, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 18, 2017 at 10:25 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 18 Nov 2017 01:01:55 +0100,
> Pierre-Louis Bossart wrote:
>>
>> At the risk of being scolded for the third time in two days by
>> Linux overlords (no hard feelings), here's an attempt to clean
>> things up.
>>
>> The first patch *should* implement what Linus, Takashi and Mark
>> tried to explain by email. There should be no functionality change
>> and could be merged if deemed ok.
>>
>> The rest of the patch series does a more in-depth cleanup and should not
>> be merged without more testing (hence the RFC).
>>
>> The 4th patch is really the most important one, there were nested
>> configs which made no sense to me. I don't know the history which led
>> to such complicated stuff but simpler is better.
>>
>> The last 3 patches are just clean-ups of the machine driver configs,
>> for some reason there is no consistency in the settings so I tried to
>> apply common sense. There might be additional cleanup needed since I
>> don't really get why we need references to LPSS or DESIGNWARE for things
>> which are not visible to a machine driver, we should only depend on IC2 or
>> SPI in my opinion - depending on what the control interface is.
>>
>> I tried to keep things to a minimum in each patch to make the reviews
>> easier, if people want them squashed that's fine by me.
>>
>> I'll do some more testing on my side but I could use feedback. Thanks!
>
> FYI, I've put these to a test branch, test/asoc-intel-kconfig, so that
> 0day bot can catch issues.  Let's see.

I've found several problems in this area in the past with the randconfig
builds, so I've now added that branch to my build setup as well, and
should be able to run a few hundred x86 randconfig builds today on it.
If you don't hear back from me later today, it's probably ok.

       Arnd

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ASoC: Intel: Add defaults for SND_SST_
 options and machine drivers
Date: Thu, 16 Nov 2017 14:24:30 -0800
Message-ID: <CA+55aFzxL6-Xp=-mnBwMisZsuKhRZ6zRDJoAmH8W5LDHU2oJuw@mail.gmail.com>
References: <20171116221643.30128-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A0CF266F1D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 23:24:31 +0100 (CET)
Received: by mail-io0-f194.google.com with SMTP id 189so6835414iow.10
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 14:24:31 -0800 (PST)
In-Reply-To: <20171116221643.30128-1-pierre-louis.bossart@linux.intel.com>
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 2:16 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> Add 'default m' when sensible

No.

This is not sensible, and is not at all what I suggested.

Actual new code should *never* be default 'm' or 'y'.

You may think it's supremely important because you maintain it, but so
does EVERY other developer for their code, and no, we don'[t want to
just default everything on.

So the only thing that should be on by default is stuff that either

 (a) is a new option for something that used to not have an option at
all and was always enabled

     IOW, this is a "it used to always be there, we default it on now
that we've made it optional".

 (b) stuff that doesn't actually generate any code, but is there as a choice.

     So this is stuff like "show me the config options for vendor XYZ".

 (c) stuff that really is so common that it is the majority of users.

     This is stuff like USB, or block devices, or "enable networking".

But some individual driver for some hardware that nobody has? No.

So things like this is pure garbage:

     config SND_SST_ATOM_HIFI2_PLATFORM
            tristate "Intel ASoC SST driver for HiFi2 platforms
(*field, *trail)"
            default m

because clearly "Intel ASoC SST driver for HiFi2 platforms" should not
at all default to being on for everybody.

So NAK NAK NAK on stuff like this.

                    Linus

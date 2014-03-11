From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] ALSA: cs553*: Fix dependencies
Date: Tue, 11 Mar 2014 10:32:01 +0100
Message-ID: <20140311103201.32b8d8da@endymion.delvare>
References: <20140310211226.17ad03c6@endymion.delvare>
 <s5hzjkxfcny.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 04A84261680
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 10:32:04 +0100 (CET)
In-Reply-To: <s5hzjkxfcny.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Jaya Kumar <jayakumar.alsa@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Tue, 11 Mar 2014 07:54:25 +0100, Takashi Iwai wrote:
> At Mon, 10 Mar 2014 21:12:26 +0100,
> Jean Delvare wrote:
> > 
> > The CS5530, CS5535 and CS5536 chipsets are companions of the Geode
> > series of processors, which are 32-bit x86 processors. So the
> > snd-cs5530 and snd-cs5535audio drivers are only needed on this
> > architecture, except for build testing purpose.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Jaya Kumar <jayakumar.alsa@gmail.com>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.de>
> 
> Thanks, applied.

Hmm, we might have been a bit too quick, sorry. Looking at the
defconfig files, it would seem that the CS5536 was also used on some
MIPS machines and the CS3350 was also used on some PowerPC machines:

arch/mips/configs/lemote2f_defconfig:CONFIG_SND_CS5535AUDIO=m
arch/powerpc/configs/ppc6xx_defconfig:CONFIG_SND_CS5530=m

So assuming these default configuration files are correct, the proper
dependencies would be somewhat different. I'll investigate and send an
updated or incremental patch, let me know what you prefer.

-- 
Jean Delvare
SUSE L3 Support

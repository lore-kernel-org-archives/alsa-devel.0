From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: SOF: Makefile - fix the top-level
 kernel module names (add snd- prefix)
Date: Thu, 25 Jul 2019 15:38:58 +0200
Message-ID: <29ebff2c-a47a-d0a9-acf5-ee637df26400@perex.cz>
References: <20190725110808.19938-1-perex@perex.cz>
 <20190725131908.GE4213@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 087D7F800F5
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 15:39:04 +0200 (CEST)
In-Reply-To: <20190725131908.GE4213@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA development <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Dne 25. 07. 19 v 15:19 Mark Brown napsal(a):
> On Thu, Jul 25, 2019 at 01:08:08PM +0200, Jaroslav Kysela wrote:
>> Use the proper module name. The objs assignments are already there.
> 
> This breaks the build for me:
> 
>   DESCEND  objtool
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
> make[3]: *** No rule to make target 'sound/soc/sof/snd-sof-acpi-dev.o', needed by 'sound/soc/sof/built-in.a'.  Stop.
> 

Oops. I sent the v2 of the patch.

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

From: "Zoltan Devai" <zdevai@gmail.com>
Subject: Re: [RFC] [PATCH 1/2] ASoC sound support for SMDK2440
	boards: UDA1341 driver
Date: Fri, 25 May 2007 00:19:38 +0200
Message-ID: <5b7270f40705241519u1a6cc145t2c76b2443fb621b0@mail.gmail.com>
References: <5b7270f40705240736h7f47e0a0p16ac2b36ae07a5d0@mail.gmail.com>
	<s5hhcq2p2le.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C0092439D
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 00:19:44 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so141848ana
	for <alsa-devel@alsa-project.org>; Thu, 24 May 2007 15:19:38 -0700 (PDT)
In-Reply-To: <s5hhcq2p2le.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2007/5/24, Takashi Iwai <tiwai@suse.de>:
> At Thu, 24 May 2007 16:36:53 +0200,
> Zoltan Devai wrote:
> >
> > ASoC Support for the UDA1341 codec.
> > Please note that until there is a final L3-bus driver, this patch won't work.
>
> So, how is the status of L3-bus driver?
> Is it supposed to be merged to the next (2.6.23) kernel (e.g. already
> in mm tree)?  Or, should we keep your driver code in alsa-driver tree
> for _not_ merging to 2.6.23?

Thanks for the feedback Takashi, Liam.

These patches weren't meant to be included immediately.
I want to clear two issues as mentioned in the first patch-mail:
- L3: The code originates from 2001, and AFAIK was in 2.5 kernels
but not in 2.6 anymore. I doubt that it's OK for mainline in its current state.
- Other SMDK boards: The patches are probably OK for other boards as well,
and could be more general but I lack the hardware info to be sure.

I'll bring up the topic on the arm-kernel list, as there are a lot of SMDK users
along with the original author of the L3 code :)

Anyway, if there's no solution in a week I'll just post the coding-style clean
patches which you can keep in the alsa-tree.

Zoltan

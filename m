From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Thu, 24 Oct 2013 21:26:38 +0300
Message-ID: <5269665E.9050102@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id B0384261599
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 20:26:45 +0200 (CEST)
In-Reply-To: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
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
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

24.10.2013 21:10, Anssi Hannula kirjoitti:
> Hi all!
> 
> Here's another revision of the ATI/AMD multichannel+HBR patchset.
> 
> Changes:
> - added customizable callbacks instead of polluting generic code
> - fixed wrong codec id in rev3+ check (as previously noted)
> - cosmetics
> 
> I've only tested this on NVIDIA/Intel, but I'd guess at least Peter
> should be able to test this on AMD in a few days or so. The earlier
> revisions were tested to fully work.
> 
> Combined patch can be found at: http://onse.fi/files/atihdmi5.patch
> However, this patchset is on top recent sound-next commits so it does not
> directly apply on older kernels.

Aand that would be http://onse.fi/files/atihdmi6.patch not 5.

> Olivier, I hope you will be able to test this at some point as well
> (same things as last time), even though it will be a bit more work :)

-- 
Anssi Hannula

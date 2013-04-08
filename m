From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: hda - Apply codec delay to wallclock.
Date: Mon, 08 Apr 2013 16:37:03 -0700
Message-ID: <5163549F.1050304@linux.intel.com>
References: <1365207724-6288-1-git-send-email-dgreid@chromium.org>
 <5162F0D0.7050402@linux.intel.com> <s5hy5ctx9po.wl%tiwai@suse.de>
 <CAEUnVG5Q05mtQSs=2=rMspUfMRYm8gS3G+FQRLZTWQq=Aap_rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 65F8E2615E1
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 01:37:26 +0200 (CEST)
In-Reply-To: <CAEUnVG5Q05mtQSs=2=rMspUfMRYm8gS3G+FQRLZTWQq=Aap_rQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Of course you're right.  That's annoying, it will have to convert from
> ms to frames (in get_delay) then to ns here.  Converting from frames
> to ns here is a better idea, but for this particular codec, all I have
> is ms resolution.

This is odd, looks completely arbitrary...

> Pierre,
> What should the capture timestamp represent?  When the sample hits the
> A-to-D or when it is read out of the buffer?

When the samples hit A-to-D, as close as possible to the input (or the 
serial link if the codec doesn't report delay)
-Pierre

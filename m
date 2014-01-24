From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Need your advice: Add a new communication inteface
 between HD-Audio and Gfx drivers for hotplug notification/ELD update
Date: Fri, 24 Jan 2014 16:23:47 +0800
Message-ID: <CAN8cciYYMY-ojH3quSSZw9hqPig01RT=HcvhqEheNt+fX4nPuA@mail.gmail.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
 <CAKMK7uFYNfVhXsEmikDZCaFGM8k7g7VMcGqGM4U+1bA_9MX1zQ@mail.gmail.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B23315E@SHSMSX101.ccr.corp.intel.com>
 <20140122141821.GI9772@phenom.ffwll.local>
 <s5hd2jkj5nt.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B2342D7@SHSMSX101.ccr.corp.intel.com>
 <s5h38kfuo4a.wl%tiwai@suse.de>
 <CAKMK7uGT1My5hrVCZgnO5UGP5QQkXw=UBxxnaAdqTFTOxptCyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B4492652FD
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 09:23:48 +0100 (CET)
Received: by mail-ig0-f177.google.com with SMTP id k19so1943926igc.4
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 00:23:47 -0800 (PST)
In-Reply-To: <CAKMK7uGT1My5hrVCZgnO5UGP5QQkXw=UBxxnaAdqTFTOxptCyw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
 Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Barnes,
 Jesse" <jesse.barnes@intel.com>
List-Id: alsa-devel@alsa-project.org

>
> >> And I have a question: how to assure the audio/gfx client find its
right peer?
> >> On a x86 platform, there can be an integrated GPU and an discrete GPU.
So there can be two audio controllers and two GPUs.
> >> We need to assure audio controller find the proper GPU, and vice
versa. Maybe we need the peer audio/gfx to register with a same identifier
(something like vendor ID) for peering.
> >
> > Yes, it's an open issue.  So far, the binding with vga_switcheroo is
> > done by a rough guess with PCI ID.
>
> Yeah, I guess we need platform/bus specific hints.

http://www.displayport.org/cables/driving-multiple-displays-from-a-single-displayport-output/

How do the audio driver know which displays when a single displayport
output can drive multiple displays ?

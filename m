From: "Richard Zhao" <linuxzsc@gmail.com>
Subject: Re: ASOC: For SND_SOC_DAIFMT_IB_IF what is invert
	baseed on?
Date: Mon, 27 Oct 2008 21:24:48 +0800
Message-ID: <4e090d470810270624l5587d382o78330f737d709b8a@mail.gmail.com>
References: <4e090d470810250931k5e44a4cck3ad0186a2c47ec03@mail.gmail.com>
	<1225037126.28382.85.camel@dell-desktop.example.com>
	<4e090d470810262000t3d93538i3a71f5e5d042dd2f@mail.gmail.com>
	<1225104379.28382.104.camel@dell-desktop.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 768512474D
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 14:24:50 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so2107683wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 06:24:49 -0700 (PDT)
In-Reply-To: <1225104379.28382.104.camel@dell-desktop.example.com>
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
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Not quite, the clock is simply inverted compared to it's normal level.
>

Well, what's the normal level? i2s LRCLK 's normal level is low for
frame start, but pcm's normal level is high for frame start.

Different chips may have different meaning of "invert", because
"normal level" is not well defined. SND_SOC_DAIFMT_NB_NF is a common
macro, so it cannot depend on any chip.  So, could you please explain
in details what normal level and invert level of LRCLK/BCLK are in
i2s, pcm, left/right justified?

Yes, wm8350 audio driver works. The problem is, when I write drivers
from some cpu/codec DAIs, I'm often confused about the normal/invert
levels.

Thanks
Richard

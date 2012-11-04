From: Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH 1/2] HDA: Fix digital microphone on CS420x
Date: Mon, 5 Nov 2012 07:22:24 +0800
Message-ID: <CAMVG2sv2dD=WXAiJnpEO7e-pnJ5gOnCn0JK5P+B_SWc4Wqg36w@mail.gmail.com>
References: <1352006344-3378-1-git-send-email-daniel@quora.org>
 <s5hd2ztsryr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ADDA260320
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2012 00:22:25 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id z49so2312954wey.38
 for <alsa-devel@alsa-project.org>; Sun, 04 Nov 2012 15:22:24 -0800 (PST)
In-Reply-To: <s5hd2ztsryr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

On 4 November 2012 16:16, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun,  4 Nov 2012 13:19:03 +0800,
> Daniel J Blueman wrote:
> >
> > Correctly enable the digital microphones with the right bits in the
> right coeffecient
> > registers on Cirrus CS4206/7 codecs. It also prevents misconfiguring
> ADC1/2.
> >
> > This fixes the digital mic on the Macbook Pro 10,1/Retina.
> >
> > Based-on-patch-by: Alexander Stein <
> alexander.stein@systec-electronic.com>
> > Signed-off-by: Daniel J Blueman <daniel@quora.org>
>
> Thanks, this looks more comprehensive.  DIG1 and DIG2 seem to have
> been set wrongly in the original code, based on the Cirrus's example
> code.  Is the right-only recording problem fixed by this patch?
>

It is fixed. In the mbp101 init verbs, setting the vendor widget ADC
configuration bit 12 to copy the ADC2 right channel to the left (0x1004 to
nid 0x11 coef 2) is superfluous here, so presumably for the analogue mic
in. I'll get time later to check all this.

The second coefficient index initialisation (0x000f to nid 0x11 coef 4) is
now redundant, as we enable the mic bits later correctly now. I'll send an
updated patch which drops this.

Alexander, could you check this doesn't break your machine?
>
[...]
-- 
Daniel J Blueman

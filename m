From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [RFC/RFT PATCH] ALSA: hda - hdmi: Add ATI/AMD
	multi-channel audio support
Date: Fri, 27 Sep 2013 11:27:53 +0200
Message-ID: <CACna6rx7x1TM3NuegCYQ+kG3qiCyHxtjLub4sW3CJa+3zK6R_g@mail.gmail.com>
References: <1379872233-32210-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 878D2265053
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 11:27:53 +0200 (CEST)
Received: by mail-we0-f170.google.com with SMTP id w62so2401146wes.15
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 02:27:53 -0700 (PDT)
In-Reply-To: <1379872233-32210-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?Q?Peter_Fr=C3=BChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

2013/9/22 Anssi Hannula <anssi.hannula@iki.fi>:
> AMD just released the documentation needed for multi-channel HDMI
> support, so here is the initial patch adding such support.
>
> This has been tested on codec 0x1002aa01, revision 0x100200 with the
> exception of custom channel maps, which I intend to test later.
>
> I'm especially interested in testers with:
> - Older codecs other than 0x1002aa01. My best guess is that the new code
>   should work on them as well, but I'm not really 100% sure.
> - Codec 0x1002aa01 revisions 0x100300 (Rev ID 3) or later (see
>   /proc/asound/cardX/codec#Y). These support individual channel
>   remapping and that code is entirely untested (even for regular
>   5.1/7.1).

Wow, that's a nice (and quick) work :) I was on vacations for the last
week, and only noticed the docs release. Planned to work on that, but
you were much faster :)

I'll test it with my cards, but it'll take me some time (env setup,
cards switching...).

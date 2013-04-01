From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH 06/10] ALSA: usb-audio: UAC2: do clock
 validity check earlier
Date: Tue, 2 Apr 2013 00:36:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304020024300.1220@xoschi>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-7-git-send-email-eldad@fogrefinery.com>
 <20130401081651.GH18838@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id B900B264FFF
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 00:36:37 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id ik5so1089528bkc.6
 for <alsa-devel@alsa-project.org>; Mon, 01 Apr 2013 15:36:37 -0700 (PDT)
In-Reply-To: <20130401081651.GH18838@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


Hi Torstein,

On Mon, 1 Apr 2013, Torstein Hegge wrote:

> On Sun, Mar 31, 2013 at 17:52:28 +0200, Eldad Zack wrote:
> > Move the check that parse_audio_format_rates_v2() do after
> > receiving the clock source entity ID directly into the find
> > function and add a validation flag to the function.
> > 
> > This patch does not introduce any logic flow change.
> 
> What would be lost by letting __uac_clock_find_source() always check
> that the clock source is valid? It would avoid having to pass the
> validate parameter, at the cost of having parse_audio_format_rates_v2()
> validate clock source.

I didn't want to change that logic since (1) I can't test it, my device
doesn't go through that code and (2) failing there on account of that
check would error out and not support the device (as far as I 
understand from the code). So if a (theoretical) device would only 
return valid one minute after it is connected, this will cause a
regression. I might be wrong, but I figured it's better to do one thing 
at a time.

Cheers,
Eldad

From: VDR User <user.vdr@gmail.com>
Subject: Re: Bug in setting channels,
	related to recent ELD/EDID changes?
Date: Tue, 11 Jan 2011 12:37:02 -0800
Message-ID: <AANLkTinPbj6K8Lw9PiCsHrqRBT=fwj6YvCrnOh7YK3YB@mail.gmail.com>
References: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>
	<4D12E292.9050204@iki.fi>
	<AANLkTimxHsUS_zVm0_m-vUcwt4vupUAf-vRhH5VWLwoy@mail.gmail.com>
	<4D20508C.7070609@iki.fi> <s5hoc7ok05l.wl%tiwai@suse.de>
	<3a46493bd2a1ec3b74c89cb6970c9ab0.squirrel@mail.onse.fi>
	<s5hk4icjy2t.wl%tiwai@suse.de> <s5hbp3nkj1z.wl%tiwai@suse.de>
	<4D2C8C4B.1030202@iki.fi> <s5hfwsz9wey.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B1A410380F
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 21:37:06 +0100 (CET)
Received: by iwb12 with SMTP id 12so4813301iwb.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:37:02 -0800 (PST)
In-Reply-To: <s5hfwsz9wey.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

First, THANK YOU for addressing this!  However, I have a couple
questions.  Which solution was implemented; a true/false switch
controlling the behavior between the old _working_ method, or the new
ELD restricted one?  Or, this module parameter thing that was
mentioned?

As a user having to deal with the frustration of this problem, I
absolutely think the true/false switch is the best solution as it's
set-and-forget.  Set it one time, get the behavior you _want_, and not
have to bother with it again.  With the module parameter thing, it
sounds like you have to change module parameters according to what you
want at the moment.  Or is it that the true/false switch is controlled
by a module param?  Maybe I've misinterpreted it but it's not very
clear.

So I grab alsa git, but how do I use the fix to restore the old behavior?

Thanks,
Derek

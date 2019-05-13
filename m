From: Kailang <kailang@realtek.com>
Subject: Re: Boot procudure on HDA driver
Date: Mon, 13 May 2019 09:30:56 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D766284@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1D766254@RTITMBSVM07.realtek.com.tw>
 <s5hlfzalnxl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 943BBF8072A
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 11:31:02 +0200 (CEST)
In-Reply-To: <s5hlfzalnxl.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Monday, May 13, 2019 5:11 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: Boot procudure on HDA driver
> 
> On Mon, 13 May 2019 11:00:18 +0200,
> Kailang wrote:
> >
> > Hi Takashi,
> >
> > When System Boot up.
> > The Hda Driver running step was as below.
> >
> > alc_init();
> > alc_shutup();
> > alc_init();
> >
> > The depop procedure was put in spec->init_hook and spec->shutup.
> >
> > But I find more codec which run spec->shutup at boot up. It will occur pop
> noise.
> > If it doesn't run spec->shutup, it will not occur pop noise or reduce pop noise.
> >
> > How could the spec->shutup not run at boot up?
> >
> > I ever test to put the check in spec->shutup() for PM_EVENT_SUSPEND and
> PM_EVENT_HIBERNATE and shutdown.
> > But if power_save=1, it was have issue for this.
> > Codec was idle already in power_save=1 state. If system go suspend, it will
> not run spec->shutup() again.
> 
> I guess it's a runtime PM, hence it's neither PM_EVENT_SUSPEND nor
> PM_EVENT_HIBERNATE.
> 
runtime PM and suspend and hibernate and shutdown need to run spec->shutup(). It's no problem.
But spec->shutup() doesn't need to run in boot up.
And it will set power_save=1 on all dell machine.

If (codec->auto_runtime_pm || codec->bus->shutdown ||
      codec->core.dev.power.power_state.event == PM_EVENT_SUSPEND ||
      codec->core.dev.power.power_state.event == PM_EVENT_HIBERNATE)

So, I need to put upper check code in spec->shutup(). Right?
Thanks.

> Actually, if the shutup procedure makes the problem on a certain platform, just
> skip it.  It's an optional behavior and would be fine without it (of course only if
> it's confirmed to work :)
> 
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.

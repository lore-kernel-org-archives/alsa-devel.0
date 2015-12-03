From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da7218: Enable mic level detection
 reporting to user-space
Date: Thu, 3 Dec 2015 14:45:11 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460FAE1@SW-EX-MBX01.diasemi.com>
References: <d6102f65136a8457d7ca19a51be4a938f3146613.1449059324.git.Adam.Thomson.Opensource@diasemi.com>
 <s5hk2ovn6ml.wl-tiwai@suse.de>
 <2E89032DDAA8B9408CB92943514A0337D460FA37@SW-EX-MBX01.diasemi.com>
 <s5h8u5bn4p6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 62049260418
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 15:45:14 +0100 (CET)
In-Reply-To: <s5h8u5bn4p6.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On December 03, 2015 11:37, Takashi Iwai wrote:

> > > > This patch adds support to the codec driver to handle mic level
> > > > detect related IRQs, and report these to user-space using a uevent
> > > > variable.
> > >
> > > Is the uevent the best way for this?
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> >
> > Well originally I was using an input device mechanism to report to user-space,
> > albeit using KEY_VOICECOMMAND, which Mark mentioned wasn't correct for this
> > scenario, which was fair enough. He also mentioned that there had been a general
> > push back on using input devices so that code was dropped. See thread below:
> >
> > https://lkml.org/lkml/2015/11/10/347
> >
> > uevent seemed like the simplest solution to report this event, and allow
> > user-space to act based on it. As mentioned before though, I am open to
> > suggestions if there's a better way.
> 
> I'm not strongly opposing to uevent as long as it's well considered.
> But then please describe how it's notified properly and why it was
> chosen.  The patch changelog has enough free room to write more
> details, fortunately.  Tell more your story for Christmas :)
> 
> In general, you can use an ALSA control notification for this kind of
> event.  But it also depends on the user-space side.  With alsa-lib,
> it's pretty easy to use, while with tinyalsa that lacks of the notifier
> handling, you'd need to implement more code there.
> 
> For a plug/unplug type event, we have a generic jack layer, but this
> doesn't seem fitting perfectly, either.

For ALSA control notification, this implies there's a control associated, but
for this scenario that's really not necessary. You just want to know when the
noise level captured at the mic has gone above a certain threshold and then act
accordingly (process audio capture stream). There's no real need I can see for
a control to read from. As for the jack layer, I agree that it doesn't really
fit.

Ok, will update the patch commit message to add more details on this, including
references to Santa Claus, reindeer with shining noses, and other festive
symbols. :)

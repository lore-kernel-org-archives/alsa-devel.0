From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Bug in setting channels,
 related to recent ELD/EDID changes?
Date: Tue, 11 Jan 2011 22:47:33 +0200
Message-ID: <4D2CC1E5.5020105@iki.fi>
References: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>	<4D12E292.9050204@iki.fi>	<AANLkTimxHsUS_zVm0_m-vUcwt4vupUAf-vRhH5VWLwoy@mail.gmail.com>	<4D20508C.7070609@iki.fi>	<s5hoc7ok05l.wl%tiwai@suse.de>	<3a46493bd2a1ec3b74c89cb6970c9ab0.squirrel@mail.onse.fi>	<s5hk4icjy2t.wl%tiwai@suse.de>	<s5hbp3nkj1z.wl%tiwai@suse.de>	<4D2C8C4B.1030202@iki.fi>	<s5hfwsz9wey.wl%tiwai@suse.de>
	<AANLkTinPbj6K8Lw9PiCsHrqRBT=fwj6YvCrnOh7YK3YB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FC2210380F
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 21:47:38 +0100 (CET)
In-Reply-To: <AANLkTinPbj6K8Lw9PiCsHrqRBT=fwj6YvCrnOh7YK3YB@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11.01.2011 22:37, VDR User wrote:
> First, THANK YOU for addressing this!  However, I have a couple
> questions.  Which solution was implemented; a true/false switch
> controlling the behavior between the old _working_ method, or the new
> ELD restricted one?  Or, this module parameter thing that was
> mentioned?
> 
> As a user having to deal with the frustration of this problem, I
> absolutely think the true/false switch is the best solution as it's
> set-and-forget.  Set it one time, get the behavior you _want_, and not
> have to bother with it again.  With the module parameter thing, it
> sounds like you have to change module parameters according to what you
> want at the moment.  Or is it that the true/false switch is controlled
> by a module param?  Maybe I've misinterpreted it but it's not very
> clear.

Yes, it is a true/false switch controlled by a module parameter.

> So I grab alsa git, but how do I use the fix to restore the old behavior?

Set the module parameter static_hdmi_pcm of snd-hda-codec-hdmi to 1.

For example, by adding this into /etc/modprobe.conf:
options snd-hda-codec-hdmi static_hdmi_pcm=1

For the record, this is the commit:
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commitdiff;h=5eedd1422c2fc79c2f9ed8b71056b97570f95572

-- 
Anssi Hannula

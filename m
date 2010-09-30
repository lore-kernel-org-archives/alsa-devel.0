From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Thu, 30 Sep 2010 13:03:52 +0200
Message-ID: <4CA46E98.10402@ladisch.de>
References: <4C77CE1D.2070501@canonical.com>	<4C77DD09.3060909@ladisch.de>	<4C78059B.50801@canonical.com>	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>	<s5h4oec8r6f.wl%tiwai@suse.de>	<4C7BABA9.1010100@canonical.com>	<s5hlj7ont8e.wl%tiwai@suse.de>	<4C7E549E.4080505@canonical.com>	<s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id CD07A2446E
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 13:03:03 +0200 (CEST)
In-Reply-To: <i7viav$kjb$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
>  1. *All* HDA devices have a PCM softvol control.

The HDA "default" and "front" devices include the softvol plugin.
However, when the control already exists as a hardware control, the
plugin removes itself and isn't actually used (same as if the
SND_PCM_NO_SOFTVOL flag is set).

So, all HDA devices have a "PCM Playback Volume" control, either in
hardware or created by the softvol plugin.  (This control is absent
only when the softvol plugin has not been used.)

> Some use this actively due to the fact they lack a real h/w volume
> control. Others do not technically "use" it.

The hardware control is always used.  The user control created by
softvol is used when some application is using the softvol plugin.
(For an application using device names like "hw" or "plughw", there will
be not softvol plugin.)

>  2. The PCM softvol has a 51dB range. When it's "active" this presumably
> works. When it's inactive (which appears to be the case on my primary
> machine), regardless of what the it's set to, there will be 0dB change.

Yes.  (When using ALSA's default "default" or "front" devices, it should
be active.)

>  3. There is a flag when opening PCM device (SND_PCM_NO_SOFTVOL) that
> will cause the PCM mixer to not have any impact in *all* cases

... except when that control is a hardware control.

>  4. When looking at only mixer elements (e.g. not opening any streams)
> there is no way to know whether a given mixer is active or not (with
> current APIs), i.e. From using only the mixer related API calls, the PCM
> volume range is always presented as being 0 -> -51dB for the PCM
> softvol, even when it actually has no effect (i.e. the information
> presented is highly misleading).  Is there a way to know which mixers
> are active when you open a pcm stream? (and this question applies to
> both with and without using the SND_PCM_NO_SOFTVOL flag).

There is snd_ctl_elem_info_is_inactive(), but the softvol plugin never
sets its control to inactive.

Since there is only one global control, any property of this control is
not useful for applications like PA to determine whether its own stream
is being affected.

> Potential solutions would include:
>  1. If the "correct" solution is to just use SND_PCM_NO_AUTO in PA, and
> then deliberately/actively ignore any softvol mixers, then nothing needs
> done at the alsa level I guess.

Yes.

Use snd_ctl_elem_info_is_user() to check for the softvol mixer element.

>  2. Simply fixing things to NOT add the inactive PCM mixer when it's not
> needed.

It was decided to store this control in the hardware device so that it
is saved/restored together with the 'real' controls.


Regards,
Clemens

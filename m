From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Thu, 30 Sep 2010 17:56:37 +0200
Message-ID: <4CA4B335.9010404@ladisch.de>
References: <4C77CE1D.2070501@canonical.com>	<4C77DD09.3060909@ladisch.de>	<4C78059B.50801@canonical.com>	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>	<s5h4oec8r6f.wl%tiwai@suse.de>	<4C7BABA9.1010100@canonical.com>	<s5hlj7ont8e.wl%tiwai@suse.de>	<4C7E549E.4080505@canonical.com>	<s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>
	<4CA4A844.7060403@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 18696103834
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 17:55:45 +0200 (CEST)
In-Reply-To: <4CA4A844.7060403@colin.guthr.ie>
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
> 'Twas brillig, and Clemens Ladisch at 30/09/10 12:03 did gyre and gimble:
>> Colin Guthrie wrote:

>> The hardware control is always used.  The user control created by
>> softvol is used when some application is using the softvol plugin.
>> (For an application using device names like "hw" or "plughw", there will
>> be not softvol plugin.)
> 
> OK. As pulse's mixer profiles *tries* to use "front" but will fall back
> to "hw", we can be pretty much certain that the softvol plugin will
> exist in all cases. The trick is knowing whether or not the control is
> active.

used by current stream

> (although the latency of updates is terrible for me when I adjust the
> alsamixer. I guess changing PCM directly in alsamixer it doesn't trigger
> an immediate rewind in PA so the buffer has to run out for the change to
> be heard.

Yes.  The softvol plugin could be changed to try to update the already-
written part of the buffer; so far, not many programs have used big
buffers.

>>> Potential solutions would include:
>>>  1. If the "correct" solution is to just use SND_PCM_NO_AUTO in PA, and
>>> then deliberately/actively ignore any softvol mixers, then nothing needs
>>> done at the alsa level I guess.
>> 
>> Yes.
>> 
>> Use snd_ctl_elem_info_is_user() to check for the softvol mixer element.
> 
> Hmm, judging by the previous response to this suggestion, I'm not sure
> this will work:
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-December/004622.html

It would have worked if PA used the snd_ctl_* instead of the snd_mixer_*
functions.

In this special case, we know that the snd_ctl control "Playback PCM
Volume" maps to the snd_mixer "PCM" playback volume, but this would
still be a hack.

>> It was decided to store this control in the hardware device so that it
>> is saved/restored together with the 'real' controls.
> 
> That as a principle makes sense but I still don't understand why it has
> to be there when it's not active.

So that it behaves like a 'real' control, i.e., you can set (and restore)
it even when nothing is currently playing.

> Also I said I'd refer back to [1] later, so here it is. I'm a little
> confused as to why it's stored in asound.state, if, as you say, the
> control is only created when something opens "front:" or similar. When
> the asound.state is read and restored during boot (this is the only time
> for 99% of users I believe - other than running it manually), would it
> not be the case that nothing has yet opened "front:" and thus it will
> not be restored?

When alsactl restores a user control, it will automatically create it.
Thus, using the softvol plugin creates this control practically
permamently.

> setting Master (not PCM) to 0% aka -46.5dB causes some kind of auto-
> mute that cuts off all sound. It shouldn't do that.

Wasn't this a hardware error?
The driver should report correct dB information for this chip.


Regards,
Clemens

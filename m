From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Thu, 30 Sep 2010 16:09:56 +0100
Message-ID: <4CA4A844.7060403@colin.guthr.ie>
References: <4C77CE1D.2070501@canonical.com>	<4C77DD09.3060909@ladisch.de>	<4C78059B.50801@canonical.com>	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>	<s5h4oec8r6f.wl%tiwai@suse.de>	<4C7BABA9.1010100@canonical.com>	<s5hlj7ont8e.wl%tiwai@suse.de>	<4C7E549E.4080505@canonical.com>	<s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>
	<4CA46E98.10402@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id F38CA10380E
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 17:10:07 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P1Klp-0002Os-Ko
	for alsa-devel@alsa-project.org; Thu, 30 Sep 2010 17:10:05 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 17:10:05 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 17:10:05 +0200
In-Reply-To: <4CA46E98.10402@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for your reply as always Clemens.

'Twas brillig, and Clemens Ladisch at 30/09/10 12:03 did gyre and gimble:
> Colin Guthrie wrote:
>>  1. *All* HDA devices have a PCM softvol control.
> 
> The HDA "default" and "front" devices include the softvol plugin.
> However, when the control already exists as a hardware control, the
> plugin removes itself and isn't actually used (same as if the
> SND_PCM_NO_SOFTVOL flag is set).

Ahh OK, I think the problem is that David's test tool uses plughw device
rather than front... thus it does NOT use softvol (confirmed here
testing plughw and front) and thus the PCM softvol does not come into
play during the test cycle for me and thus it reports that the PCM
slider is totally incorrect with regards to it's dB values reported and
actual.

> So, all HDA devices have a "PCM Playback Volume" control, either in
> hardware or created by the softvol plugin.  (This control is absent
> only when the softvol plugin has not been used.)

I'll refer back to the above statement below[1].

>> Some use this actively due to the fact they lack a real h/w volume
>> control. Others do not technically "use" it.
> 
> The hardware control is always used.  The user control created by
> softvol is used when some application is using the softvol plugin.
> (For an application using device names like "hw" or "plughw", there will
> be not softvol plugin.)

OK. As pulse's mixer profiles *tries* to use "front" but will fall back
to "hw", we can be pretty much certain that the softvol plugin will
exist in all cases. The trick is knowing whether or not the control is
active.

>>  2. The PCM softvol has a 51dB range. When it's "active" this presumably
>> works. When it's inactive (which appears to be the case on my primary
>> machine), regardless of what the it's set to, there will be 0dB change.
> 
> Yes.  (When using ALSA's default "default" or "front" devices, it should
> be active.)

I've now confirmed that that is indeed the case for me. As PA opens the
front device for me, I can confirm that it does actually make an impact
(although the latency of updates is terrible for me when I adjust the
alsamixer. I guess changing PCM directly in alsamixer it doesn't trigger
an immediate rewind in PA so the buffer has to run out for the change to
be heard.

So currently, PCM does have impact in PA for me. Good. I confirmed that
making PA open the devices with the NO_SOFTVOL flag does indeed make it
non-functional. So far so good.

>>  3. There is a flag when opening PCM device (SND_PCM_NO_SOFTVOL) that
>> will cause the PCM mixer to not have any impact in *all* cases
> 
> ... except when that control is a hardware control.

Yes, of course. Sorry I should have included that :)

>>  4. When looking at only mixer elements (e.g. not opening any streams)
>> there is no way to know whether a given mixer is active or not (with
>> current APIs), i.e. From using only the mixer related API calls, the PCM
>> volume range is always presented as being 0 -> -51dB for the PCM
>> softvol, even when it actually has no effect (i.e. the information
>> presented is highly misleading).  Is there a way to know which mixers
>> are active when you open a pcm stream? (and this question applies to
>> both with and without using the SND_PCM_NO_SOFTVOL flag).
> 
> There is snd_ctl_elem_info_is_inactive(), but the softvol plugin never
> sets its control to inactive.
> 
> Since there is only one global control, any property of this control is
> not useful for applications like PA to determine whether its own stream
> is being affected.
> 
>> Potential solutions would include:
>>  1. If the "correct" solution is to just use SND_PCM_NO_AUTO in PA, and
>> then deliberately/actively ignore any softvol mixers, then nothing needs
>> done at the alsa level I guess.
> 
> Yes.
> 
> Use snd_ctl_elem_info_is_user() to check for the softvol mixer element.

Hmm, judging by the previous response to this suggestion, I'm not sure
this will work:

http://mailman.alsa-project.org/pipermail/alsa-devel/2007-December/004622.html

>>  2. Simply fixing things to NOT add the inactive PCM mixer when it's not
>> needed.
> 
> It was decided to store this control in the hardware device so that it
> is saved/restored together with the 'real' controls.

That as a principle makes sense but I still don't understand why it has
to be there when it's not active. I guess it's an implementation detail,
but from the outside, this doesn't look like a reason.

Also I said I'd refer back to [1] later, so here it is. I'm a little
confused as to why it's stored in asound.state, if, as you say, the
control is only created when something opens "front:" or similar. When
the asound.state is read and restored during boot (this is the only time
for 99% of users I believe - other than running it manually), would it
not be the case that nothing has yet opened "front:" and thus it will
not be restored? If that is the case then there is no reason to store it
in the asound.state. Of course if it is in asound.state then maybe that
is enough to create it for you at boot without opening "front:"?




Anyway, with all this in mind, the main problem I have now is not that
PA uses the softvols (I'm tending to side with the argument that it
*shouldn't* use them, but at present it does and they *are* active and
used, so it's not an issue for me), the problem is rather one of setting
Master (not PCM) to 0% aka -46.5dB causes some kind of auto-mute that
cuts off all sound. It shouldn't do that. I've not muted it. I've set it
to -46.5dB but it's decided to make it -infdB instead. That IMO is the
primary bug I'm seeing (and it's one I brought up on this list several
months ago, but managed to get sidetracked by Raymond talking about a
-48dB == -inf debate with no real action on the problem :()

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]

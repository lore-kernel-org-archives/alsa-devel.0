From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsactl adds volume controls?
Date: Thu, 2 Sep 2010 17:24:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de> <4C7BABA9.1010100@canonical.com>
	<s5hlj7ont8e.wl%tiwai@suse.de>
	<4C7E549E.4080505@canonical.com> <s5hr5hczi06.wl%tiwai@suse.de>
	<4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C28A24381
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 17:24:31 +0200 (CEST)
In-Reply-To: <4C7FB2CF.5060505@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Sep 2010, Clemens Ladisch wrote:

> Jaroslav Kysela wrote:
>> On Thu, 2 Sep 2010, David Henningsson wrote:
>>> Interesting. I went looking into the snd_mixer_selem_* documentation (PA
>>> uses the simple mixer interface), but I couldn't find a function for
>>> determining whether a control is user-defined or not, would you mind
>>> pointing me to it? Thanks!
>>
>> This logic is bad. We can have user-defined controls for the user space
>> drivers or daemons.
>>
>> The additional flag to mixer open functions - as proposed by Takashi - is
>> more appropriate in this case when there is a system handling the software
>> volume itself. But the question is quite same: How we can distinguish the
>> software volume control? I think that some TLV information might do this
>> job well.
>
> I think applications should not be required to distinguish software
> controls.
>
> The problem is that PA tries to use this control although it is inactive.
> The obvious solution is that this control should be marked as inactive,
> and that the softvol plugin marks it active only while actually running.

It's nice idea.

> What is the reason for alsactl not trying to restore inactive controls?

Most (maybe all - need to check drivers) of inactive control values are 
reset to the original value when they're going to the active state. Maybe 
we need to add another flag - inactive but persistent.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

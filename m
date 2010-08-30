From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: alsactl adds volume controls?
Date: Mon, 30 Aug 2010 15:01:29 +0200
Message-ID: <4C7BABA9.1010100@canonical.com>
References: <4C77CE1D.2070501@canonical.com>
	<4C77DD09.3060909@ladisch.de>	<4C78059B.50801@canonical.com>	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id D99BD103807
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 15:01:35 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Oq3zR-0006B4-OZ
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 14:01:34 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.103]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1Oq3zR-0000Dg-Ky
	for alsa-devel@alsa-project.org; Mon, 30 Aug 2010 14:01:33 +0100
In-Reply-To: <s5h4oec8r6f.wl%tiwai@suse.de>
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

2010-08-30 10:01, Takashi Iwai skrev:
> At Sat, 28 Aug 2010 06:58:20 +0800,
> Raymond Yau wrote:
>>
>> 2010/8/28 David Henningsson <david.henningsson@canonical.com>
>>
>>> 2010-08-27 17:43, Clemens Ladisch skrev:
>>>> David Henningsson wrote:
>>>>> So I've discovered that my sound card has a "PCM Playback Volume"
>>>>> control, but changing that control does not alter the volume.
>>>>>
>>>>> Interestingly enough, this control does not come from the HDA parser, it
>>>>> is added by alsactl at boot time...!
>>>>
>>>> This control was created by the software volume plugin.  When not using
>>>> this plugin, the control does not have any effect.
>>>>
>>>> To get rid of it, delete its entry from /etc/asound.state.
>>>
>>> Hmm, I wonder if this is an Ubuntu-specific bug then? Because when I run
>>> Maverick (the upcoming Ubuntu release) from a Live-CD, the "PCM Playback
>>> Volume" control is still there (and there is no asound.state, neither in
>>> /etc or in /var/lib/alsa).
>>> When I use the plughw interface, the "PCM Playback Volume" does not
>>> affect volume output. Should I use another device string to test the
>>> softvol plugin, to see if it's there or not?
>>>
>>
>> The softvol plugin it is defined in "front" device in
>> /usr/share/alsa/cards/HDA-Intel.conf
>>
>> reason is some HDA codec does not has any hardware volume control (analog)
>>
>> this user-defined control only effective when the application use "front"
>> device
> 
> Hm, but if PA opens the device with SND_PCM_NO_SOFTVOL flag, the
> softvol should be skipped.

But that does not apply to the mixer controls as well, does it? I think
we still have a problem with PA assuming that it can change the PCM
volume control to change the output volume.


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

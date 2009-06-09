From: Daniel Bankmann <daniel_bankmann@arcor.de>
Subject: Re: Problems with X-Fi driver
Date: Tue, 09 Jun 2009 19:01:24 +0200
Message-ID: <4A2E9564.3010700@arcor.de>
References: <mailman.1.1243850401.8236.alsa-devel@alsa-project.org>	<4A23C53D.8070201@arcor.de>	<s5htz2q7c4t.wl%tiwai@suse.de>	<4A2D7907.2070404@arcor.de>
	<s5h8wk2fa8u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A77CC103801
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 19:01:06 +0200 (CEST)
In-Reply-To: <s5h8wk2fa8u.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
> At Mon, 08 Jun 2009 22:48:07 +0200,
> Daniel Bankmann wrote:
>> Takashi Iwai schrieb:
>>> At Mon, 01 Jun 2009 14:10:37 +0200,
>>> Daniel Bankmann wrote:
>>>> Takashi Iwai schrieb:
>>>>> At Fri, 22 May 2009 11:54:47 +0200,
>>>>> Daniel Bankmann wrote:
>>>>>> Takashi Iwai schrieb:
>>>>>>> At Thu, 21 May 2009 09:53:23 +0200,
>>>>>>> Daniel Bankmann wrote:
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>> I just tested the newest driver version with Open Suse 11.1 and
>>>>>>>> pae-kernel. I seems not to work probably, although the latest
>>>> "official"
>>>>>>>> driver by Creative worked more or less good.
>>>>>>>>
>>>>>>>> The problem is, that always, when hearing some music or any other
>>>> sound,
>>>>>>>> the signal gets interrupted every few seconds. At the other side, the
>>>>>>>> startup jingle for example is accompanied by a knock every few seconds.
>>>>>>>>
>>>>>>>> Any idea, or what information do you need to fix this?
>>>>>>> If you are using pulseaudio, try to upgrade to the one in Factory.
>>>>>>> PA on 11.1 is really a crappy version, unfortunately.
>>>>>>>
>>>>>>>
>>>>>>> Takashi
>>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> are you sure, that this is a problem with PA?
>>>>> Depends on your system setup.  As default, PA is used on KDE and GNOME,
>>>>> regardless of h/w multi-stream functions.
>>>>>
>>>>>> Upgrading to the newest
>>>>>> version or the one in Factory seems to be a bit tricky (because auf
>>>>>> missing dependencies).
>>>>> You can upgrade the packages on OBS multimedia:libs repo.
>>>>>
>>>>>> Shouldn't the driver just work without PA and ESD installed? I tried
>>>>>> that out, but the problem still resists.
>>>>> It's not the driver to decide whether to use PA or not.  It's the
>>>>> upper part.
>>>>>
>>>>> If the problem still occurs without PA (and you make sure that you
>>>>> don't use it), the issue is likely the hwptr update timing of the
>>>>> ctxfi driver.   The recent PCM core has a more strict check, and
>>>>> possibly ctxfi might not provide the correct DMA position.
>>>>>
>>>>> Anyway, please check the problem occurs with which apps more exactly.
>>>>> At best, try to reproduce with aplay and speaker-test programs, i.e.
>>>>> with less complexity.  And, please report back to alsa-devel ML.
>>>>> (Note that your post may appear later after manual approvals if you
>>>>>  aren't subscribed yet).
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>> Hi,
>>>>
>>>> so I tried reproducing this problem. Here's a link to a wav-file which
>>>> includes tests with aplay and the starting/shutdown -jingle.
>>>>
>>>> I hope this can give you a better idea of my problem;)
>>> Try the latest alsa-driver-snapshot.tar.gz.  It should be improved now
>>> unless you are using emu20k2, not emu20k1.
>>>
>>>
>>> Takashi
>>>
>> I'm sorry, it didn't change anything ( Although I'm using a "Extreme
>> Music" card with the emu20k1 chip)
> 
> Hm, weird.  Are you sure that you installed properly?
> It works fine at least on my machine with openSUSE 11.1.
> 
> 
> Takashi
> 
Sorry, I didn't know, that I was supposed to use the source tarball and
not the rpm package. Now, after the first attempt messed up my whole
kernel, it seems to work quite fine. Thanks so far.
When will it be possible to use this version via rpm-packages?

Daniel

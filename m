From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH 2/2] add API to allow disabling period
	interrupt
Date: Tue, 2 Nov 2010 08:12:26 -0500
Message-ID: <AANLkTi=31_11GndkDYdGXiuM-LJ4cTbMNRMa0FaCZfCa@mail.gmail.com>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
	<4CCFCA6A.8010803@ladisch.de>
	<alpine.LNX.2.00.1011020935550.29422@eeebox2.perex-int.cz>
	<4CCFD40F.1010407@ladisch.de>
	<alpine.LNX.2.00.1011021018591.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D222A24503
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 14:12:27 +0100 (CET)
Received: by iwn2 with SMTP id 2so7796680iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Nov 2010 06:12:27 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1011021018591.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

>>>>> +int snd_pcm_hw_params_can_disable_period_irq(const snd_pcm_hw_params=
_t
>>>>> *params)
>>>>
>>>> This function is useless because it cannot be called before
>>>> snd_pcm_hw_params_set_period_irq().
>>>
>>> I don't think so. The info bits from the driver are used in this check
>>> which are read-only.
>>
>> All the snd_pcm_hw_params_can_* functions that read the info bits
>> are documented to require a completed configuration. =A0So they actually
>> don't, and there will never be a flag that depends on the configuration?
>
> You're right. The *_can_* check should be removed.

If I remove the *_can_* check and add a flag for snd_pcm_open,
actually the other set/get routines need to go as well. Everything
would happen at the opening stages instead of when the hardware params
are set, you would try to disable the interrupts and if the open fails
you would fall back to 'normal' mode.
The alternative would be to remove the _*can* but keep the set/get
routines. In that case the hw_params configuration would be rejected
if the hardware doesn't support this feature.
Which solution do you guys prefer?

Either way, it makes sense to check that the app uses the non-blocking
mode as well, otherwise everything would be broken as noted in the
remarks.

-Pierre

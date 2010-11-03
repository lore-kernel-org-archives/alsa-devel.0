From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] add API to allow disabling period
 interrupt
Date: Wed, 3 Nov 2010 08:38:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011030825250.29422@eeebox2.perex-int.cz>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
	<4CCFCA6A.8010803@ladisch.de>
	<alpine.LNX.2.00.1011020935550.29422@eeebox2.perex-int.cz>
	<4CCFD40F.1010407@ladisch.de>
	<alpine.LNX.2.00.1011021018591.29422@eeebox2.perex-int.cz>
	<AANLkTi=31_11GndkDYdGXiuM-LJ4cTbMNRMa0FaCZfCa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1546316655-1288769907=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D55E10380E
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 08:38:28 +0100 (CET)
In-Reply-To: <AANLkTi=31_11GndkDYdGXiuM-LJ4cTbMNRMa0FaCZfCa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1546316655-1288769907=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Nov 2010, pl bossart wrote:

>>>>>> +int snd_pcm_hw_params_can_disable_period_irq(const snd_pcm_hw_param=
s_t
>>>>>> *params)
>>>>>
>>>>> This function is useless because it cannot be called before
>>>>> snd_pcm_hw_params_set_period_irq().
>>>>
>>>> I don't think so. The info bits from the driver are used in this check
>>>> which are read-only.
>>>
>>> All the snd_pcm_hw_params_can_* functions that read the info bits
>>> are documented to require a completed configuration. =C2=A0So they actu=
ally
>>> don't, and there will never be a flag that depends on the configuration=
?
>>
>> You're right. The *_can_* check should be removed.
>
> If I remove the *_can_* check and add a flag for snd_pcm_open,
> actually the other set/get routines need to go as well. Everything
> would happen at the opening stages instead of when the hardware params
> are set, you would try to disable the interrupts and if the open fails
> you would fall back to 'normal' mode.

I'm not sure if it's good to have another flag for snd_pcm_open. If we=20
accept new open flag, it would be just an optional hint which should be=20
verified by the application if it's really enabled using a function.

> The alternative would be to remove the _*can* but keep the set/get
> routines. In that case the hw_params configuration would be rejected
> if the hardware doesn't support this feature.
> Which solution do you guys prefer?

Note that there is a big difference between your new flag and the existing=
=20
ones. The *_can_* functions just reflects the extended read only=20
capabilities:

snd_pcm_hw_params_can_mmap_sample_resolution
snd_pcm_hw_params_can_overrange
snd_pcm_hw_params_can_pause
snd_pcm_hw_params_can_resume
snd_pcm_hw_params_can_sync_start

I see two ways:

1) leave set/get functions with this semantics:
    - application tries to set the no period update behaviour for hw_params
      - alsa-lib should check if nonblock flag is set at this moment
    - snd_pcm_hw_params() call
    - application reads back the no period update state and if the flag is
      not set, it will use standard period updates
2) create new optional snd_pcm_open flag
    - application opens device with nonblock and no period update flags
    - snd_pcm_hw_params() call
    - application reads back the no period update state and if the flag is
      not set, it will use standard period updates

Note that we can even implement both methods together like for=20
handling the nonblock behaviour.

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1546316655-1288769907=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1546316655-1288769907=:29422--

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] add API to allow disabling period
 interrupt
Date: Mon, 8 Nov 2010 22:03:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011082202440.29422@eeebox2.perex-int.cz>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
	<4CCFCA6A.8010803@ladisch.de>
	<alpine.LNX.2.00.1011020935550.29422@eeebox2.perex-int.cz>
	<4CCFD40F.1010407@ladisch.de>
	<alpine.LNX.2.00.1011021018591.29422@eeebox2.perex-int.cz>
	<AANLkTi=31_11GndkDYdGXiuM-LJ4cTbMNRMa0FaCZfCa@mail.gmail.com>
	<alpine.LNX.2.00.1011030825250.29422@eeebox2.perex-int.cz>
	<AANLkTik0XRtw78aekfBw2q8HU2kUFGQ35A=NFL=4O+uM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1338662686-1289250190=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 02B0B243E7
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 22:03:11 +0100 (CET)
In-Reply-To: <AANLkTik0XRtw78aekfBw2q8HU2kUFGQ35A=NFL=4O+uM@mail.gmail.com>
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

--8323584-1338662686-1289250190=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Nov 2010, pl bossart wrote:

>> I see two ways:
>>
>> 1) leave set/get functions with this semantics:
>> =C2=A0 - application tries to set the no period update behaviour for hw_=
params
>> =C2=A0 =C2=A0 - alsa-lib should check if nonblock flag is set at this mo=
ment
>> =C2=A0 - snd_pcm_hw_params() call
>> =C2=A0 - application reads back the no period update state and if the fl=
ag is
>> =C2=A0 =C2=A0 not set, it will use standard period updates
>> 2) create new optional snd_pcm_open flag
>> =C2=A0 - application opens device with nonblock and no period update fla=
gs
>> =C2=A0 - snd_pcm_hw_params() call
>> =C2=A0 - application reads back the no period update state and if the fl=
ag is
>> =C2=A0 =C2=A0 not set, it will use standard period updates
>>
>> Note that we can even implement both methods together like for handling =
the
>> nonblock behaviour.
>
> I re-implemented the first solution and checked if the mode is indeed
> non-blocking. This solution assumes that the apps cannot go back to
> blocking mode at a later stage. Is it a valid asumption, or can the
> blocking mode be enabled/disabled at any time with snd_pcm_nonblock()?

Yes, this function must return an error if an app tries to set blocking=20
mode..

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1338662686-1289250190=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1338662686-1289250190=:29422--

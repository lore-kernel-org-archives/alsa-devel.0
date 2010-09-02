From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Since kernel-2.6.32 alsactl thinks my sound card
 is "Unknown"
Date: Thu, 2 Sep 2010 15:33:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009021515260.10278@eeebox2.perex-int.cz>
References: <s5hmxs0zgxs.wl%tiwai@suse.de>
	<1283419574.6497.4.camel@localhost.localdomain>
	<AANLkTi=f0B_MQAQoJkQYJydfQJ_QgJKoWC4K=Ku33BuG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-140731413-1283434416=:10278"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B370C24724
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 15:33:36 +0200 (CEST)
In-Reply-To: <AANLkTi=f0B_MQAQoJkQYJydfQJ_QgJKoWC4K=Ku33BuG@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-140731413-1283434416=:10278
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 2 Sep 2010, Raymond Yau wrote:

> 2010/9/2 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
>
>> El jue, 02-09-2010 a las 10:29 +0200, Takashi Iwai escribi=C3=B3:
>>> Rejected by SPF lookup: (recv=3Dllar.net.uniovi.es,
>>>  send-ip=3D195.135.220.2) Could not find a valid SPF record
>>> User-Agent: Wanderlust/2.15.6 (Almost Unreal) SEMI/1.14.6 (Maruoka)
>> FLIM/1.14.9
>>>  (=3D?UTF-8?B?R29qxY0=3D?=3D) APEL/10.7 Emacs/23.1 (x86_64-suse-linux-g=
nu)
>> MULE/6.0
>>>  (HANACHIRUSATO)
>>> References: <1283357723.8159.4.camel@localhost.localdomain>
>>>
>>> At Wed, 01 Sep 2010 18:15:23 +0200,
>>> Pacho Ramos wrote:
>>>>
>>>> This is an old problem I am suffering since kernel-2.6.32 and that is
>>>> still unresolved even with 2.6.35 and alsa-utils-1.0.23:
>>>> http://www.spinics.net/lists/alsa-devel/msg31422.html
>>>>
>>>> If you follow the thread, it got stalled in:
>>>> http://www.spinics.net/lists/alsa-devel/msg31433.html
>>>>
>>>> In summary, I get the following:
>>>> # alsactl -f /etc/asound.state restore /dev/snd/controlC0
>>>> Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b=
"
>>>> "0x1415"
>>>> Hardware is initialized using a guess method
>>>> # echo $?
>>>> 99
>>>
>>> This is no error.  It means that alsactl has no special workaround
>>> for your hardware.  The return code of alsactl looks strange.
>>> I thought Jaroslav has already fixed it, though...
>>>
>>>
>>> Takashi
>>>
>>
>> Well, Jaroslav fixed it to use "99" instead of "157":
>> http://www.spinics.net/lists/alsa-devel/msg31430.html
>>
>> And, about the message, could it be reworded for preventing to make
>> users think their hardware is "Unknown"? Maybe it could simply show "No
>> workaround needed for: ..." instead of "Unknown hardware"
>>
>> Thanks :-)

I renamed string to "Found hardware:" to avoid this confusion.

> It seem to me that the current logic of alsactl try to compare  the numbe=
r
> of controls created by the driver and  the number of controls in the stat=
e
> file before it restore the controls from the state file.
>
> it assume that it cannot restored the setting from the state file when th=
e
> number of controls does not match , so it call the init routine instead o=
f
> restore routine.
>
> This create a problem for those drivers which have IFACE_PCM "PCM volume
> control" since  alsactl does not need to store the value of the controls =
in
> the state file as those per voice volume controls are always initialised
> when the stream is open for those sound cards via82xx and ymfpci
>
> This mean that the number of controls in state file is always less than t=
he
> number of controls created by the driver and that is the reason why alsac=
tl
> always init instead of restore the setting for both  via82xx  and ymfpci
>
> To solve this bug, alsactl should subtract the number of those IFACE_PCM
> "PCM volume control" when comparing the number of control in state file

But this policy is not universal. Basically, the problem is for two types=
=20
of controls:

1) static, created in the driver, which can go to the inactive state
2) dynamic ones

The first type can be solved by storing of inactive values to the state=20
file. The restore procedure will know about all static driver controls and=
=20
can just skip ones which are marked inactive in the state file or in the=20
driver (it means that the controls which can be inactive will be restored=
=20
only when they are active in the state file and in the driver). Another=20
possibility is to mark these controls with a temporary flag to skip them=20
inside alsactl.

The second one (dynamic controls) are more difficult to handle. We cannot=
=20
distinguish them from static controls now.

It seems that the best method will be to restore what we can and=20
initialize rest without overwritting the restored controls (something like=
=20
"merge" mode - restore+init).

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-140731413-1283434416=:10278
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-140731413-1283434416=:10278--

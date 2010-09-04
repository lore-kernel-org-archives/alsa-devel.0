From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Since kernel-2.6.32 alsactl thinks my sound card
	is "Unknown"
Date: Sat, 4 Sep 2010 11:36:58 +0800
Message-ID: <AANLkTimQrVuo-+v+JaYagPcQfTxRmVsJa6s33+2pRRcP@mail.gmail.com>
References: <s5hmxs0zgxs.wl%tiwai@suse.de>
	<1283419574.6497.4.camel@localhost.localdomain>
	<AANLkTi=f0B_MQAQoJkQYJydfQJ_QgJKoWC4K=Ku33BuG@mail.gmail.com>
	<alpine.LNX.2.00.1009021515260.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id ADD96245C9
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Sep 2010 05:36:59 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1501347ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2010 20:36:58 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1009021515260.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/2 Jaroslav Kysela <perex@perex.cz>

> On Thu, 2 Sep 2010, Raymond Yau wrote:
>
>  2010/9/2 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
>>
>>  El jue, 02-09-2010 a las 10:29 +0200, Takashi Iwai escribi=F3:
>>>
>>>> Rejected by SPF lookup: (recv=3Dllar.net.uniovi.es,
>>>>  send-ip=3D195.135.220.2) Could not find a valid SPF record
>>>> User-Agent: Wanderlust/2.15.6 (Almost Unreal) SEMI/1.14.6 (Maruoka)
>>>>
>>> FLIM/1.14.9
>>>
>>>>  (=3D?UTF-8?B?R29qxY0=3D?=3D) APEL/10.7 Emacs/23.1 (x86_64-suse-linux-=
gnu)
>>>>
>>> MULE/6.0
>>>
>>>>  (HANACHIRUSATO)
>>>> References: <1283357723.8159.4.camel@localhost.localdomain>
>>>>
>>>> At Wed, 01 Sep 2010 18:15:23 +0200,
>>>> Pacho Ramos wrote:
>>>>
>>>>>
>>>>> This is an old problem I am suffering since kernel-2.6.32 and that is
>>>>> still unresolved even with 2.6.35 and alsa-utils-1.0.23:
>>>>> http://www.spinics.net/lists/alsa-devel/msg31422.html
>>>>>
>>>>> If you follow the thread, it got stalled in:
>>>>> http://www.spinics.net/lists/alsa-devel/msg31433.html
>>>>>
>>>>> In summary, I get the following:
>>>>> # alsactl -f /etc/asound.state restore /dev/snd/controlC0
>>>>> Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147=
b"
>>>>> "0x1415"
>>>>> Hardware is initialized using a guess method
>>>>> # echo $?
>>>>> 99
>>>>>
>>>>
>>>> This is no error.  It means that alsactl has no special workaround
>>>> for your hardware.  The return code of alsactl looks strange.
>>>> I thought Jaroslav has already fixed it, though...
>>>>
>>>>
>>>> Takashi
>>>>
>>>>
>>> Well, Jaroslav fixed it to use "99" instead of "157":
>>> http://www.spinics.net/lists/alsa-devel/msg31430.html
>>>
>>> And, about the message, could it be reworded for preventing to make
>>> users think their hardware is "Unknown"? Maybe it could simply show "No
>>> workaround needed for: ..." instead of "Unknown hardware"
>>>
>>> Thanks :-)
>>>
>>
> I renamed string to "Found hardware:" to avoid this confusion.
>
>
>  It seem to me that the current logic of alsactl try to compare  the numb=
er
>> of controls created by the driver and  the number of controls in the sta=
te
>> file before it restore the controls from the state file.
>>
>> it assume that it cannot restored the setting from the state file when t=
he
>> number of controls does not match , so it call the init routine instead =
of
>> restore routine.
>>
>> This create a problem for those drivers which have IFACE_PCM "PCM volume
>> control" since  alsactl does not need to store the value of the controls
>> in
>> the state file as those per voice volume controls are always initialised
>> when the stream is open for those sound cards via82xx and ymfpci
>>
>> This mean that the number of controls in state file is always less than
>> the
>> number of controls created by the driver and that is the reason why
>> alsactl
>> always init instead of restore the setting for both  via82xx  and ymfpci
>>
>> To solve this bug, alsactl should subtract the number of those IFACE_PCM
>> "PCM volume control" when comparing the number of control in state file
>>
>
> But this policy is not universal. Basically, the problem is for two types
> of controls:
>
> 1) static, created in the driver, which can go to the inactive state
> 2) dynamic ones
>
> The first type can be solved by storing of inactive values to the state
> file. The restore procedure will know about all static driver controls and
> can just skip ones which are marked inactive in the state file or in the
> driver (it means that the controls which can be inactive will be restored
> only when they are active in the state file and in the driver).


Storing those active per voice volume controls in the state file seem to be
used for debugging in the past if hwmixevolume can be used for debugging

an alsa-tool hwmixvolume which allows you to control the volume of
individual streams on sound cards that use hardware mixing, (similar to
pavucontrol or the Sound Preference in Gnome to control the per application
volume of PA clients)

No , you cannot restore those IFACE_PCM controls only when they are active
in the state file , otherwise they don't need to specify lock true in
EMU10K1.conf

                       {
                        interface PCM
                                 name "EMU10K1 PCM Send Volume"
                                 index { @func private_pcm_subdevice }
                                 lock true
                                 optional true
                                 value [ 255 255 0 0 255 0 0 0 0 255 0 0 ]
                         }
                         {
                           interface PCM
                                 name "EMU10K1 PCM Send Routing"
                                 index { @func private_pcm_subdevice }
                                 lock true
                                 optional true
                                 value [ 8 9 0 0 8 9 0 0 8 9 0 0 ]
                         }

This is another case which PA cannot use "front" device for capturing too.

emu10k1 use the setting inf EMU10k1.conf when the application open "front",
"rear" to change the routing

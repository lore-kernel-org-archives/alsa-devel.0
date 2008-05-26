From: =?ISO-8859-1?Q?Martin_Kr=FCger?= <m_a_krueger@gmx.de>
Subject: Re: PATCH - MIDI on ice1724 - real-time kernel problem
 SOLVED(?)
Date: Mon, 26 May 2008 18:29:00 +0200
Message-ID: <483AE54C.3090807@gmx.de>
References: <20080520112539.81C9D2484D@alsa0.perex.cz>	<m2bq2xtixw.fsf@vador.mandriva.com>	<483847ED.8050208@gmx.de>	<483A6D6F.1050108@insite.cz>	<483A96E8.8090507@gmx.de>
	<s5hbq2tunel.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 901B524337
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 18:29:02 +0200 (CEST)
In-Reply-To: <s5hbq2tunel.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pavel Hofman <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
> At Mon, 26 May 2008 12:54:32 +0200,
> Martin Kr=FCger wrote:
>   =

>> Pavel Hofman wrote:
>>     =

>>> Martin Kr=FCger wrote:
>>>   =

>>>       =

>>>> Pavel Hofman wrote:
>>>>     =

>>>> Hi, =

>>>>
>>>> thanks a lot for taking care for that issue. =

>>>> I just tried it out by modifying the following files from the 2.6.26-r=
c3 kernel:
>>>>
>>>> sound/pci/Kconfig (modified by hand)
>>>> sound/pci/ice1712/ice1712.h (modified by hand)
>>>> sound/pci/ice1712/envy24ht.h (modified by hand)
>>>> sound/pci/ice1712/ice1724.c (copied from the actual Git snapshot)
>>>>
>>>> I double-checked all the handmade changes, should be ok. =

>>>>
>>>> Midi in via "amidi -p hw:0 -d" works now without problem, =

>>>> but when trying to write to the device, for example by "amidi -p hw:0 =
-s txdata.syx" =

>>>> it causes an immediate crash. =

>>>>
>>>> That would not be a problem for me, but jackd probes all ports, and is=
 unusable now.
>>>>
>>>> Perhaps i forgot a patch, is the output working for you? =

>>>>     =

>>>>         =

>>> Hello Martin,
>>>
>>> I did check the MIDI output using command
>>>
>>> amidi -p hw:0 -S F0411042110C000000000074FF0411042110C000000
>>>
>>> Ubuntu Studio 7.10, both -generic and -rt kernel, Audiotrak Prodigy 192=
, =

>>> the original patch (I assume the current git version is identical).
>>>
>>> There was no MIDI device connected to the output as I have none.
>>>
>>> I traced if MIDI-out on Juli goes through the Xilinx CPLD, and it seeme=
d =

>>> the MIDI lines go straight to the connectors, just as on my Prodigy 192=
. =

>>> Unfortunately, I do not have Juli available any more to test the patch.
>>>
>>> Please could you provide more details about the crash?
>>>
>>> Thanks,
>>>
>>> Pavel.
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>   =

>>>       =

>> Hello Pavel,
>>
>> i just compiled a new 2.6.25.4 kernel with realtime support. the kernel =

>> is from kernel.org, so without any patches except the realtime patch =

>> from the alsa wiki.
>>     =

>
> To be sure -- does 2.6.25.4 without realtime support work?
>
>
> Takashi
>   =

No. Not with an unpatched kernel set to "Preemptible Kernel (Low-Latency =

Desktop) PREEMPT_DESKTOP". I didn't test the lower preemption modes.

Martin

From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - MIDI on ice1724 - real-time kernel problem
 SOLVED(?)
Date: Thu, 29 May 2008 11:35:35 +0200
Message-ID: <483E78E7.4020106@insite.cz>
References: <20080520112539.81C9D2484D@alsa0.perex.cz>	<m2bq2xtixw.fsf@vador.mandriva.com>	<483847ED.8050208@gmx.de>	<483A6D6F.1050108@insite.cz>	<483A96E8.8090507@gmx.de>	<s5hbq2tunel.wl%tiwai@suse.de>	<483AE54C.3090807@gmx.de>
	<483D48DE.1010105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 72F3D24842
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 11:35:47 +0200 (CEST)
In-Reply-To: <483D48DE.1010105@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Martin_Kr=FCger?= <m_a_krueger@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Kr=FCger wrote:
> Martin Kr=FCger schrieb:
>> Takashi Iwai schrieb:
>>   =

>>> At Mon, 26 May 2008 12:54:32 +0200,
>>> Martin Kr=FCger wrote:
>>>   =

>>>     =

>>>> Pavel Hofman wrote:
>>>>     =

>>>>       =

>>>>> Martin Kr=FCger wrote:
>>>>>   =

>>>>>       =

>>>>>         =

>>>>>       =

>>>>>         =

>>>> Hello Pavel,
>>>>
>>>> i just compiled a new 2.6.25.4 kernel with realtime support. the kerne=
l =

>>>> is from kernel.org, so without any patches except the realtime patch =

>>>> from the alsa wiki.
>>>>     =

>>>>       =

>>> To be sure -- does 2.6.25.4 without realtime support work?
>>>
>>>
>>> Takashi
>>>   =

>>>     =

>> No. Not with an unpatched kernel set to "Preemptible Kernel (Low-Latency =

>> Desktop) PREEMPT_DESKTOP". I didn't test the lower preemption modes.
>>
>> Martin
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>   =

> Hi,
> =

> i just compiled a 2.6.25-3 with Preemption disabled and i still get the =

> the same.
> =

> Midi in works, Midi out leads to a complete system freeze.
> Is there a workaroud of disabling just Midi out? That would solve the =

> bug for me, and would prevent other users from freezing their system...
> =


Hi Martin,

I will try a newer kernel on my home Ubuntu 7.10.

We really need to find out what freezes your system. Is it a complete =

freeze, or just heavy overload?

Originally, I experienced a complete freeze caused by infinite loop in =

IRQ handler ice1724.c:snd_vt1724_interrupt. This loop is already avoided =

by the timeout variable. Do you run with  CONFIG_SND_DEBUG? Does dmesg =

list any of the "ice1724: Too long irq loop..." messages?

Later on, I experienced an IRQ flood, caused by intermittent throwing =

ICE1724 IRQ (MPU transmit). I could see the IRQxx "process" hogging the =

CPU in top. If that is the case, please add some debug statements to =

ice1724.c:snd_vt1724_interrupt and look which IRQ gets fired (variable =

status).

In any case, please make sure you are using the latest GIT version with =

all the patches, so that we all work on the same code.

Disabling MIDI OUT - I have not tested the following patch, perhaps it =

needs some changes:


diff --git a/pci/ice1712/ice1724.c b/pci/ice1712/ice1724.c
index e596d77..13695de 100644
--- a/pci/ice1712/ice1724.c
+++ b/pci/ice1712/ice1724.c
@@ -2546,7 +2546,7 @@ static int __devinit snd_vt1724_probe(struct =

pci_dev *pci,
                 if (ice->eeprom.data[ICE_EEP2_SYSCONF] & =

VT1724_CFG_MPU401) {
                         struct snd_rawmidi *rmidi;

-                       err =3D snd_rawmidi_new(card, "MIDI", 0, 1, 1, =

&rmidi);
+                       err =3D snd_rawmidi_new(card, "MIDI", 0, 0, 1, =

&rmidi);
                         if (err < 0) {
                                 snd_card_free(card);
                                 return err;
@@ -2554,11 +2554,7 @@ static int __devinit snd_vt1724_probe(struct =

pci_dev *pci
                         ice->rmidi[0] =3D rmidi;
                         rmidi->private_data =3D ice;
                         strcpy(rmidi->name, "ICE1724 MIDI");
-                       rmidi->info_flags =3D SNDRV_RAWMIDI_INFO_OUTPUT |
-                                           SNDRV_RAWMIDI_INFO_INPUT |
-                                           SNDRV_RAWMIDI_INFO_DUPLEX;
-                       snd_rawmidi_set_ops(rmidi, =

SNDRV_RAWMIDI_STREAM_OUTPUT,
-                                           &vt1724_midi_output_ops);
+                       rmidi->info_flags =3D SNDRV_RAWMIDI_INFO_INPUT;
                         snd_rawmidi_set_ops(rmidi, =

SNDRV_RAWMIDI_STREAM_INPUT,
                                             &vt1724_midi_input_ops);






Regards,

Pavel.

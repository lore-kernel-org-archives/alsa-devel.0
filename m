From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Sat, 02 Jul 2011 00:37:09 +0200
Message-ID: <4E0E4C15.7000109@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org>	<4E036C8F.3080709@gmail.com>	<s5hvcvvzkzq.wl%tiwai@suse.de>	<s5hk4cbzj6s.wl%tiwai@suse.de>	<4E047441.4010003@gmail.com>	<s5hpqm2v0zq.wl%tiwai@suse.de>	<4E05C1B1.50302@gmail.com>	<4E05C704.4080806@gmail.com>	<4E05CE02.1070801@gmail.com>	<s5hei2fvmgw.wl%tiwai@suse.de>	<4E082166.5060902@gmail.com>	<s5hpqlz3a3b.wl%tiwai@suse.de>	<s5hhb7b315l.wl%tiwai@suse.de>	<4E08E33D.3060608@gmail.com>	<s5htybaton8.wl%tiwai@suse.de>	<4E0B62B6.6000007@gmail.com>	<4E0B6BE0.1010003@gmail.com>	<4E0B7D22.3040009@gmail.com>	<s5hei2bsxdv.wl%tiwai@suse.de>	<4E0C17F2.5070704@gmail.com>	<s5hzkkzreqr.wl%tiwai@suse.de>	<4E0CABBC.3070801@gmail.com>	<s5hwrg3i5eb.wl%tiwai@suse.de>	<4E0CBBED.9050501@gmail.com>	<s5hsjqri0eo.wl%tiwai@suse.de>	<4E0CD984.9050408@gmail.com>	<s5hpqluinj5
 .wl%tiwai@suse.de>	<4E0D65C2.7070106@gmail.com>	<s5hmxgyikmi.wl%tiwai@suse.de>	<4E0D68EB.5020909@gmail.com>	<4E0D7243.7030202@gmail.com>
	<s5hboxeiiad.wl%tiwai@suse.de> <4E0E4581.1070505@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070004020603070908060204"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B41D2447C
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Jul 2011 00:37:14 +0200 (CEST)
Received: by wwj26 with SMTP id 26so2778420wwj.20
	for <alsa-devel@alsa-project.org>; Fri, 01 Jul 2011 15:37:13 -0700 (PDT)
In-Reply-To: <4E0E4581.1070505@gmail.com>
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

This is a multi-part message in MIME format.
--------------070004020603070908060204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

W dniu 2011-07-02 00:09, Julian Sikorski pisze:
> W dniu 01.07.2011 09:14, Takashi Iwai pisze:
>> At Fri, 01 Jul 2011 09:07:47 +0200,
>> Julian Sikorski wrote:
>>>
>>>>>>>> So it seems that the only things remaining are the SPDIF/rear channel
>>>>>>>> jack and the coupled muting issue.
>>>>>>>
>>>>>>> It's a BIOS bug.  It doesn't tell SPDIF is available.
>>>>>>> Ditto for the 4th stereo out.  No pin is exposed by BIOS.
>>>>>>
>>>>>> I see. I can try updating the BIOS and see if it changes anything. If it
>>>>>> doesn't, is there a way to work the problem around in the driver?
>>>>>
>>>>> You need to figure out pins manually by yourself, then change the
>>>>> driver code.  I leave it as a homework :)
>>>>
>>>> :) I cannot write code, so I would not count on myself doing that. I
>>>> will have a look into updating the BIOS though.
>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>
>>>> Once again thanks for all the work you have done,
>>>>
>>>> Julian
>>> Hmm, I googled a bit and it seems the way to find the pins is to write
>>> values to user_pin_configs. So no coding knowledge seems needed, could
>>> you give me some pointers on where to start?
>>
>> First off, read the HD-audio specification to understand what the values
>> represent.  Then, use hda-analyzer or manually via hda-verb, figure out
>> which widget corresponds to which I/O jack.  Compose the corresponding
>> pin-config value, and put it to the sysfs file.  A brief description
>> is found in Documentation/sound/alsa/HD-Audio.txt.
>>
>>
>> Takashi
> I have been scratching my head for almost 2 h now without much progress.
> Can I steal this values from Windows driver somehow? It seems to be
> possible:
>
> http://www.insanelymac.com/forum/index.php?s=3298551705d0d48ba8faa28b9a7d3283&showtopic=137188&st=20
>
> Julian
I managed to get the data out of Windows install, does it look useful?

Julian

--------------070004020603070908060204
Content-Type: text/plain; charset=UTF-16;
 name="pinconfigoverrides.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pinconfigoverrides.txt"

//5XAGkAbgBkAG8AdwBzACAAUgBlAGcAaQBzAHQAcgB5ACAARQBkAGkAdABvAHIAIABWAGUA
cgBzAGkAbwBuACAANQAuADAAMAANAAoADQAKAFsASABLAEUAWQBfAEwATwBDAEEATABfAE0A
QQBDAEgASQBOAEUAXABTAFkAUwBUAEUATQBcAEMAbwBuAHQAcgBvAGwAUwBlAHQAMAAwADEA
XABDAG8AbgB0AHIAbwBsAFwAQwBsAGEAcwBzAFwAewA0AEQAMwA2AEUAOQA2AEMALQBFADMA
MgA1AC0AMQAxAEMARQAtAEIARgBDADEALQAwADgAMAAwADIAQgBFADEAMAAzADEAOAB9AFwA
MAAwADAAMABcAFAAaQBuAEMAbwBuAGYAaQBnAE8AdgBlAHIAcgBpAGQAZQBWAGUAcgBiAHMA
XQANAAoAIgAwADAAMAAwACIAPQBoAGUAeAA6AGYAMAAsADEAYwAsADEANwAsADAAMQANAAoA
IgAwADAAMAAxACIAPQBoAGUAeAA6ADEAMQAsADEAZAAsADEANwAsADAAMQANAAoAIgAwADAA
MAAyACIAPQBoAGUAeAA6ADEAMQAsADEAZQAsADEANwAsADAAMQANAAoAIgAwADAAMAAzACIA
PQBoAGUAeAA6ADQAMQAsADEAZgAsADEANwAsADAAMQANAAoAIgAwADAAMAA0ACIAPQBoAGUA
eAA6AGYAMAAsADEAYwAsADIANwAsADAAMQANAAoAIgAwADAAMAA1ACIAPQBoAGUAeAA6ADEA
MQAsADEAZAAsADIANwAsADAAMQANAAoAIgAwADAAMAA2ACIAPQBoAGUAeAA6ADEAMQAsADEA
ZQAsADIANwAsADAAMQANAAoAIgAwADAAMAA3ACIAPQBoAGUAeAA6ADQAMQAsADEAZgAsADIA
NwAsADAAMQANAAoAIgAwADAAMAA4ACIAPQBoAGUAeAA6ADEAMAAsADEAYwAsADQANwAsADAA
MQANAAoAIgAwADAAMAA5ACIAPQBoAGUAeAA6ADAAMQAsADEAZAAsADQANwAsADAAMQANAAoA
IgAwADAAMQAwACIAPQBoAGUAeAA6ADEAMwAsADEAZQAsADQANwAsADAAMQANAAoAIgAwADAA
MQAxACIAPQBoAGUAeAA6ADkAOQAsADEAZgAsADQANwAsADAAMQANAAoAIgAwADAAMQAyACIA
PQBoAGUAeAA6AGYAMAAsADEAYwAsADUANwAsADAAMQANAAoAIgAwADAAMQAzACIAPQBoAGUA
eAA6ADEAMQAsADEAZAAsADUANwAsADAAMQANAAoAIgAwADAAMQA0ACIAPQBoAGUAeAA6ADEA
MQAsADEAZQAsADUANwAsADAAMQANAAoAIgAwADAAMQA1ACIAPQBoAGUAeAA6ADQAMQAsADEA
ZgAsADUANwAsADAAMQANAAoAIgAwADAAMQA2ACIAPQBoAGUAeAA6AGYAMAAsADEAYwAsADYA
NwAsADAAMQANAAoAIgAwADAAMQA3ACIAPQBoAGUAeAA6ADEAMQAsADEAZAAsADYANwAsADAA
MQANAAoAIgAwADAAMQA4ACIAPQBoAGUAeAA6ADEAMQAsADEAZQAsADYANwAsADAAMQANAAoA
IgAwADAAMQA5ACIAPQBoAGUAeAA6ADQAMQAsADEAZgAsADYANwAsADAAMQANAAoAIgAwADAA
MgAwACIAPQBoAGUAeAA6AGYAMAAsADEAYwAsADcANwAsADAAMQANAAoAIgAwADAAMgAxACIA
PQBoAGUAeAA6ADEAMQAsADEAZAAsADcANwAsADAAMQANAAoAIgAwADAAMgAyACIAPQBoAGUA
eAA6ADEAMQAsADEAZQAsADcANwAsADAAMQANAAoAIgAwADAAMgAzACIAPQBoAGUAeAA6ADQA
MQAsADEAZgAsADcANwAsADAAMQANAAoAIgAwADAAMgA0ACIAPQBoAGUAeAA6ADMAMAAsADEA
YwAsADgANwAsADAAMQANAAoAIgAwADAAMgA1ACIAPQBoAGUAeAA6ADEAYwAsADEAZAAsADgA
NwAsADAAMQANAAoAIgAwADAAMgA2ACIAPQBoAGUAeAA6AGEAMQAsADEAZQAsADgANwAsADAA
MQANAAoAIgAwADAAMgA3ACIAPQBoAGUAeAA6ADAAMQAsADEAZgAsADgANwAsADAAMQANAAoA
IgAwADAAMgA4ACIAPQBoAGUAeAA6ADMAMQAsADEAYwAsADkANwAsADAAMQANAAoAIgAwADAA
MgA5ACIAPQBoAGUAeAA6ADAAOQAsADEAZAAsADkANwAsADAAMQANAAoAIgAwADAAMwAwACIA
PQBoAGUAeAA6AGEAMwAsADEAZQAsADkANwAsADAAMQANAAoAIgAwADAAMwAxACIAPQBoAGUA
eAA6ADkAOQAsADEAZgAsADkANwAsADAAMQANAAoAIgAwADAAMwAyACIAPQBoAGUAeAA6ADMA
ZgAsADEAYwAsAGEANwAsADAAMQANAAoAIgAwADAAMwAzACIAPQBoAGUAeAA6ADEANAAsADEA
ZAAsAGEANwAsADAAMQANAAoAIgAwADAAMwA0ACIAPQBoAGUAeAA6ADgAMQAsADEAZQAsAGEA
NwAsADAAMQANAAoAIgAwADAAMwA1ACIAPQBoAGUAeAA6ADAAMQAsADEAZgAsAGEANwAsADAA
MQANAAoAIgAwADAAMwA2ACIAPQBoAGUAeAA6ADEAZgAsADEAYwAsAGIANwAsADAAMQANAAoA
IgAwADAAMwA3ACIAPQBoAGUAeAA6ADEAMAAsADEAZAAsAGIANwAsADAAMQANAAoAIgAwADAA
MwA4ACIAPQBoAGUAeAA6ADIAMQAsADEAZQAsAGIANwAsADAAMQANAAoAIgAwADAAMwA5ACIA
PQBoAGUAeAA6ADAAMQAsADEAZgAsAGIANwAsADAAMQANAAoAIgAwADAANAAwACIAPQBoAGUA
eAA6AGYAMAAsADEAYwAsAGMANwAsADAAMQANAAoAIgAwADAANAAxACIAPQBoAGUAeAA6ADEA
MQAsADEAZAAsAGMANwAsADAAMQANAAoAIgAwADAANAAyACIAPQBoAGUAeAA6ADEAMQAsADEA
ZQAsAGMANwAsADAAMQANAAoAIgAwADAANAAzACIAPQBoAGUAeAA6ADQAMQAsADEAZgAsAGMA
NwAsADAAMQANAAoAIgAwADAANAA0ACIAPQBoAGUAeAA6AGYAMAAsADEAYwAsAGQANwAsADAA
MQANAAoAIgAwADAANAA1ACIAPQBoAGUAeAA6ADAAMQAsADEAZAAsAGQANwAsADAAMQANAAoA
IgAwADAANAA2ACIAPQBoAGUAeAA6ADgAMwAsADEAZQAsAGQANwAsADAAMQANAAoAIgAwADAA
NAA3ACIAPQBoAGUAeAA6ADUAOQAsADEAZgAsAGQANwAsADAAMQANAAoAIgAwADAANAA4ACIA
PQBoAGUAeAA6ADIAMAAsADEAYwAsAGUANwAsADAAMQANAAoAIgAwADAANAA5ACIAPQBoAGUA
eAA6ADEAMQAsADEAZAAsAGUANwAsADAAMQANAAoAIgAwADAANQAwACIAPQBoAGUAeAA6ADQA
NQAsADEAZQAsAGUANwAsADAAMQANAAoAIgAwADAANQAxACIAPQBoAGUAeAA6ADAAMQAsADEA
ZgAsAGUANwAsADAAMQANAAoAIgAwADAANQAyACIAPQBoAGUAeAA6AGYAMAAsADEAYwAsAGYA
NwAsADAAMQANAAoAIgAwADAANQAzACIAPQBoAGUAeAA6ADEAMQAsADEAZAAsAGYANwAsADAA
MQANAAoAIgAwADAANQA0ACIAPQBoAGUAeAA6ADEAMQAsADEAZQAsAGYANwAsADAAMQANAAoA
IgAwADAANQA1ACIAPQBoAGUAeAA6ADQAMQAsADEAZgAsAGYANwAsADAAMQANAAoAIgBOAHUA
bQBWAGUAcgBiAHMAIgA9AGgAZQB4ADoAMwA4ACwAMAAwACwAMAAwACwAMAAwAA0ACgANAAoA

--------------070004020603070908060204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070004020603070908060204--

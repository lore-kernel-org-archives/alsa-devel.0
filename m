From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Cherry Trail + RT5645 devices analog microphone
	not working.
Date: Wed, 27 Dec 2017 20:12:54 +0100
Message-ID: <a0540986-369c-5bca-424f-102391d85095@redhat.com>
References: <d42279d7-0350-563f-fca7-27f32cb9e9ee@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D7027476BE@RTITMBSV02.realtek.com.tw>
 <6ccb2c4c-042f-46c0-5247-90f79d49c840@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D70274A822@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------BA22AD8355A2445EA4E5EEA2"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 929B1266DD5
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 20:12:57 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id g75so41039694wme.0
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 11:12:57 -0800 (PST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70274A822@RTITMBSV02.realtek.com.tw>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------BA22AD8355A2445EA4E5EEA2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 26-12-17 06:29, Bard Liao wrote:
>> -----Original Message-----
>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>> Sent: Monday, December 25, 2017 8:03 PM
>> To: Bard Liao
>> Cc: Pierre-Louis Bossart; alsa-devel@alsa-project.org
>> Subject: Re: Cherry Trail + RT5645 devices analog microphone not working.
>>
>> Hi,
>>
>> On 25-12-17 03:15, Bard Liao wrote:
>>>> -----Original Message-----
>>>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>>>> Sent: Sunday, December 24, 2017 6:43 PM
>>>> To: Bard Liao
>>>> Cc: Pierre-Louis Bossart; alsa-devel@alsa-project.org
>>>> Subject: Cherry Trail + RT5645 devices analog microphone not working.
>>>>
>>>> Hi Bard,
>>>>
>>>> I've been looking into getting the microphone to work on
>>>> some Cherry Trail + RT5645 devices with what appears to
>>>> be a simple analog microphone.
>>>>
>>>> You can see the microphone on one of the models I'm trying
>>>> to get it to work on soldered onto the right side of the PCB
>>>> here: https://i.imgur.com/bJzBQWe.jpg
>>>>
>>>> I'm using this ucm config:
>>>>
>>>> https://fedorapeople.org/~jwrdegoede/chtrt5645/
>>>>
>>>> Which is basically Pierre-Louis Bossart's config from:
>>>> https://github.com/plbossart/UCM
>>>>
>>>> Adjusted because the devices all have a mono speaker.
>>>>
>>>> I've been trying to get this to work myself and I can get
>>>> some sound while recording by adding:
>>>>
>>>>                    cset "name='RECMIXL BST2 Switch' on"
>>>>                    cset "name='RECMIXR BST2 Switch' on"
>>>>
>>>> But then I mainly get noise, I do get some sound from the
>>>> microphone if I talk really really loudly, but it is
>>>> barely above the noise-floor. I've the feeling that BST2
>>>> is only picking up the microphone via cross-talk and
>>>> that BST1 indeed is the correct input, but for some reason
>>>> I get complete silence when recording when only BST1 is
>>>> selected in the RECMIXR, and yes I've checked / set the
>>>> "IN1 boost volume".
>>>>
>>>> TL;DR: I'm trying to get an analog mic to work on 3
>>>> different models Cherry Trail + RT5645 devices and I've
>>>> been unable to get this to work. I've put a registerdump
>>>> of the rt5645 with gnome-sound-recorder running here:
>>>> https://fedorapeople.org/~jwrdegoede/rt5645-mic-red.dump
>>>>
>>>> Any insights / help with this would be very much
>>>> welcome.
>>>
>>> I don't have the schematic, but I think you probably need micbias
>>> for the capture. Please add both "micbias1" and "micbias2" in
>>> the audio route since I don't know which one is needed.
>>> for example
>>> static const struct snd_soc_dapm_route cht_rt5645_audio_map[] = {
>>> ...
>>> 	{"Int Mic", NULL, "micbias1"},
>>> 	{"Int Mic", NULL, "micbias2"},
>>> ...
>>> };
>>
>> Thank you for your reply. I've tested this, but unfortunately it
>> does not help.
>>
>> Do you perhaps have a cherrytrail device withrt5645 codec where you
>> can test an analog mic input with the upstream driver + latest ucm
>> file from Pierre-Louis with yourself ? I've the feeling that this is
>> not specific to the 3 devices I've access to but a general problem
>> in the driver and/or the ucm files.
> 
> Please try the attached patch. I don't have any cherrytrail device with
> rt5645 codec. But I verified the register settings on my rt5645 EVB.
> If the patch doesn't work, please dump register for me.
> Note that adding "micbias1" and "micbias2 in the audio route is also
> needed.

Thank you, modifying the RT5645_GEN_CTRL2 reg seems to help, for
some reason the patch does not work and neither MB1 and MB2 in reg
0x64 nor the RT5645_GEN_CTRL2 changes happen, but after manually
applying these with i2cset I can actual use the mic, although there
is still quite a bit of white noise in the background.

Attached is a regdump after making the manual changes to reg 0x64 and
reg 0xfb.

I did add the micbias audio routes:

@@ -2297,6 +2297,9 @@ static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
  	{ "DMIC2", NULL, "DMIC L2" },
  	{ "DMIC2", NULL, "DMIC R2" },

+	{ "Int Mic", NULL, "micbias1" },
+	{ "Int Mic", NULL, "micbias2" },
+
  	{ "BST1", NULL, "IN1P" },
  	{ "BST1", NULL, "IN1N" },
  	{ "BST1", NULL, "JD Power" },

But I believe that your tree has some patches which are not upstream yet,
the last patch you attached expects the micbias1 and micbias2 lines
in the widget lists to be of the "SND_SOC_DAPM_SUPPLY" type, but here:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/tree/sound/soc/codecs/rt5645.c?h=topic/rt5645

They are still of the SND_SOC_DAPM_MICBIAS type.

Regards,

Hans


> 
>>
>> Regards,
>>
>> Hans
>>
>> ------Please consider the environment before printing this e-mail.

--------------BA22AD8355A2445EA4E5EEA2
Content-Type: text/plain; charset=UTF-8;
 name="rt5645-mic-red.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="rt5645-mic-red.dump"

MDAwOiAwMDAwCjAwMTogODg4OAowMDI6IGM4YzgKMDAzOiBjOGM4CjAwNDogYzgwYQowMDU6
IDAwMDAKMDA2OiAwMDAwCjAwNzogMDAwMAowMDg6IDAwMDAKMDA5OiAwMDAwCjAwYTogNzAw
MgowMGI6IDM4MjcKMDBjOiBlMDAwCjAwZDogMDMwMAowMGU6IDAwMDAKMDBmOiAwMDAwCjAx
MDogMDAwMAowMTE6IDAwMDAKMDEyOiAwMDAwCjAxMzogMDAwMAowMTQ6IDMzMzMKMDE1OiAw
MDAwCjAxNjogNGIwMAowMTc6IDAwMDAKMDE4OiAwMThiCjAxOTogYWZhZgowMWE6IGFmYWYK
MDFiOiAwMDExCjAxYzogM2YzZgowMWQ6IDdmN2YKMDFlOiA1MDAwCjAxZjogMDAwMAowMjA6
IGEwMDAKMDIxOiAwMDAwCjAyMjogMDAwMAowMjM6IDAwMDAKMDI0OiAwMDAwCjAyNTogMDAw
MAowMjY6IDAwMDAKMDI3OiAzODIwCjAyODogMzgzOAowMjk6IGMwYzAKMDJhOiAxNDU2CjAy
YjogMDQwNAowMmM6IGFhYTAKMDJkOiAwMDAwCjAyZTogMDAwMAowMmY6IDEwMDIKMDMwOiAw
MDAwCjAzMTogNTAwMAowMzI6IDAwMDAKMDMzOiAwMDAwCjAzNDogMDAwMAowMzU6IDAwMDAK
MDM2OiAwMDAwCjAzNzogMDAwMAowMzg6IDAwMDAKMDM5OiAwMDAwCjAzYTogMDAwMAowM2I6
IDAwMDAKMDNjOiAwMDdiCjAzZDogMDAwMAowM2U6IDAwN2IKMDNmOiAwMDAwCjA0MDogMDAx
YwowNDE6IDAwMDAKMDQyOiAwMDFjCjA0MzogMDAwMAowNDQ6IDAwMDAKMDQ1OiA1MDAwCjA0
NjogMDAzOAowNDc6IDAwMzgKMDQ4OiBkODA2CjA0OTogMDAwMAowNGE6IDAwMDQKMDRiOiAw
MDAwCjA0YzogMDMxZgowNGQ6IDAwMDAKMDRlOiAwMDAwCjA0ZjogMDFmZgowNTA6IDAwMDAK
MDUxOiAwMDAwCjA1MjogMDFmZgowNTM6IGYwMDAKMDU0OiAwMDAwCjA1NTogMDAwMAowNTY6
IDAxMTEKMDU3OiAwMDY0CjA1ODogZWYwZQowNTk6IGYwZjAKMDVhOiBlZjBlCjA1YjogZjBm
MAowNWM6IGVmMGUKMDVkOiBmMGYwCjA1ZTogZjAwMAowNWY6IDAwMDAKMDYwOiAwMDAwCjA2
MTogODAwNgowNjI6IGUwMDAKMDYzOiBlOGRhCjA2NDogNGUyNAowNjU6IDBjMDIKMDY2OiAw
MDAwCjA2NzogMDAwMAowNjg6IDAwMDAKMDY5OiAwMDAwCjA2YTogMDAwMAowNmI6IDAwMDAK
MDZjOiAwYWFhCjA2ZDogMDAwMAowNmU6IDAwMDAKMDZmOiAwMDAwCjA3MDogODA4MwowNzE6
IDgwMDAKMDcyOiA4MDAwCjA3MzogMTc3MAowNzQ6IDNlMDAKMDc1OiAyNDA5CjA3NjogMDAw
YQowNzc6IDU4MDAKMDc4OiAwMDAwCjA3OTogMDEyMwowN2E6IDgwMDAKMDdiOiAwMDAwCjA3
YzogMDAwMAowN2Q6IDAwMDAKMDdlOiAwMDAwCjA3ZjogMDAwMAowODA6IDQwMDAKMDgxOiAw
ZjAzCjA4MjogMzAwMAowODM6IDA4MDgKMDg0OiAxMTExCjA4NTogMDAwMAowODY6IDAwMDgK
MDg3OiAwMDAwCjA4ODogMDAwMAowODk6IDAwMDAKMDhhOiAwMTIwCjA4YjogMDAwMAowOGM6
IDAwMDMKMDhkOiAwMDAwCjA4ZTogMDAwNAowOGY6IDExNDAKMDkwOiAwNjQ2CjA5MTogMGMw
NgowOTI6IDAwMDAKMDkzOiAwMTA4CjA5NDogMDIyMgowOTU6IDAwMDAKMDk2OiAwMDAwCjA5
NzogMDAwMAowOTg6IDAwMDAKMDk5OiAwMDAwCjA5YTogMjE4NAowOWI6IDAxMGEKMDljOiAw
YWVhCjA5ZDogMDAwYwowOWU6IDA0MDAKMDlmOiAwMDAwCjBhMDogYTBlOAowYTE6IDAwNTkK
MGEyOiAwMDAxCjBhMzogMDAwMAowYTQ6IDAwMDAKMGE1OiAwMDAwCjBhNjogMDAwMAowYTc6
IDAwMDAKMGE4OiAwMDAwCjBhOTogMDAwMAowYWE6IDAwMDAKMGFiOiAwMDAwCjBhYzogMDAw
MAowYWQ6IDAwMDAKMGFlOiA2MDAwCjBhZjogMDAwMAowYjA6IDYwMDAKMGIxOiAwMDAwCjBi
MjogMDAwMAowYjM6IDAwMWYKMGI0OiAwMjBjCjBiNTogMWYwMAowYjY6IDAwMDAKMGI3OiA0
MDAwCjBiODogMDAwMAowYjk6IDAwMDAKMGJhOiAwMDAwCjBiYjogMDAwMAowYmM6IDAwMDAK
MGJkOiAwMjAwCjBiZTogMDEwMAowYmY6IDExODAKMGMwOiA4MDAwCjBjMTogMDAwMAowYzI6
IDAwMDAKMGMzOiAyMDAwCjBjNDogMDAwMAowYzU6IDAwMDAKMGM2OiAwMDAwCjBjNzogMDAw
MAowYzg6IDAwMDAKMGM5OiAwMDAwCjBjYTogMDAwMAowY2I6IDAwMDAKMGNjOiAwMDAwCjBj
ZDogMDAwMAowY2U6IDAwMDAKMGNmOiAxODE0CjBkMDogMDY5MAowZDE6IDFjMTcKMGQyOiAw
MDAwCjBkMzogYjMyMAowZDQ6IDAwMDAKMGQ1OiAwMDAwCjBkNjogMDQwMAowZDc6IDAwMDAK
MGQ4OiAwMDAwCjBkOTogMDgwOQowZGE6IDAwMDAKMGRiOiAwMDAzCjBkYzogMDA0OQowZGQ6
IDAwMWIKMGRlOiAwMDAwCjBkZjogMDAwMAowZTA6IDAwMDAKMGUxOiAwMDAwCjBlMjogMDAw
MAowZTM6IDAwMDAKMGU0OiAwMDAwCjBlNTogMDAwMAowZTY6IDgwMDAKMGU3OiAwNzAwCjBl
ODogODAwMAowZTk6IDA3MDAKMGVhOiAwZjIwCjBlYjogMDAwMAowZWM6IGIzMDAKMGVkOiAw
MDAwCjBlZTogMDAwMAowZWY6IDAwMDAKMGYwOiAwMDFmCjBmMTogMDIwYwowZjI6IDFmMDAK
MGYzOiAwMDAwCjBmNDogNDAwMAowZjU6IDAwMDAKMGY2OiAwMDAwCjBmNzogMDAwMAowZjg6
IDAwMDAKMGY5OiAwMDAwCjBmYTogMjA2MQowZmI6IDQwNzAKMGZjOiAxODAwCjBmZDogMDAw
NAowZmU6IDEwZWMKMGZmOiA2MzA4CjEwMDogMDAwMAo=
--------------BA22AD8355A2445EA4E5EEA2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------BA22AD8355A2445EA4E5EEA2--

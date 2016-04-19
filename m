From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: mcasp: stream has more channels (2) than are
 enabled in mcasp (0)
Date: Tue, 19 Apr 2016 12:22:23 +0300
Message-ID: <5715F8CF.5000101@ti.com>
References: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
 <5714FEE5.5070002@ti.com>
 <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
 <5715D775.8030303@ti.com>
 <DFF31AA6-67AF-429A-B108-6544180038F2@latencyzero.com>
 <5715E008.9000500@ti.com>
 <8D9D43D4-9239-4630-AF46-4732C97DBC42@latencyzero.com>
 <5715EE36.60906@ti.com>
 <7817DD4F-6BD2-4EBE-8AA6-CBC595B1FBBF@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 49ED5265AB2
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 11:22:29 +0200 (CEST)
In-Reply-To: <7817DD4F-6BD2-4EBE-8AA6-CBC595B1FBBF@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/19/16 12:04, Rick Mann wrote:
> =

>> On Apr 19, 2016, at 01:37 , Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>
>> On 04/19/16 11:05, Rick Mann wrote:
>>>>> Yup, seems like it's 0:
>>>>>
>>>>> [   67.876673] davinci-mcasp 48038000.mcasp: Slots: 2,
>>>>> max_active_serializers: 1, active_serializers: 0, channels: 2,
>>>>> mcasp->num_serializer: 0 [   67.889362] davinci-mcasp 48038000.mcasp:=
 ASoC:
>>>>> can't set 48038000.mcasp hw params: -22
>>>>
>>>> How can it be?
>>>> can you take a look of the davinci_mcasp_set_pdata_from_of() function =
where
>>>> the serial-dir is set up? Do we get the of_serial_dir32? What is the s=
ize of
>>>> the array we got (val)?
>>>
>>> It seems to be 0:
>>>
>>> [    8.411990] davinci-mcasp 48038000.mcasp: davinci_mcasp_probe: enter
>>> [    8.453167] davinci-mcasp 48038000.mcasp: serial-dir: 0
>>> [    8.501317] davinci-mcasp 48038000.mcasp: invalid tdm slots: 0
>>> [    8.554405] davinci-mcasp 4803c000.mcasp: davinci_mcasp_probe: enter
>>> [    8.562924] davinci-mcasp 4803c000.mcasp: serial-dir: 0
>>> [    8.635250] davinci-mcasp 4803c000.mcasp: invalid tdm slots: 0
>>
>> Hrm, it seems that we can not read any of the parameters set by the DT
>> fragment for mcasp0, my guess is that the tx-num-evt and rx-num-evt is n=
ot
>> there either.
>>
>> from the full log: the mcasp is loaded earlier than you have patched the=
 DT
>> with the audio overlay.
>>
>> [    8.220175] davinci-mcasp 48038000.mcasp: davinci_mcasp_probe: enter
>> [    8.268496] davinci-mcasp 48038000.mcasp: invalid tdm slots: 0
>> [    8.323405] davinci-mcasp 4803c000.mcasp: davinci_mcasp_probe: enter
>> [    8.339936] davinci-mcasp 4803c000.mcasp: invalid tdm slots: 0
>> ...
>> [   33.432680] bone_capemgr bone_capemgr: part_number 'BB-BONE-AUDI-02',
>> version 'N/A'
>> [   33.432719] bone_capemgr bone_capemgr: slot #4: override
>> [   33.432736] bone_capemgr bone_capemgr: Using override eeprom data at =
slot 4
>> [   33.432752] bone_capemgr bone_capemgr: slot #4: 'Override Board
>> Name,00A0,Override Manuf,BB-BONE-AUDI-02'
>> [   33.451729] bone_capemgr bone_capemgr: slot #4: dtbo
>> 'BB-BONE-AUDI-02-00A0.dtbo' loaded; overlay id #0
>> [   33.462646] 2-0018 supply IOVDD not found, using dummy regulator
>> [   33.462722] 2-0018 supply DVDD not found, using dummy regulator
>> [   33.462779] 2-0018 supply AVDD not found, using dummy regulator
>> [   33.462822] 2-0018 supply DRVDD not found, using dummy regulator
>> [   33.484174] asoc-simple-card sound: tlv320aic3x-hifi <-> 48038000.mca=
sp
>> mapping ok
>> [   50.062097] davinci-mcasp 48038000.mcasp: Slots: 2, max_active_serial=
izers:
>> 1, active_serializers: 0, channels: 2
>> [   50.072596] davinci-mcasp 48038000.mcasp: stream has more channels (2=
) than
>> are enabled in mcasp (0)
>> [   50.072613] davinci-mcasp 48038000.mcasp: ASoC: can't set 48038000.mc=
asp hw
>> params: -22
>>
>> You can try to remove the mcasp module, do the DT fragment magic, reload=
 the
>> mcasp driver if it is not loaded automatically.
> =

> I don't quite understand how to do what you're suggesting here.

rmmod snd-soc-davinci-mcasp
...
DT patching
...
modprobe snd-soc-davinci-mcasp


>> But if you want to get it working properly you need to find the dts(i) f=
ile
>> which set the mcasp0 and mcasp1 nodes to status =3D "okay";
>> In upstream we do not do this, so it must come from the bone changes.
> =

> The DTB (prior to the BB-BONE-AUDI-02 overlay) starts with this file:
> =

> 	http://pastebin.com/5vVEdAKt
> =

> That file first includes the following files in this order, before adding
> its own entries (sorry about the line length):
> =

> https://github.com/RobertCNelson/dtb-rebuilder/blob/4.4.x/src/arm/am33xx.=
dtsi
> https://github.com/RobertCNelson/dtb-rebuilder/blob/4.4.x/src/arm/am33xx-=
es2.dtsi
> https://github.com/RobertCNelson/dtb-rebuilder/blob/4.4.x/src/arm/am335x-=
bone-common.dtsi
> https://github.com/RobertCNelson/dtb-rebuilder/blob/4.4.x/src/arm/am33xx-=
overlay-edma-fix.dtsi
> =

> The last of these files sets spi0, spi1, mcasp0, mcasp1 to "okay".

Interesting, why an include file called am33xx-overlay-edma-fix.dtsi would
enable spi and mcasp??? What it is fixing regarding to eDMA?

> If I understand what you're saying, this is causing the driver to load
> before other things have been set in the DT, and they should be moved
> to later, perhaps in the overlay? In fact, the overlay (which gets loaded
> after login) does also set the mcasp0 to "okay" (I think):

Yes, since the DT blob you are booting with have mcasp0/1 enabled, the driv=
er
will load using the boot DTB. You later patch the DTB, but the driver is
already loaded so it will have no effect to the driver.

> https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-B=
ONE-AUDI-02-00A0.dts#L72
> =

> I rebuilt the .dtb by commenting out the enabling of the macasp0/1 in
> that .dtsi, and now it seems to work! davinci_mcasp_probe is entered
> when I apply the overlay, and I get this logged:
> =

> [   35.868324] davinci-mcasp 48038000.mcasp: davinci_mcasp_probe: enter
> [   35.874741] davinci-mcasp 48038000.mcasp: serial-dir: 64
> [   43.469254] davinci-mcasp 48038000.mcasp: Slots: 2,
> 	max_active_serializers: 1, active_serializers: 1,
> 	channels: 2, mcasp->num_serializer: 16
> [   78.846314] davinci-mcasp 48038000.mcasp: Slots: 2,
> 	max_active_serializers: 1, active_serializers: 1,
> 	channels: 2, mcasp->num_serializer: 16

Great!

> By default, speaker-test only outputs to the left channel, and I get
> noise out that channel. If I invoke speaker-test -c 2, it claims to
> cycle between Front Left and Front Right, but there is only silence
> out the Front Right. This is probably due to issues in asound.state,
> right (I'd sure love some help getting that straightened out)?

I'll try to take a look at the speaker-test, it should work fine AFAIK.

> In any case, thank you. This seems to have advanced things considerably.
> I really appreciate your help and your patience.

No problem, I'm glad that I we sorted out.

-- =

P=E9ter

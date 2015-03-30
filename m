From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Realtek ALC662 issues - Intel DG41CN
Date: Tue, 31 Mar 2015 07:38:28 +0800
Message-ID: <CAN8cciZh2H8RUapa5vKisDqjKJ4dBc=abAHzYtoxTp77BYojrw@mail.gmail.com>
References: <CAN8ccibj5KZH2_R5Sh52Mm0DX5_OdniysqtbYu=RKNwxwo=KMg@mail.gmail.com>
 <CAN8cciZ2RFu3tNmhRd75BxyqQTVGd1fQC-RvxvgcaxGyg=5A9A@mail.gmail.com>
 <CAN8ccibO+bBpHgLGSZgOXBdsfSs41+rx8a+WOqUzoAiER6oKAw@mail.gmail.com>
 <CAN8cciY6j8iXiLkAkMhy2915MqR=RQXic5nXM4-cFRA_dW-Ngw@mail.gmail.com>
 <CAN8cciZAN0=DpTBO5UKLt4-Tve7ZDGy3NdkN-M62ZmqV+RMpfg@mail.gmail.com>
 <CAN8cciavrLGiDB_AYL4Z+hXFdtcaU1hWEkb7CY1i6g2s+9NoYQ@mail.gmail.com>
 <CAN8cciaBxSz_JY2i6xX21VUm4DGKfiu5Kv=9S60wQQh93Y-E6g@mail.gmail.com>
 <CAN8cciZDOLU9ufd2QpXkovYyCDbQtjoFJpDO0-3+94A_45Gxxg@mail.gmail.com>
 <CAAMTFD=N8GrHUAUon7YGFmZjkZGVeLS-EwzT8h6Lu1+JkxV6zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id EF61B2605EF
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 01:38:29 +0200 (CEST)
Received: by obvd1 with SMTP id d1so1590380obv.0
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 16:38:29 -0700 (PDT)
In-Reply-To: <CAAMTFD=N8GrHUAUon7YGFmZjkZGVeLS-EwzT8h6Lu1+JkxV6zg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: aditya kumar <aditya2507@gmail.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
>
> Well, I was just trying different modes. The last one was ASUS-MODE1.
Before this I tried the "laptop" mode and the "generic" one, both of which
did not work.
>
> What do you suggest?

You don't need any model since the pin defaults of your Intel DG41CN  are
correct unless you want to use CD audio in connector

!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x14 0x01014010
0x15 0x411111f0
0x16 0x411111f0
0x18 0x01a19840
0x19 0x02a19c50
0x1a 0x0181304f
0x1b 0x02214c20
0x1c 0x593301f0
0x1d 0x4004c601
0x1e 0x01441130

Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x593301f0: [N/A] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN

http://www.intel.com/support/motherboards/desktop/dg41cn/sb/CS-031343.htm

You should check the front audio panel of your computer chassis if jack
state of headphone is alway plugged

http://www.intel.com/support/motherboards/desktop/sb/cs-015851.htm

http://fedoraproject.org/wiki/How_to_debug_PulseAudio_problems

You have to provide pulseaudio verbose log

Default setting support multi channels but NO headphone playback volume
control

http://www.intel.com/support/motherboards/desktop/sb/CS-034198.htm

You can disable multi channels by using early patching and hint multi_io=0
to get back the headphone playback volume control

- multi_io (bool): try probing multi-I/O config (e.g. shared
  line-in/surround, mic/clfe jacks)

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio.txt

>>
>> > I have recently installed Fedora 21 Mate on my desktop which runs on
>> Intel DG41CN motherboard with Realtek ALC662 Audio. Prior to this I
>> was running Linux Mint. It was working all fine then, I may have fixed
>> it when I had installed Mint two years ago but I do not remember what
>> was done then. I also run Windows 7 on the same machine and there is
>> no problem with the audio.
>>
>> > So the problem I have is that there is no sound from my speakers. A
>> few times, there is a little "choppy" sound but thats it. When I put
>> the headphones on, the sound is there.
>>
>> > I must also mention that I also installed Ubuntu Mate on it and faced
>> the same problem.
>>
>> > I have run the Alsa diagnostic tool and the output is uploaded here:
>>
http://www.alsa-project.org/db/?f=1f6dd98e26f68e890258fa2fe5eb08ee343c5c13
>>
>> >I will really appreciate any help. I am stuck bad here..
>>
>> Any reason to use asus-mode1 ?
>>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_realtek.c?id=53c334add1e57bf96aec9b1fd927ff7746a7cb79
>>
>> Seem asus-mode1 is a broken pin fixup since node 0x21 is not any pin
complex
>>
>> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
>>
>> + [ALC662_FIXUP_ASUS_MODE1] = {
>> + .type = ALC_FIXUP_PINS,
>> + .v.pins = (const struct alc_pincfg[]) {
>> + { 0x14, 0x99130110 }, /* speaker */
>> + { 0x18, 0x01a19c20 }, /* mic */
>> + { 0x19, 0x99a3092f }, /* int-mic */
>> + { 0x21, 0x0121401f }, /* HP out */
>> + { }
>> + },
>> + .chained = true,
>> + .chain_id = ALC662_FIXUP_SKU_IGNORE
>> + },
>>
>> Line out is muted when headphone jack is plugged
>>
>> control.30 {
>> iface CARD
>> name 'Front Headphone Jack'
>> value true
>> comment {
>> access read
>> type BOOLEAN
>> count 1
>> }
>> }
>>
>> Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>>   Control: name="Speaker Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Control: name="Speaker Phantom Jack", index=0, device=0
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x80 0x80]
>>   Pincap 0x0001003c: IN OUT HP EAPD Detect
>>   EAPD 0x2: EAPD
>>   Pin Default 0x01014010: [Jack] Line Out at Ext Rear
>>     Conn = 1/8, Color = Green
>>     DefAssociation = 0x1, Sequence = 0x0
>>   Pin-ctls: 0x00:
>>   Unsolicited: tag=00, enabled=0
>>   Connection: 1
>>      0x0c
>
>

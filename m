From: "Viliam Kubis" <viliam.kubis@gmail.com>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
 *three* jacks on mainboard
Date: Fri, 09 Jul 2010 13:05:28 +0200
Message-ID: <op.vfko3ed8y9cctd@localhost>
References: <op.ve4vig0ny9cctd@localhost> <op.vff0au0jy9cctd@localhost>
	<4C35713E.1090709@ladisch.de>
	<AANLkTimikYh8rY5lEoXsAK53yEyVADsBtkJ2BwW7lSAK@mail.gmail.com>
	<op.vfkm5fn9y9cctd@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7973E24433
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 13:05:31 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 4so1038905bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Jul 2010 04:05:31 -0700 (PDT)
In-Reply-To: <op.vfkm5fn9y9cctd@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

It might be. It is important not to mix VT1708 and VT1708S. For VT1708S,
the following DACs are used in code:

  /* config dac list */
  switch (i) {
  case AUTO_SEQ_FRONT:
  	spec->multiout.dac_nids[i] = 0x10;
  	break;
  case AUTO_SEQ_CENLFE:
  	spec->multiout.dac_nids[i] = 0x24;
  	break;
  case AUTO_SEQ_SURROUND:
  	spec->multiout.dac_nids[i] = 0x11;
  	break;
  case AUTO_SEQ_SIDE:
  	spec->multiout.dac_nids[i] = 0x25;
  	break;
  }

  So 0x12 is not used for any of the surround outputs.

  On Fri, 09 Jul 2010 03:32:13 +0200, Raymond Yau
  <superquad.vortex2@gmail.com> wrote:

>> 2010/7/8 Clemens Ladisch <clemens@ladisch.de>
>>
>>> Viliam Kubis wrote:
>>> > Hello, for quite some time the "Smart 5.1" function in alsa is not
>>> working
>>> > properly when motherboard has only 3 audio jacks.
>>> >
>>> > speaker-test -c 4 -t wav -Dsurround40
>>> >
>>> > Channels count (4) not available for playbacks: Invalid argument
>>>
>>> Please try the patch below.
>>>
>>> (This function uses 0x12 and 0x13 as the NIDs for the center/LFE and
>>> side DACs.  Shouldn't these be 0x24 and 0x25, as per the datasheet?)
>>>
>>
>> Node 0x12 seem to be for digital out since it connected to node 0x20
>>
>> I guess we still lack the info about the retasking of pink and blue  
>> jack to
>> the surround output
>>
>>
>> Node 0x12 [Audio Output] wcaps 0x611: Stereo Digital
>>   Control: name="IEC958 Playback Con Mask", index=0, device=0
>>   Control: name="IEC958 Playback Pro Mask", index=0, device=0
>>   Control: name="IEC958 Playback Default", index=0, device=0
>>   Control: name="IEC958 Playback Switch", index=0, device=0
>>   Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
>>   Device: name="VT1708S Digital", type="SPDIF", device=1
>>   Converter: stream=5, channel=0
>>   Digital: Enabled
>>   Digital category: 0x0
>>   PCM:
>>     rates [0x5e0]: 44100 48000 88200 96000 192000
>>     bits [0xe]: 16 20 24
>>     formats [0x1]: PCM
>>   Power states:  D0 D1 D2 D3
>>   Power: setting=D0, actual=D0
>>
>>
>> Node 0x20 [Pin Complex] wcaps 0x400701: Stereo Digital
>>   Pincap 0x00000010: OUT
>>   Pin Default 0x074311f0: [Jack] SPDIF Out at Ext Rear Panel
>>     Conn = ATAPI, Color = Black
>>     DefAssociation = 0xf, Sequence = 0x0
>>     Misc = NO_PRESENCE
>>   Pin-ctls: 0x40: OUT
>>   Power states:  D0 D1 D2 D3
>>   Power: setting=D0, actual=D0
>>   Connection: 1
>>      0x12
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/

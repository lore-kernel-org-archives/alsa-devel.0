From: Laura Abbott <labbott@redhat.com>
Subject: Re: [REGRESSION] Headphones no longer working on
	MacPro6, 1 with 4.4
Date: Thu, 2 Jun 2016 14:20:24 -0700
Message-ID: <7223d50d-9c89-3510-085c-6757feece8a1@redhat.com>
References: <56E8611D.8090005@redhat.com> <s5h8u1jwmym.wl-tiwai@suse.de>
 <s5h60wnwmgt.wl-tiwai@suse.de>
 <f64ce31c-4465-0f4a-b7f4-4546fe3bc66a@redhat.com>
 <s5hwpmn3obr.wl-tiwai@suse.de> <s5hshxb3li2.wl-tiwai@suse.de>
 <dcfd89b1-fdae-d88a-8fb6-76857afe6d8d@redhat.com>
 <s5hr3cr1gw0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 79CCE26684F
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 23:20:29 +0200 (CEST)
Received: by mail-qk0-f170.google.com with SMTP id c140so39601283qke.2
 for <alsa-devel@alsa-project.org>; Thu, 02 Jun 2016 14:20:29 -0700 (PDT)
In-Reply-To: <s5hr3cr1gw0.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 05/24/2016 10:54 AM, Takashi Iwai wrote:
> On Tue, 24 May 2016 18:41:06 +0200,
> Laura Abbott wrote:
>>
>> Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>>   Control: name="Headphone Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Amp-Out caps: ofs=0x42, nsteps=0x42, stepsize=0x03, mute=1
>>   Amp-Out vals:  [0x42 0x42]
>>   Pincap 0x0000001c: OUT HP Detect
>>   Pin Default 0x002b4020: [Jack] HP Out at Ext N/A
>>     Conn = Comb, Color = Green
>>     DefAssociation = 0x2, Sequence = 0x0
>>   Pin-ctls: 0xc0: OUT HP
>>   Unsolicited: tag=01, enabled=1
>>   Power states:  D0 D3 EPSS
>>   Power: setting=D3, actual=D3
>
> This pin is powered off, because...
>
>> 	control.18 {
>> 		iface CARD
>> 		name 'Mic Jack'
>> 		value false
>> 		comment {
>> 			access read
>> 			type BOOLEAN
>> 			count 1
>> 		}
>> 	}
>> 	control.19 {
>> 		iface CARD
>> 		name 'Line Out Phantom Jack'
>> 		value true
>> 		comment {
>> 			access read
>> 			type BOOLEAN
>> 			count 1
>> 		}
>> 	}
>> 	control.20 {
>> 		iface CARD
>> 		name 'Headphone Jack'
>> 		value false
>
> The headphone jack isn't detected.
> Meanwhile,
>
>> 	control.22 {
>> 		iface CARD
>> 		name 'SPDIF Jack'
>> 		value true
>
> SPDIF jack is detected.  This might confuse PA.
>
> In anyway, the alsa-info.sh output you gave doesn't help for analyzing
> the issue while the headphone is plugged.  It is off when unplugged.
> It's the designed behavior.
>
> So, please give the information during the headphone is plugged (but
> still doesn't produce the sound from the headphone).
>
>
> Takashi
>

According to the reporter:

"Actually, that information was when the headphones were plugged in,
but the detection is incorrect.  (Linux thinks the headphones are
unplugged, when they are actually plugged in."

Thanks,
Laura

From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]:   errors when
 installing au8820 modules
Date: Thu, 09 Jun 2005 16:54:00 +0800
Message-ID: <42A803A8.6050002@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de> <42A5D3C8.1030903@mail.ru> <42A6E5BE.4030003@netvigator.com> <42A73305.9000000@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A73305.9000000@mail.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org



Igor Kovalenko wrote:
> Raymond wrote:
> 
>>
>>>Well, I've not stated the problem clearly enough.
>>>Once set, volume stays as it should. The problem is that
>>>PCM volume is:
>>>1% - at lowest audible level
>>>25% - at about 50% audible level
>>>49% - at about max audible level
>>>51% - at lowest audible level
>>>75% - at about 50% audible level
>>>99% - at about max audible level
>>>- that is what I described as low-high-low-high.
>>>On the other hand, Master volume behaves as expected.
>>
>>
>>
>>What is the value of comment.range of 'PCM Playback Volume' in
>>/etc/asound.state for your STAC9704 (au8820) ?
>>
>>
>>According to 9704SPEC.pdf, it should be '0-31' ( 5 bits ) for STAC9704
>>PCM Out volume.
>>
> 
> 
>         control.21 {
>                 comment.access 'read write'
>                 comment.type INTEGER
>                 comment.count 2
>                 comment.range '0 - 63'
>                 iface MIXER
>                 name 'PCM Playback Volume'
>                 value.0 21
>                 value.1 21
>         }
> 
> Do you mean AC97 is incorrectly reporting 0...63 range?
> 

Refer to notes in page 25 of 9704SPEC.pdf

1) All registers not shown and bits contain an X are resserved.
2) Any reserved bits, marked X, can be written to but are don't care
upon read back.

Bits 14,13,7,6,5 of PCM Out Volume of STAC9704 are marked X.


> $ cat /proc/asound/au8820/codec97#0/ac97#0-0+regs
> 0:00 = 6940
> 0:02 = 1414
> 0:04 = 8000
> 0:06 = 801f
> 0:08 = ffff
> 0:0a = 9f1f
> 0:0c = 801f
> 0:0e = 841f
> 0:10 = 9f1f
> 0:12 = 1414
> 0:14 = 9f1f
> 0:16 = 9f1f
> 0:18 = 0f0f
> 0:1a = 1010
> 0:1c = 0000
> 0:1e = 0000
> 0:20 = 0200
> 0:22 = 0402
> 0:24 = 0000
> 0:26 = 800f
> 0:28 = ffff                <---- ext_id
> 0:2a = ffff
> 0:2c = ffff
> 0:2e = ffff
> 0:30 = ffff
> 0:32 = ffff
> 0:34 = ffff
> 0:36 = ffff
> 0:38 = ffff
> 0:3a = ffff
> 0:3c = 0000
> 0:3e = 0000
> 0:40 = 0000
> 0:42 = 0000
> 0:44 = 0000
> 0:46 = 0000
> 0:48 = 0000
> 0:4a = 0000
> 0:4c = 0000
> 0:4e = 0000
> 0:50 = 0000
> 0:52 = 0000
> 0:54 = 0000
> 0:56 = 0000
> 0:58 = 0000
> 0:5a = 0000
> 0:5c = 0000
> 0:5e = 0000
> 0:60 = 0000
> 0:62 = 0000
> 0:64 = 0000
> 0:66 = 0000
> 0:68 = 0000
> 0:6a = 0000
> 0:6c = 0000
> 0:6e = 0000
> 0:70 = 0000
> 0:72 = 0000
> 0:74 = 0000
> 0:76 = 0000
> 0:78 = 0000
> 0:7a = 0000
> 0:7c = 8384
> 0:7e = 7605

> Result is:
> vortex codec=ffff8100286df600 ext_id=00000000 isquad=00000000

> I conquer isquad is false.


It is quite strange that vortex->isquad is false

Does it mean that ac97 registers are cached ?

> 
>>or check the values *low_max and *high_max return by
>>check_volume_resolution()
>>
>>http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/ac97_codec.c?r1=1.163&r2=1.164
>>
>>
>>

Do this problem also exist in ALSA 1.0.8 ?







-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

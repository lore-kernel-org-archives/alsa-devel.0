From: olig9@gmx.de
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Mon, 03 May 2004 09:53:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4095FA8F.6000307@gmx.de>
References: <200404171945.35824.bero@arklinux.org> <s5hd663q6fs.wl@alsa2.suse.de> <20040421120454.GC2295@schottelius.org> <s5h4qrdpkm2.wl@alsa2.suse.de> <20040421220031.GK2295@schottelius.org> <20040502101851.GB515@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zosma.hb.orthogon.de (br2fwl01.orthogon.de [195.90.5.186])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA12103
	for <alsa-devel@alsa-project.org>; Mon, 3 May 2004 09:54:19 +0200
In-Reply-To: <20040502101851.GB515@schottelius.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nico Schottelius <nico-linux-alsa@schottelius.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I have the same problem and haven't found a solution (yet).

Nico Schottelius wrote:
> Just wanted to ask whether someone read my mail and if anyone knows
> if there is the possibility to adjust sound volume or not.
> 
> Thanks for any answer/hint,
> 
> Nico
> 
> Nico Schottelius [Thu, Apr 22, 2004 at 12:00:31AM +0200]:
> 
>>Takashi Iwai [Wed, Apr 21, 2004 at 02:43:17PM +0200]:
>>
>>>>>there is no PCM volume on CM9739.  it has only PCM mute switch.
>>>>>you can mute on/off via 'M' key of alsamixer.
>>>>
>>>>Does that mean I have _no_ possibility to adjust the volume?
>>>
>>>right.  it doesn't support the PCM volume but you can basically adjust
>>>the master volume.
>>
>>This doesn't affect the sound volume, tested it again some seconds ago.
>>Some weeks ago I even tried it with _every_ switch available.
>>I just can switch it on or off, but no volume adjusting.
>>
>>And using master doesn't do anything at all.
>>
>>Do you have any hint for me? Perhaps I am doing something wrong?
>>

I got the same results, even when I set the soundchip registers 
"manually". I didn't find any register at all that changes the volume 
(apart from muting, that is).
CMedia's tech documents say that there is no PCM volume register (only 
PCM muting), but it also says that there _is_ a Master volume register. 
But changing this register has no effect. I guess it's a hardware bug then.
Btw. CMedia's OSS driver does volume changing by calculating it inside 
the driver. Looks like they know the problem quite well :/

Until there's a CMI9739 driver for ALSA or a software volume changing 
plugin, this chip isn't very useful...

Oliver


>>
>>>>How do I find out if I got the CM9739? This is what lspci shows:
>>>
>>>you can see it in /proc/asound/card0/codec97#0/ac97#0-0.
>>
>>For you information, perhaps you need it:
>>
>>0-0/0: C-Media Electronics CMI9739
>>
>>Capabilities     :
>>DAC resolution   : 16-bit
>>ADC resolution   : 16-bit
>>3D enhancement   : No 3D Stereo Enhancement
>>
>>Current setup
>>Mic gain         : +0dB [+0dB]
>>POP path         : pre 3D
>>Sim. stereo      : off
>>3D enhancement   : off
>>Loudness         : off
>>Mono output      : MIX
>>Mic select       : Mic1
>>ADC/DAC loopback : off
>>Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA
>>Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF
>>SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
>>
>>Have a nice day,
>>
>>Nico
>>
>>-- 
>>Keep it simple & stupid, use what's available.
>>pgp: 8D0E E27A          | Nico Schottelius
>>http://nerd-hosting.net | http://linux.schottelius.org
> 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

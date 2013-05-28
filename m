From: Stefano Panella <stefano.panella@citrix.com>
Subject: Re: Problem opening default device in haswell system
 using	aplay
Date: Tue, 28 May 2013 10:26:09 +0100
Message-ID: <51A47831.20003@citrix.com>
References: <519CE8EA.3010303@citrix.com> <s5hfvx8sxx8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 317502608D8
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 11:21:43 +0200 (CEST)
In-Reply-To: <s5hfvx8sxx8.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/27/2013 08:07 AM, Takashi Iwai wrote:
> At Wed, 22 May 2013 16:48:58 +0100,
> Stefano Panella wrote:
>> Hi everyone,
>>
>> sorry if this email has been sent twice... ( I sent it once before subscribing)
>>
>> I am working on some haswell systems running Ubuntu 12.04 and I have a problem if I run aplay -D sysdefault.
>>
>> when I do:
>>
>> cat /proc/asound/pcm
>>
>> I get:
>>
>> 00-03: HDMI 0 : HDMI 0 : playback 1
>> 00-07: HDMI 1 : HDMI 1 : playback 1
>> 00-08: HDMI 2 : HDMI 2 : playback 1
>> 01-00: ALC662 rev3 Analog : ALC662 rev3 Analog : playback 1 : capture 1
>> 01-02: ALC662 rev3 Analog : ALC662 rev3 Analog : capture 1
>>
>> If I do:
>>
>> aplay -L | grep sysdefault
>>
>> I get:
>>
>> sysdefault:CARD=PCH
>>
>> where PCH is card number 1 (id = 1)
>>
>> on most of my systems (non haswell laptops) the default card is number 0
>>
>> If I run
>>
>> aplay -D sysdefault
>>
>> I get:
>>
>> ALSA lib pcm_dmix.c:1018:(snd_pcm_dmix_open) unable to open slave
>> aplay: main:682: audio open error: No such file or directory
> It's because the card 0 contains only HDMI.  The sysdefault in
> HDA-Intel.conf is configured for the analog I/O.
Thanks for answering, what I do not get is what the default 
configuration is on a freshly installed system (no custom configurations):

- for example, can I assume hw:0,0 is always there and is the default? 
(apparently not on these haswell machine)
- if I run aplay -D sysdefault is it expected to work?
- is there any ALSA_CARD variable configured somewhere or is it just 
supposed to be 0?
- how do I know what is it the default card/pcm?

The reasons I am asking these questions is I need to write some SW which 
will be able to open the default analog playback device and on haswell 
system I did not find any way to do that apart from using:

aplay -L | grep sysdefault

which will return <CARD> = PCH or Intel or MID etc.. and than I open 
hw:<CARD>,0 from the C code.

I would like to understand if I can poerform some more tests to 
understand if this is a genuine problem on haswell systems or if I am 
just making some wrong assumptions or incorrect use of the cmd_line/API.

Thanks again for helping me on this.
>
> Takashi

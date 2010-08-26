From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Thu, 26 Aug 2010 08:56:12 +0200
Message-ID: <4C76100C.3040205@canonical.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>	<4C75A7D9.1030604@canonical.com>
	<AANLkTinE8sjRWWsHYJYq1w_rLJu9Y91J4gs7k-Q_M3j-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 40A0E1037F2
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 08:56:14 +0200 (CEST)
In-Reply-To: <AANLkTinE8sjRWWsHYJYq1w_rLJu9Y91J4gs7k-Q_M3j-@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Keith Chew <keith.chew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010-08-26 08:35, Keith Chew skrev:
>> My first approach to that problem would be to try to tweak
>> user_pin_configs, assuming that the generic parser (model=auto) is used.
>> See sections 4.3 and 4.4 on this document for how to do that:
>>
>> http://mirror.leaseweb.com/kernel/people/tiwai/docs/HD-Audio.html
>>
>> That way you won't have to update the kernel code at all.
>>
>> To figure out the values of user_pin_configs, you'll need to know the
>> pin widget NIDs (see your /proc/asound/card*/codec* file for that) and
>> pin values (see official Intel HDA documentation, or read hda_proc.c).
>>
> Hi David
> 
> Thank you very much for your guidance, I have gotten a bit further,
> and this is very exciting!
> 
> After reading HD-Audio.html, I used the hda-analyzer to configure NIDs
> 0x14, 0x19 and 0x1b to become outputs, and when I execute:
> 
> speaker-test -Dplug:surround51 -c6
> 
> I can hear sound on all 3 jacks, but only for Front left/right
> channels. In other words, all 3 jacks are being treated as Front. To
> confirm this, in alsamixer, the mute on Front (0x14) does mute all 3
> jacks.
> 
> I guess I am missing the relationship between alsamixer and the codec.
> How can I get aplay and speaker-test (with plug:surround51) to map to
> Front/Mic2/Line2, now that I have configured them as outputs?

I'm not 100% sure, but I think that HDA-analyzer approach will probably
not work here as you'll need a complete codec reconfig. After the
reconfig, you shouldn't even have a "Line in" in alsamixer, instead you
should have volume controls for "rear" and "center/lfe".
Also make sure that the pin configs are configured as "front", "rear",
and "center/lfe".


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

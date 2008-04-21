From: Andy Green <andy@warmcat.com>
Subject: Re: Acer Aspire 8920g / snd-hda-intel / ALC889
Date: Mon, 21 Apr 2008 19:25:42 +0100
Message-ID: <480CDC26.3010506@warmcat.com>
References: <480C8260.70501@warmcat.com> <s5hr6czb3po.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.mog.warmcat.com (purr.warmcat.com [87.106.142.209])
	by alsa0.perex.cz (Postfix) with ESMTP id D1CC524470
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 20:25:53 +0200 (CEST)
In-Reply-To: <s5hr6czb3po.wl%tiwai@suse.de>
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

Somebody in the thread at some point said:

>> and dmesg says that model=acer was selected reasonably enough.
> 
> First of all, do you need to pass model=acer at all?

No, the auto thing detects it as acer and reports in dmesg that it has 
selected acer.  Currently I forced it anyway in /etc/modprobe.conf to 
acer as part of running around trying everything I could imagine.

>> 1) It is confused if it has ALC889 or ALC883 in there
>>
>> $ grep ALC /proc/asound/* -R
>> /proc/asound/card0/codec#0:Codec: Realtek ALC889    <==== 889
>> /proc/asound/card0/pcm2c/sub0/info:id: ALC883 Analog  <=== 883...
> 
> This doesn't matter.  ALC889 is compatible with ALC883, and the driver
> uses the same string inside.

OK.

> alsa-info.sh (found in www.alsa-project.org debug page) would give
> more detailed debug information.  Please show that output.

It is here:

http://pastebin.ca/992253

Thanks for taking an interest.

-Ady

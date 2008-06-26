From: walt <w41ter@gmail.com>
Subject: Re: ECS K7VTA3:  Mixer channels reversed
Date: Wed, 25 Jun 2008 17:08:02 -0700
Message-ID: <4862DDE2.5020603@gmail.com>
References: <g3paoc$41v$1@ger.gmane.org> <s5hzlp97bvq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 69F8C24513
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 02:07:25 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBf1J-00068b-GV
	for alsa-devel@alsa-project.org; Thu, 26 Jun 2008 00:07:25 +0000
Received: from adsl-69-234-205-239.dsl.irvnca.pacbell.net ([69.234.205.239])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 00:07:25 +0000
Received: from w41ter by adsl-69-234-205-239.dsl.irvnca.pacbell.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 00:07:25 +0000
In-Reply-To: <s5hzlp97bvq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 23 Jun 2008 16:15:05 -0700,
> walt wrote:
>> Hi list,
>>
>> I just replaced a mobo with an ECS K7VTA3 and I find that the
>> Headphones control is now controlling the master channel and the
>> Master control does nothing.
>>
>> I tried 'modprobe via82xx ac97_quirk=hp_only' but that makes the
>> audio device unusable (although alsamixer still seems happy to set
>> the individual channels).
>
> You mean that you don't hear any outputs?  Which I/O (HP out,
> line-out, etc) are you testing?

Sorry, I forgot to mention that RealAudio player complains that it
"cannot open the audio device. Another application may be using it."

However, I just tried mplayer, which *does* work normally and the
master channel also works properly again.

So it seems that hp_only works, but only partly.  Any idea why
RealPlayer is complaining?


>>   Any other quirks I should try?
>
> Usually hp_only is the right choice.  Check alsa-info.sh script
> outputs for both cases with and without ac97_quirk option.

Most of that info means nothing to me, so all I can do is point you
the results, sorry:

without hp_only
http://pastebin.ca/1056077

and with hp_only:
http://pastebin.ca/1056088

From: walt <w41ter@gmail.com>
Subject: Re: ECS K7VTA3:  Mixer channels reversed [PATCH]
Date: Thu, 26 Jun 2008 05:47:18 -0700
Message-ID: <g40338$d49$1@ger.gmane.org>
References: <g3paoc$41v$1@ger.gmane.org>
	<s5hzlp97bvq.wl%tiwai@suse.de>	<4862DDE2.5020603@gmail.com>
	<s5hskv04uee.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id DDF00245C8
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 14:46:47 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBqs4-0000J3-Jb
	for alsa-devel@alsa-project.org; Thu, 26 Jun 2008 12:46:40 +0000
Received: from adsl-69-234-188-58.dsl.irvnca.pacbell.net ([69.234.188.58])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 12:46:40 +0000
Received: from w41ter by adsl-69-234-188-58.dsl.irvnca.pacbell.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 12:46:40 +0000
In-Reply-To: <s5hskv04uee.wl%tiwai@suse.de>
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
> At Wed, 25 Jun 2008 17:08:02 -0700,
> walt wrote:
>> Takashi Iwai wrote:
>>> At Mon, 23 Jun 2008 16:15:05 -0700,
>>> walt wrote:
>>>> Hi list,
>>>>
>>>> I just replaced a mobo with an ECS K7VTA3 and I find that the
>>>> Headphones control is now controlling the master channel and the
>>>> Master control does nothing.
>>>>
>>>> I tried 'modprobe via82xx ac97_quirk=hp_only' but that makes the
>>>> audio device unusable (although alsamixer still seems happy to set
>>>> the individual channels).
>>> You mean that you don't hear any outputs?  Which I/O (HP out,
>>> line-out, etc) are you testing?
>> Sorry, I forgot to mention that RealAudio player complains that it
>> "cannot open the audio device. Another application may be using it."
>>
>> However, I just tried mplayer, which *does* work normally and the
>> master channel also works properly again.
>>
>> So it seems that hp_only works, but only partly.  Any idea why
>> RealPlayer is complaining?
>
> Hard to believe that the error of RealPlayer comes from ac97_quirk
> option.  It's likely a coincidence.  Please double-check.

Okay, this patch seems to make everything work correctly, but lspci
still reports "unknown device" in spite of it.

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index b585cc3..aa5c2e0 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1746,6 +1746,12 @@ static struct ac97_quirk ac97_quirks[] = {
         },
         {
                 .subvendor = 0x1019,
+               .subdevice = 0x1841,
+               .name = "ECS K7VTA3",
+               .type = AC97_TUNE_HP_ONLY
+       },
+       {
+               .subvendor = 0x1019,
                 .subdevice = 0x0a81,
                 .name = "ECS K7VTA3",
                 .type = AC97_TUNE_HP_ONLY

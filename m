From: sh_okada@d4.dion.ne.jp
Subject: Re: New alsa lowlevel driver for the SE-200PCI and
 SE-90PCI
Date: Fri, 26 Oct 2007 22:44:58 +0900
Message-ID: <D382B3A.14D0.sh_okada@d4.dion.ne.jp>
References: <s5hzly8dgtz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dsmtp8.dion.ne.jp (mail.dion.ne.jp [211.5.1.96])
	by alsa0.perex.cz (Postfix) with ESMTP id 6000624546
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 15:44:59 +0200 (CEST)
Received: from d4.dion.ne.jp (O008152.ppp.dion.ne.jp [211.134.8.152])
	by dsmtp8.dion.ne.jp (8.11.7p3+Sun/8.11.7/050303) with SMTP id
	l9QDijN07791
	for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2007 22:44:45 +0900 (JST)
In-reply-to: Your message of "Wed, 24 Oct 2007 11:04:08 JST."
	<s5hzly8dgtz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, sh_okada@d4.dion.ne.jp
List-Id: alsa-devel@alsa-project.org

>At Tue, 16 Oct 2007 21:32:53 +0900,
>sh_okada@d4.dion.ne.jp wrote:
>> 
>> Hi
>> 
>> A new one put my HP
>> http://www.d4.dion.ne.jp/~sh_okada/misc/alsa-SE200PCI.patch-4.tgz
>> 
>> >Then let's rename it to another one, such as, 'AGC Capture Mode'.
>> >Also, a value like "ON(xxx)" look ugly.  I'd suggest items like 'Off',
>> >'Type1', 'Type2'.
>> 
>> It changed from "AGC Capture Switch" to "AGC Capture Mode"
>> and changed the mode name "ON(type=1)" to "LimiterMode"
>> and added a new mode "ALCMode".
>> 
>> As a result the mode is "Off", "LimiterMode", "ALCMode".
>
>FYI, the patch is now merged to ALSA HG tree (with slight
>modifications and fixes).  Please check whether it works for you.

All analog outputs, all analog inputs with selector and the AFL path switch
works well.

But though it forgot to say, because I do not have a digital device,
I doesn't confirm it.
However, it is said on HP that it works by
modprobe snd-ice1724 model=prodigy71
So I selected prodigy71's mode, and I think that it moves perhaps.

Thanks

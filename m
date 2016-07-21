From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Could I put a patch to 4.7 final?
Date: Fri, 22 Jul 2016 05:48:43 +0900
Message-ID: <5791352B.70307@sakamocchi.jp>
References: <57903D8A.5010106@sakamocchi.jp> <s5hzipbefp9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 557AE2666F9
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2016 22:48:51 +0200 (CEST)
In-Reply-To: <s5hzipbefp9.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, saobannion@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Jul 21 2016 14:13, Takashi Iwai wrote:
> On Thu, 21 Jul 2016 05:12:10 +0200,
> Takashi Sakamoto wrote:
>>
>> Iwai-san,
>>
>> Yesterday, I found an user of additional OXFW device, and we're under
>> testing a patch to support it.
>> https://sourceforge.net/p/ffado/mailman/message/35229260/
>>
>> I need one day more to post corresponding patch. The prototype is:
>> https://github.com/takaswie/snd-firewire-improve/commit/690a2419fc95766826c8d2c0964f6f099f9d65bd
>>
>> This week is final week for 4.7, but do I have a rest to add the patch
>> to it in time of your work for mainline?
> 
> If the patch is a regression fix or a stable fix, I can queue it for
> 4.7-final.  Others will go to 4.8-rc1.

We have similar issue before.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-January/103167.html

I think this is a case of the 'simple addition of device IDs'.

> I'm going to send a pull request tomorrow, so please submit in time.

OK.

Probably, the model has unique quirk to lose quality of PCM substream of
current ALSA OXFW driver and I predict the patch is not in time of your
work.

Anyway, today, I wait for the tester's report.


Thanks

Takashi Sakamoto

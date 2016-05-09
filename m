From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: dice: add support for M-Audio
 Profire 610 and perhaps 2626
Date: Mon, 9 May 2016 10:35:30 +0900
Message-ID: <572FE962.3040705@sakamocchi.jp>
References: <1462021606-13683-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hk2j4syb8.wl-tiwai@suse.de> <572F3D45.70104@sakamocchi.jp>
 <s5hzis0r1d2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F85326148F
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 03:35:33 +0200 (CEST)
In-Reply-To: <s5hzis0r1d2.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On May 9 2016 00:55, Takashi Iwai wrote:
> On Sun, 08 May 2016 15:21:09 +0200,
> Takashi Sakamoto wrote:
>>
>> Iwai-san,
>>
>> Welcome back, and thanks for applying this patch.
>>
>> I have more patches for 4.7. I already posted RFCs for them ([1], [2],
>> and a few), but postpone till your back. If Linus doesn't open next
>> merge window tomorrow, I'd like to post them, as long as you don't mind.
>> Is it OK?
>
> Sure, no problem, feel free to send more patches now.

OK. Now the 4.6-rc7 was released and we have more one week for 
development of Linux 4.7. I'll start to post my patches in this night 
(approx. 10 hours later, when I'm back to home).

>> Of cource, I realize that you will avoid to add changes just before
>> merge window. However, these newly introduced changes are for
>> tracepoints and simplification of packet streaming engine. The former
>> helps our work and the latter may reduce maintaining effort and improve
>> performance of the engine. I think they're worth to be considered for
>> merging.
>>
>> And I'd like to report the status of ALSA Dice driver. As I
>> described[3], it has been including bugs. The bugs exist since the
>> driver was merged. I go for investigating but have never found solutions
>> for it. The driver in Linux 4.6 will be shipped with the bugs.
>
> OK, if you find the culprit (and hopefully the fix), don't forget to
> tag with Cc to stable and Fixes tag.

If the patchset were enough small, it would be a nice for stable. 
However, in my opinion, it will include much changes to isochronous 
packet stream engine (sound/firewire/amdtp-stream.{c,h}), similarily of 
changes between 4.3 and 4.4. I think it very likely to cause merge 
conflict and impossible to port backward.


Regards

Takashi Sakamoto

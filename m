From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/3] bebob: Fix a missing to unlock mutex
 in error handling case
Date: Wed, 23 Jul 2014 00:23:05 +0900
Message-ID: <53CE81D9.4090305@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
 <1406038263-18558-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hmwc1lb9x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 9258C265545
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 17:23:12 +0200 (CEST)
In-Reply-To: <s5hmwc1lb9x.wl%tiwai@suse.de>
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

(Jul 22 2014 23:26), Takashi Iwai wrote:
> BTW, at the next time, put "v2" or such in the subject line so that
> people can distinguish the new patch series from the previous ones.
> You can use --subject-prefix option for git-format-patch or else.

In this time I newly revised these patches, thus there was a lack of
patches in previous series. I thought it better to post them as a new
series.

But I should have added v2 for the series as you indicate.

> Preferably, write the changes since the previous revision, too
> (usually below the --- line, so that it's not merged into the git
>  changelog; some people like to have them in the final commit,
>  though.)

OK.

> Last but not least, don't forget to put a proper subject prefix.
> For ALSA codes, we put "ALSA:" prefix in the subject.  Study git
> changelogs.

Next time, I remember to add the prefix. In my repository, I use the
prefix to distinguish my local patches from upstream patches. But I
should change this workflow.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

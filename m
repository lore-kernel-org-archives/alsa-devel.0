From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v4] ASoC: rt5645: Check if codec is
 initialized in workqueue handler
Date: Fri, 17 Jul 2015 20:07:50 +0800
Message-ID: <CANMq1KDCa3FsK2xkwYAx_Yx9tn4PCiDRU+SboqMAMb1doqFhtA@mail.gmail.com>
References: <1437100617-37845-1-git-send-email-drinkcat@chromium.org>
 <20150717111208.GK11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id B7A4C2606CB
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 14:07:51 +0200 (CEST)
Received: by oihq81 with SMTP id q81so69286843oih.2
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 05:07:50 -0700 (PDT)
In-Reply-To: <20150717111208.GK11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2015 at 7:12 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 17, 2015 at 10:36:57AM +0800, Nicolas Boichat wrote:
>
>> This replaces 3c2234569cfff83718792f810a9bb855b78c2473, and applies on top of
>> Linux 4.2-rc1, so that this patch can be applied in its own branch, without
>> triggering a compile warning.
>
> Please provide human readable descriptions of commits so your mails are
> directly readable.

Noted, sorry about that.

3c2234569cfff83718792f810a9bb855b78c2473 is "ASoC: rt5645: Check if
codec is initialized in workqueue handler" (same commit title), which
you applied yesterday on fix/rt5645, and, as it stands, triggers a
compile-time warning as it depends on "ASoC: rt5645: Remove
irq_jack_detection function", which you applied on topic/rt5645 3 days
ago.

Note that, after you replace the commit in fix/rt5645, and merge
topic/rt5645, we'll need to remove the return value, as the hunk above
will have moved from irq_jack_detection to rt5645_jack_detect_work,
which returns void (this probably won't appear as an obvious merge
conflict...).

I'll provide a patch for that, if you are ok with replacing the commit
above (otherwise we'll need 2 short patches: one in fix/rt5645, and
revert it in topic/rt5645).

Thanks!

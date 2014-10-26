From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Uninitialized id returned by
	saffirepro_both_clk_src_get.
Date: Sun, 26 Oct 2014 18:29:46 +0900
Message-ID: <544CBF0A.9030201@sakamocchi.jp>
References: <1414237241-18984-1-git-send-email-vogelchr@vogel.cx>
 <544C49F7.8010300@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id C320326054F
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 10:29:52 +0100 (CET)
In-Reply-To: <544C49F7.8010300@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Vogel <vogelchr@vogel.cx>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Oct 26 2014 10:10, Takashi Sakamoto wrote:
> I reviewed your patch and realized that your patch cannot be applied to
> current tree. The patch seems not to be based on the latest changes:
> 
> [alsa-devel] [PATCH 07/43] ALSA: bebob: More constify text arrays
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082580.html
> 
> [alsa-devel] [PATCH 08/43] ALSA: bebob: Use snd_ctl_enum_info()
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082574.html

Oops. I used wrong branch (for-next) to apply this patch... This patch
is correct and appropriate.

I've just given some advices to you, so it's your work and I hope to add
Reviewed-by instead of Signed-off-by:

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Iwai-san,
Would you please apply this patch to for-linus branch and C.C.ed to
Linux stable branch, as a bug fix?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

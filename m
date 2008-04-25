From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH 1/3] asoc tlv320aic3x: revisit clock setup
Date: Fri, 25 Apr 2008 12:55:23 +0300
Message-ID: <bd7b27490804250255j5ed1ea14l1df4b3c1d91e1b7c@mail.gmail.com>
References: <20080425091707.GA18452@buzzloop.caiaq.de>
	<s5hlk32l1v7.wl%tiwai@suse.de>
	<20080425093657.GC18558@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id DCBBE24777
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 11:55:24 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so983680ana.80
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 02:55:24 -0700 (PDT)
In-Reply-To: <20080425093657.GC18558@buzzloop.caiaq.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/4/25 Daniel Mack <daniel@caiaq.org>:

> On Fri, Apr 25, 2008 at 11:28:44AM +0200, Takashi Iwai wrote:
> > > +#define ABS(x) (((x) >= 0) ? (x) : -(x))
> >
> > We already have a standard abs() in linux/kernel.h.
>
> Ok, thanks for mentioning that. See the patch below. Also bumped the
> version number here.
>
> Did you forgot to take into account doubled fsref below (from the first
version) when calculating codec_clk because now it is doubled earlier?

+    codec_clk = (2048 * fsref) / (aic3x->sysclk / 1000);
+
+    if (params_rate(params) >= 88200)
+        fsref *= 2;

There should not be dead code like

+        /* printk(KERN_INFO "%s(): bypassing PLL with Q=%d\n",
+            __func__, pll_q); */

I forgot to mention in my previous comment that KERN_DEBUG would be better
here or just remove the printk.


Jarkko

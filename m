From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH 1/3] asoc tlv320aic3x: revisit clock setup
Date: Fri, 25 Apr 2008 14:30:29 +0300
Message-ID: <bd7b27490804250430p21446f54t42dbcff07ae1579@mail.gmail.com>
References: <20080425091707.GA18452@buzzloop.caiaq.de>
	<s5hlk32l1v7.wl%tiwai@suse.de>
	<20080425093657.GC18558@buzzloop.caiaq.de>
	<bd7b27490804250255j5ed1ea14l1df4b3c1d91e1b7c@mail.gmail.com>
	<20080425101801.GE18558@buzzloop.caiaq.de>
	<bd7b27490804250340y629cc7e6s61b056dc6505f55a@mail.gmail.com>
	<20080425104731.GF18558@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id F3D152470A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 13:30:30 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so991983ana.80
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 04:30:29 -0700 (PDT)
In-Reply-To: <20080425104731.GF18558@buzzloop.caiaq.de>
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

On Fri, Apr 25, 2008 at 1:47 PM, Daniel Mack <daniel@caiaq.org> wrote:

> On Fri, Apr 25, 2008 at 01:40:42PM +0300, Jarkko Nikula wrote:
> > > Doesn't work for 64000 kHz since 48000 * 10 / 64000 = 7.5 and later
> > calculations => 7*2 / 5 - 2 = 2 - 2 but this might to work:
>
> Good catch, thanks.
>

This dead code below was there but otherwise I think this is good now.

+        /* printk(KERN_INFO "%s(): bypassing PLL with Q=%d\n",
+            __func__, pll_q); */



Jarkko

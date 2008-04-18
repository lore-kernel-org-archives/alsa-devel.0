From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL in
	some cases
Date: Fri, 18 Apr 2008 10:59:08 +0300
Message-ID: <bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.241])
	by alsa0.perex.cz (Postfix) with ESMTP id BB12D24AD1
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 09:59:09 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so320301hsb.0
	for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2008 00:59:08 -0700 (PDT)
In-Reply-To: <20080417192552.GC17039@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Vladimir Barinov <vbarinov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

2008/4/17 Daniel Mack <daniel@caiaq.org>:

> On Thu, Apr 17, 2008 at 09:12:45PM +0200, Daniel Mack wrote:
> > This patch makes the tlv320aic33 driver skip the initialisation of the
> > PLL in case the sysclk is 256 * samplerate. Had to do some minor
> > refactoring too - the check whether a sysclk set by set_sysclk() is
> > valid is now done in set_hw_params().
>
> Sorry, there was a small typo in the patch I just submitted.
> Use this one instead.
>
>
I had a quick look to your patch and AIC33 spec.

Is this the same than 256-clock transfer mode? Should you set the bit 3 in
AIC3X_ASD_INTF_CTRLB in this case? Should you also still write the
AIC3X_SAMPLE_RATE_SEL_REG?


Jarkko

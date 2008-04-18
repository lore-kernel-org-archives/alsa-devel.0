From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL in
	some cases
Date: Fri, 18 Apr 2008 11:58:49 +0300
Message-ID: <bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 30B5324AC9
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 10:58:59 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so126860ana.80
	for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2008 01:58:50 -0700 (PDT)
In-Reply-To: <20080418081315.GA23555@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 11:13 AM, Daniel Mack <daniel@caiaq.org> wrote:

> Hi Jarkko,
>
> No, the 256-clock mode is for output only, while in my setup the TLV is
> in slave mode. I attached this chip to the I2S output of an PXA270 which
> always outputs sample rate * 256 as system clock. In this very case, the
> PLL can be bypassed by selecting the left path described on page 27.
>

Ok, now I see. Probably you should refer it as, at least in comment, 128*Q
instead of 256 eventhough the driver is not currently touching the Q value
in AIC3X_PLL_PROGA_REG.


> AIC3X_SAMPLE_RATE_SEL_REG defaults to 0 which is what I want in this
> case. Thus, I don't have to write it.
>
>
Are you sure this is a general case?


Jarkko

From: "Timur Tabi" <timur@freescale.com>
Subject: Re: (SoC) Does i.MX27's SSI work as I2S clock master?
Date: Mon, 1 Dec 2008 10:52:34 -0600
Message-ID: <ed82fe3e0812010852g2e3fa8fbnf669a2cf62642732@mail.gmail.com>
References: <D66C4C05-340D-4A6E-98FC-7B36F4059C36@drvlabo.jp>
	<4933181A.9010003@drvlabo.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DD4D24538
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 17:52:35 +0100 (CET)
Received: by rn-out-0910.google.com with SMTP id j67so2590836rne.21
	for <alsa-devel@alsa-project.org>; Mon, 01 Dec 2008 08:52:35 -0800 (PST)
In-Reply-To: <4933181A.9010003@drvlabo.jp>
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
To: ngc <ngc@drvlabo.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 30, 2008 at 4:47 PM, ngc <ngc@drvlabo.jp> wrote:

> Though I want to provide an oversampling clock with MCLK to the codec
> device,
> now the frequency of MCLK is same as SSI_CLK.
> Can't the MCLK provide the oversampling frequency?

I wrote the SSI driver for the MPC8610.  It's the same circuitry, so I
presume the same rules apply.

The main SSI clock must be 64 times the sample rate.  This is because
the SSI uses a clock pulse to send out one bit of sample.  Each sample
is normally 32 bits, of which only the most significant 24 have any
real value.  Since I2S is always stereo, 32 * 2 = 64 pulses per
sample.

Does that answer your question?

-- 
Timur Tabi
Linux kernel developer at Freescale

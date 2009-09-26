From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Sat, 26 Sep 2009 10:56:59 +0300
Message-ID: <20090926105659.8b1894bd.jhnikula@gmail.com>
References: <E1MrBpr-000221-BB@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 4619C245E4
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Sep 2009 09:56:46 +0200 (CEST)
Received: by ewy25 with SMTP id 25so3188278ewy.45
	for <alsa-devel@alsa-project.org>; Sat, 26 Sep 2009 00:56:45 -0700 (PDT)
In-Reply-To: <E1MrBpr-000221-BB@amazonia.comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rick Bronson <rick@efn.org>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Sep 2009 07:31:47 -0700
Rick Bronson <rick@efn.org> wrote:

> Hi Peter,
> 
>   I forgot to tell you that if I deliberately misconfigure the
> McBXP_CLKS pin so that it's an output, the FSX -> DACLRC/ADCLRC signal
> stops.  This should indicate that the CLKOUT signal is actually making
> it to the CLKS pin on the OMAP.  Right?
> 
Yes it is indicating so. I read through this thread I didn't find any
simple reason why it's not working. Your setup is similar with the
Pandora, i.e. McBSP functional clock is coming the codec and codec is
slave.

The McBSP is operating if the FSX and CLKX are toggling in this setup.
Is it so that you don't get any DMA interrupts or just few of them?
Your CLKGDV divisor value 256 means too low bit clock and sample rate
for both external 12.288 MHz and internal 96 MHz but still the DMA
should be running (if there is no bug with this divisor value).

Can you try divisor value 8 does it work then? For 48 kHz sample rate
with I2S you need a bit clock of 48 kHz*2*16 = 1.536 MHz and this you
get by dividing the 12.288 MHz with 8.


-- 
Jarkko

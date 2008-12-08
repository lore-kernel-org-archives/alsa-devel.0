From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: ASoC: hook for codec control updates and clock
	controls
Date: Mon, 8 Dec 2008 13:40:28 +0200
Message-ID: <bd7b27490812080340h166962d1gca1c103f7148f1ad@mail.gmail.com>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
	<20081207190239.GA4457@sirena.org.uk>
	<20081208000450.GA30181@buzzloop.caiaq.de>
	<bd7b27490812080149m6de590cn176a317cf49bf4b3@mail.gmail.com>
	<20081208111138.GB5159@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 5271E10382F
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 12:40:29 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so650590nfd.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Dec 2008 03:40:28 -0800 (PST)
In-Reply-To: <20081208111138.GB5159@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 8, 2008 at 1:11 PM, Mark Brown <broonie@sirena.org.uk> wrote:

>
> [You might want to check your MUA - most of your recent mails have done
> the above and marked the first line of your reply as part of the quote.]
>


Grrr. It's gmail & iceweacel.


>
> > Would it work if there is some set_mclk(int enable) callback in struct
> > aic3x_setup_data, then codec->write in aic3x_init points to higher level
> > aic3x_write_xxx which takes care of calling set_mclk(1) when needed and
> call
> > aic3x_write? Also delayed set_mclk(0) can be put into aic3x driver.
>
> TBH I don't really see any benefit from doing this in the codec driver
> to doing it in the core.
>

Agree. Also other codecs might use mclk for their internal state machine.
IRCC, TSC2301 had some weird internal states and timeouts when mclk was
required to be on and when it can be shutdown.


Jarkko

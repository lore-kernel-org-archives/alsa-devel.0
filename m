From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: ASoC: hook for codec control updates and clock
	controls
Date: Mon, 8 Dec 2008 11:49:46 +0200
Message-ID: <bd7b27490812080149m6de590cn176a317cf49bf4b3@mail.gmail.com>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
	<20081207190239.GA4457@sirena.org.uk>
	<20081208000450.GA30181@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E0C4103811
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 10:49:47 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so1033978ugf.24
	for <alsa-devel@alsa-project.org>; Mon, 08 Dec 2008 01:49:46 -0800 (PST)
In-Reply-To: <20081208000450.GA30181@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 8, 2008 at 2:04 AM, Daniel Mack <daniel@caiaq.org> wrote:

>
> Sorry for not being precise enough here. In our case, the codec is slave
> and all clocks are provided by the I2S master, which is a PXA processor.
>
> The idea is to provide a way for codecs to signal the need for the
> master clock (or whatever clock) to be applied externally. And it's
> actually not important what it takes to actually do that - a generic way
> the board support code can use would be good.
>
> Is such an aproach feasible?
>
> My two cents. However, aic3x specific only.

Would it work if there is some set_mclk(int enable) callback in struct
aic3x_setup_data, then codec->write in aic3x_init points to higher level
aic3x_write_xxx which takes care of calling set_mclk(1) when needed and call
aic3x_write? Also delayed set_mclk(0) can be put into aic3x driver.

Machine driver can then decide will it provide the callback.


Jarkko

From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: hook for codec control updates and clock
	controls
Date: Mon, 8 Dec 2008 11:11:39 +0000
Message-ID: <20081208111138.GB5159@sirena.org.uk>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
	<20081207190239.GA4457@sirena.org.uk>
	<20081208000450.GA30181@buzzloop.caiaq.de>
	<bd7b27490812080149m6de590cn176a317cf49bf4b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 08A15103811
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 12:11:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <bd7b27490812080149m6de590cn176a317cf49bf4b3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2008 at 11:49:46AM +0200, Jarkko Nikula wrote:
> On Mon, Dec 8, 2008 at 2:04 AM, Daniel Mack <daniel@caiaq.org> wrote:

> > My two cents. However, aic3x specific only.

[You might want to check your MUA - most of your recent mails have done
the above and marked the first line of your reply as part of the quote.]

> Would it work if there is some set_mclk(int enable) callback in struct
> aic3x_setup_data, then codec->write in aic3x_init points to higher level
> aic3x_write_xxx which takes care of calling set_mclk(1) when needed and call
> aic3x_write? Also delayed set_mclk(0) can be put into aic3x driver.

TBH I don't really see any benefit from doing this in the codec driver
to doing it in the core.

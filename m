From: "Pedro I. Sanchez" <psanchez@fosstel.com>
Subject: Re: ASoC: at91sam9260-PCM1808/TAS5709-based board
	driver
Date: Fri, 28 Aug 2009 17:24:59 -0400
Message-ID: <0cd9eb01b4e167a0d3a3d96334172c58@colcan.ca>
References: <4A7DB844.3030303@fosstel.com>
	<9e4733910908090635j29db4ebn64f92c2176f3cb85@mail.gmail.com>
	<9e4733910908090637g4b9eaf19ud1b46de354664df2@mail.gmail.com>
	<4A81BB75.3070405@fosstel.com>
	<20090811224132.GB4691@sirena.org.uk>
	<4A94200D.6080707@fosstel.com>
	<20090825182934.GA4317@sirena.org.uk>
	<4A943F86.5000601@fosstel.com>
	<20090826114458.GA14905@sirena.org.uk>
	<47184.207.35.173.122.1251400309.squirrel@mail.colcan.ca>
	<20090828121514.GA13478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [74.126.24.200])
	by alsa0.perex.cz (Postfix) with ESMTP id DB88B244CA
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 23:25:00 +0200 (CEST)
In-Reply-To: <20090828121514.GA13478@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Well, it turns out that the TAS5709 documentation doesn't say the whole
story. It seems that after all the chip can only guess the incoming bit
rates in rare occasions and I can't really rely on this. What the chip
really needs is a MCLK signal which is a multiple of the sound file's
sample frequency. This is a third clock line to be provided to that chip in
addition to the regular TF (frame) and TK (bit) clocks from the SSC
interface.

Now I know that I have to output this additional clock line via one of the
gpio pins of the SoC and therefore I have to somehow "attach" one of the
CPU internal timers to one of the SoC gpio pins (PC6, linux gpio102 pin to
be more exact). I have the following (borrowed) code now:

	/* PCK0 provides MCLK */
	at91_set_A_periph(AT91_PIN_PC6, 0);

How is this linking the internal pck0 timer to pin PC6? or is it?

And then I have

        /*
         * Codec MCLK is supplied by PCK0 - set it up.
         */
        mclk = clk_get(NULL, "pck0");
        if (IS_ERR(mclk)) {
                pr_err("%s: Failed to get MCLK\n", __func__);
                ret = PTR_ERR(mclk);
                goto err;
        }

        pllb = clk_get(NULL, "pllb");
        if (IS_ERR(pllb)) {
                pr_err("%s: Failed to get PLLB\n", __func__);
                ret = PTR_ERR(pllb);
                goto err_pllb;
        }
        
        ret = clk_set_parent(mclk, pllb);
        if (ret != 0) {
                pr_err("%s: Failed to set MCLK parent\n", __func__);
                goto err_parent;
        }

        clk_set_rate(mclk, 11289600);
        clk_put(pllb);
        pr_info("%s: MCLK rate %luHz\n", __func__, clk_get_rate(mclk));

... but it prints "MCLK rate 6000000Hz". Where does the 600000 come from, I
don't know. And certainly there is no clock on the PC6 pin :-(


Mark, or someone, any enlightenment on how to proceed would be very much
appreciated.

Thank you,

-- 
Pedro

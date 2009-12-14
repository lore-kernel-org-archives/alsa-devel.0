From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PLL computation in TLV320AIC3x SoC driver
Date: Mon, 14 Dec 2009 10:40:21 +0000
Message-ID: <20091214104021.GA20649@rakim.wolfsonmicro.main>
References: <alpine.DEB.2.00.0912081127460.22770@hippogriff.cosy.sbg.ac.at>
	<4B1E66C8.4070402@gmail.com>
	<alpine.DEB.2.00.0912081552430.22770@hippogriff.cosy.sbg.ac.at>
	<4B1E74D7.9080400@gmail.com> <4B1E7965.6030000@gmail.com>
	<alpine.DEB.2.00.0912091447230.17383@hippogriff.cosy.sbg.ac.at>
	<4B2009F5.8020107@gmail.com>
	<alpine.DEB.2.00.0912141116370.1905@hippogriff.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27A81103805
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 11:40:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912141116370.1905@hippogriff.cosy.sbg.ac.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Vladimir Barinov <vova.barinov@gmail.com>, vbarinov@embeddedalley.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 14, 2009 at 11:24:58AM +0100, Peter Meerwald wrote:

> +    /* try with d != 0 */
> +    for (p = 1; p <= 8; p++) {
> +
> +        j = codec_clk * p / 1000;

There are many codign style issues around the indentation in this code -
could you please run the patch through scripts/checkpatch.pl and clean
up the issues it identifies?

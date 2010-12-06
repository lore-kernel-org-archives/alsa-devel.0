From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif source
 clock id and asoc platform device
Date: Mon, 6 Dec 2010 12:46:12 +0000
Message-ID: <20101206124611.GA1924@rakim.wolfsonmicro.main>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
	<20101203114416.GG3182@sirena.org.uk>
	<AANLkTinw3+t=eVLRUiRhwPA2c_nZ7q7Kfm-QOBmsZLRT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 214BE24152
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 13:46:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinw3+t=eVLRUiRhwPA2c_nZ7q7Kfm-QOBmsZLRT@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 05, 2010 at 12:40:01AM +0900, Jassi Brar wrote:
> On Fri, Dec 3, 2010 at 8:44 PM, Mark Brown

> > Something's seriously wrong if you need to do this...

> It's necessary evil ATM.
> There is no access to SPDIF device in machine code and we need to
> get/set the clock.
> So the soc-audio is used as a place-holder.

In order to do this you need to tell the clock framework about the ASoC
virtual device - once you're doing stuff like that you may as well just
fix the S/PDIF driver to let you do what you need.

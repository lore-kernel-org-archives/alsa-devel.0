From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Ensure we delay long enough
	for	WM8994 FLL to lock when starting
Date: Mon, 4 Jul 2011 01:44:54 +0100
Message-ID: <20110704004453.GA1178@opensource.wolfsonmicro.com>
References: <1309566922-3177-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<032501cc39dd$489c24d0$d9d46e70$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3DF424B9A
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 02:51:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <032501cc39dd$489c24d0$d9d46e70$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2011 at 08:59:45AM +0900, Sangbeom Kim wrote:
> Saturday, July 02, 2011 9:35 AM, Mark Brown wrote:

> > This delay is very conservative.

> What's the meaning of conservative?

In this context it means safe.

> It means 5ms delay long enough? 
> or at least, FLL lock time should be ensured 5ms?

Yes, the 5ms should be more than enough time for the FLL to lock - in
most situations the time taken to do the register writes surrounding
enabling and then using the FLL are sufficient to cover the startup
time.

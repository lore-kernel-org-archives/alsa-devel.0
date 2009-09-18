From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Return correct codec clock
Date: Fri, 18 Sep 2009 15:12:03 +0100
Message-ID: <20090918141203.GA2121@rakim.wolfsonmicro.main>
References: <1253254947-21639-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C78AF243EA
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 16:12:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253254947-21639-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi <jassi.brar@samsung.com>, ben@trinity.fluff.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2009 at 03:22:27PM +0900, jassi brar wrote:
> From: Jassi <jassi.brar@samsung.com>

> Instead of always returnig pointer to the 'audio-bus' clock,
> check which clock is used to generate internal clocks and
> then return it's pointer.

> Signed-off-by: Jassi <jassi.brar@samsung.com>

Applied, thanks.

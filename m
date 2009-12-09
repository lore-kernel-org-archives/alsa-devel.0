From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: S3C64XX: Compress and generalize
	the CPU	driver
Date: Wed, 9 Dec 2009 11:15:04 +0000
Message-ID: <20091209111504.GF19851@opensource.wolfsonmicro.com>
References: <1260332965-11413-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 658CC103897
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:15:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1260332965-11413-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 01:29:25PM +0900, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The driver can be 'generalized' a bit by not hardcoding '2'(the number of
> I2Sv3 controllers that the driver can handle) at many places, instead we
> define a macro for it. That makes it easier to increase number of controllers
> by changing the parameter at just one place, this will be useful when there is
> support for newer SoCs, which have the same controller, only more in number.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Applied this and patch 1, thanks.

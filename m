From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 04/16] ASoC: multi-component - TI CODECs
Date: Thu, 1 Jul 2010 20:02:05 +0100
Message-ID: <20100701190205.GA30430@rakim.wolfsonmicro.main>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
	<1277488383-31287-5-git-send-email-lrg@slimlogic.co.uk>
	<C358A26273CF2948B8BCDBA661A581782A6FBF945E@NOK-EUMSG-03.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7287124431
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 21:02:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A6FBF945E@NOK-EUMSG-03.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 30, 2010 at 02:08:11PM +0200, peter.ujfalusi@nokia.com wrote:

> - What is the reason to move the IRQ, GPIO, and regulator request from the i2c_probe to soc_probe?

So, the theory here is that when you've got both I2C and SPI on a single
CODEC all the basic setup code tends to be identical over all buses (as
it is with the current register() functions.  Personally I do find this
a bit strange since it feels better to have the driver check for all the
things it needs before it has the subsystem go and try to do broader
setup work but it does do the code sharing job.

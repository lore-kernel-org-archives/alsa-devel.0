From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: refreshing the reg cache in asoc driver
Date: Wed, 29 Sep 2010 18:52:15 +0100
Message-ID: <20100929175215.GC19087@sirena.org.uk>
References: <17b6865a.5133de6e.4ca30a3c.3659c@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BFFE224154
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 19:52:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <17b6865a.5133de6e.4ca30a3c.3659c@o2.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lin_g <lin_g@o2.pl>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 29, 2010 at 11:43:24AM +0200, lin_g wrote:

> I'm writing the driver for wm8804 s/pdif transceiver. However, my

Note that Dimitrios just posted a driver for this to the list earlier
today, which is also available from opensource.wolfsonmicro.com.  It
would be best to work with this driver.

> problem is that I would like to refresh my register cache inside the
> driver by periodically reading the values stored in device's
> registers. There is an interrupt handler fsi_interrupt() (in fsi.c)
> called when codec receives some data, but I suppose I need to find
> something closer to the 'codec layer'. Or maybe I'm just thinking
> wrongly and there is much simpler way of doing this. Appreciate any
> advice.

The bigger question would be why you want to refresh the register cache
- normally this should not be required.  If you do need to do this it
would be better to trigger the refresh off whatever event causes the
register status in the CODEC to get out of sync.  If there are registers
which report status which does change dynamically normally they
shouldn't be cached at all but should instead be treated as volatile and
read back from the CODEC at all times.

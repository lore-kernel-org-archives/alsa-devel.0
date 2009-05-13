From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4 v2] pxa2xx-i2s: Proper hw	initialization
Date: Wed, 13 May 2009 23:48:29 +0100
Message-ID: <20090513224829.GC24973@sirena.org.uk>
References: <4A0B2AA5.9000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C71A72434E
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 00:48:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A0B2AA5.9000700@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 10:16:37PM +0200, Karl Beldan wrote:
> Make sure we are in a know good state at end of probe :
> Reset FIFO logic and registers, and make sure REC and RPL functions
> along with FIFO service are disabled (SACR0_RST enables REC and RPL).
> 
> Resetting loses current settings so remove reset from stream startup.
> Now reset occurs only at probe.
> 
> Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>

This one has already been applied from your previous posting.  I'll
review the rest tomorrow.

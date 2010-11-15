From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: WM8804: fsi-wm8804
Date: Mon, 15 Nov 2010 13:50:53 +0000
Message-ID: <20101115135053.GC3338@sirena.org.uk>
References: <4CE126FD.7000407@elproma.com.pl>
	<20101115123351.GB3338@sirena.org.uk>
	<4CE139CF.4070400@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 874BB103855
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 14:50:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CE139CF.4070400@elproma.com.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 15, 2010 at 02:46:55PM +0100, Grzegorz Daniluk wrote:
> Mark Brown wrote:
>> Did you register the I2C device for the CODEC with the I2C subsystem?

> I believe that is done in wm8804 codec driver (i2c_add_driver() call in  
> wm8804_modinit() function).

This is adding the driver not the device.  You need to register both -
the device will generally be registered by your arch/ file for the
board.

>> If that's not the issue could you please provide a kernel log with
>> #define DEBUG at the top of soc-core.c?

> I'm sending the full kern.log as an attachment to this email.

Could you please verify that you have enabled the debug logging
requested?  I cannot see any of the additional logging that would be
generated if this was enabled.

From: "Leung Chi Tat" <ctleung@cct.com.hk>
Subject: Re: Help on writing an ALSA ASoC Driver for WM8985
Date: Tue, 26 May 2009 09:00:05 +0800
Message-ID: <D6546E3E62D77445A7E4B9A0FD70CDE007A80111@FTBM01.ft.cct.grp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp05.cct.com.hk (smtp05.cct.com.hk [210.0.232.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F0A42446C
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 03:02:08 +0200 (CEST)
Content-class: urn:content-classes:message
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

Mark,

I got it.  Once we set those volume update bits in wm8990_init(), those bits in the wm8985 register cache array, wm8985_reg[], will then  be set too.  So, whenever we write a new value to a volume register, wm8985_write() will then write the new value to the volume register and update the corresponding volume update bit also.  This is the trick.

A Great Idea!

Thank you so much!  

Chitat


On Mon, May 25, 2009 at 08:47:31PM +0800, Leung Chi Tat wrote:

> I'm right now studying the driver code for wm8980 codec (from the main
> trunk of linux-2.6-asoc) as it seems to be more close to wm8985.  I
> can't find any code for triggering those volume update bits after
> modified those volume registers.   But, the wm8980 datasheet states
> that we have to do so to make those volume updates properly.  Is there
> some black magic in the code?

The normal approach for volume update bits is to set them when
initialising the CODEC at startup - this is what the wm8990 driver is
doing when it writes to the volume registers in wm8990_init().  This
means that any further register writes which only change the volume
field in the registers will also have the volume update bit set.

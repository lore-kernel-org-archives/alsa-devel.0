From: Nathan Allen Stratton <nathan@robotics.net>
Subject: Re: Osprey 440 almost supported!!! Need X9221 i2c
 support!
Date: Fri, 22 Jun 2007 11:10:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0706221108350.21405@barney.robotics.net>
References: <Pine.LNX.4.58.0706212241460.15772@barney.robotics.net>
	<1182502291.5842.1196490029@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barney.robotics.net (cyber.robotics.net [209.150.98.82])
	by alsa0.perex.cz (Postfix) with ESMTP id B001B24515
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 17:10:01 +0200 (CEST)
In-Reply-To: <1182502291.5842.1196490029@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 22 Jun 2007, Clemens Ladisch wrote:

> Nathan Allen Stratton wrote:
> > [...]
> > So the issue now is that the audio is WAY to high so it is very distorted.
> > The audio is controlled via X9221A chips on the i2c bus at 0x50, there are
> > not drivers for X9221 so I can't lower the audio levels.
>
> There is a datasheet for these chips, so writing some code for this
> should be easy.  However, the I2C controller is not managed by the
> snd-bt87x driver but by the bttv driver.

Old linux drivers (no longer compile on suse, or fedora) should help:

ftp://ftp.viewcast.com/pub/OSP-MM/Linux/latest

Now that we know the GPIO settings, how hard is it to add i2c support in
bttv?

-Nathan

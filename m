From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Osprey 440 almost supported!!! Need X9221 i2c
	support!
Date: Fri, 22 Jun 2007 10:51:31 +0200
Message-ID: <1182502291.5842.1196490029@webmail.messagingengine.com>
References: <Pine.LNX.4.58.0706212241460.15772@barney.robotics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 3E7E8244E5
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 10:51:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0706212241460.15772@barney.robotics.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nathan Allen Stratton <nathan@robotics.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nathan Allen Stratton wrote:
> [...]
> So the issue now is that the audio is WAY to high so it is very distorted.
> The audio is controlled via X9221A chips on the i2c bus at 0x50, there are
> not drivers for X9221 so I can't lower the audio levels.

There is a datasheet for these chips, so writing some code for this
should be easy.  However, the I2C controller is not managed by the
snd-bt87x driver but by the bttv driver.


Regards,
Clemens

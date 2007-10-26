From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: how to handle bt848 audio driver
Date: Fri, 26 Oct 2007 08:46:58 +0200
Message-ID: <1193381218.13564.1217931615@webmail.messagingengine.com>
References: <Pine.LNX.4.58.0710250407410.16052@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7ED552449A
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 08:46:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0710250407410.16052@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:
> I've made some more patches for the ALSA bt87x audio driver to support more
> features of the Osprey 440 card.
> 
> In order to support certain features, the ALSA driver needs access to the
> bt878's GPIO lines and I2C bus.  These are controlled by PCI function 0, which
> is driven by the V4L driver.  The bt878 DVB driver (which drives PCI function
> 1 just like the ALSA driver) needs to do the same thing and there is already
> some code to handle it.
> 
> So, the ALSA driver (snd-bt87x) needs to use functions from the V4L driver
> (bttv).  As it is now, the two drivers are completely separate and don't share
> any code and can be loaded individually.
> 
> The DVB driver in the same tree as bttv, so this isn't a problem.  But the
> snd-bt87x is in another tree, so it's somewhat harder, and I'm not sure what
> to do about it.

The part of the ALSA API used by snd-bt87x is apparently more stable
than the bttv functions to be used, so this seems to be a good
opportunity to move snd-bt87x into the V4L tree.


Regards,
Clemens

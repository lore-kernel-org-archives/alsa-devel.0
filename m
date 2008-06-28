From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: ALSA with Ubuntu 8.04
Date: Sat, 28 Jun 2008 23:15:28 +1000
Message-ID: <1214658928.30056.74.camel@localhost>
References: <4862D901.4070700@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 190172432D
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Jun 2008 15:15:34 +0200 (CEST)
In-Reply-To: <4862D901.4070700@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I happened to be in this territory a couple of nights ago... so here's a
summary of what I learned.

The priority order for the case of multiple modules with the same name
may be controlled by modifying /etc/depmod.conf .

As Takashi says, and quoting from `man depmod.conf`:

By default, depmod will give a higher priority  to  a  directory
with  the  name  updates  using  this  built-in  search  string:
"updates built-in" but more complex  arrangements  are  possible
and are used in several popular distributions.


Other directories may be given priority by specifying your own search
line as follows:
in /etc/depmod.conf
-------------------------
search my-custom-drivers updates built-in
-------------------------

After installing a new module (and perhaps manually running depmod), you
can check which module will actually be used with
grep my-module-name /lib/modules/`uname -r`/modules.dep

This takes out all the guesswork and makes success a 'sure thing' :-) .

Ben Stanley.


On Thu, 2008-06-26 at 11:47 +1200, Eliot Blennerhassett wrote:
> This just an FYI
> 
> In Ubuntu 8.04, ubuntu has packaged alsa-drivers including some out of 
> tree drivers in a separate package: linux-ubuntu-modules-$kernelver
> 
> This gets installed in /lib/modules/$kernelver/ubuntu/sound
> 
> The only things installed in /lib/modules/$kernelver/sound are 
> soundcore.ko and ac97_bus.ko
> 
> However, when you do a default "make install" from alsa-driver source, 
> the modules get installed in /lib/modules/$kernelver/kernel/sound
> 
> So, now there are 2 copies of the drivers in different places.
> 
> I have taken to removing (moving away to say /root) 
> /lib/modules/$kernelver/ubuntu/sound to avoid any confusion and some odd 
> module versioning problems that I was having.
> 
> regards
> 
> Eliot.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

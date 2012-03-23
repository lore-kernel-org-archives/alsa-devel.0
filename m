From: Petr Baudis <pasky@ucw.cz>
Subject: Re: hda-intel: azx_get_response timeout,
 switching to polling mode: last cmd=0x01db0000
Date: Fri, 23 Mar 2012 03:09:13 +0100
Message-ID: <20120323020913.GB3554@machine.or.cz>
References: <20111229025953.15211.24880.reportbug@machine.or.cz>
	<20111229062105.GB28780@elie.Belkin>
	<20120121091602.GF30898@machine.or.cz>
	<s5hhazm6alb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from machine.or.cz (pasky.or.cz [84.242.80.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 844EF103ED4
	for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2012 03:09:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhazm6alb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Nieder <jrnieder@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

  Hi!

> At Sat, 21 Jan 2012 10:16:02 +0100, Petr Baudis wrote:
> > I will try the then-current kernel and for-next branch then.

  FYI, this issue has most likely reached a happy end. While 3.2.x
did not work properly, tonight I finally could reboot the machine
with tiwai's for-next branch and cannot reproduce the issue so far!

  I'm not sure if this is thanks to an unrelated change in interrupt
handling that got pulled around or something that's actually brewing
in the for-next branch but hopefully it will eventually find its way
to the distribution kernels.  :-)

  Thanks,

				Petr "Pasky" Baudis

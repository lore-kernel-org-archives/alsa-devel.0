From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: SoC pxa2xx-ac97 + wm9705 + touchscreen suspend/resume
Date: Mon, 30 Mar 2009 23:37:20 +0100
Message-ID: <20090330223720.GC31396@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 2F1841037FD
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 00:37:36 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, eric miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Trying Linus' latest (as of this morning) out on a PXA255 platform with
a WM9705 codec reveals a number of problems:

1. when suspend occurs, we turn the AC97 link off by setting the
GCR_ACLINK_OFF bit, and stopping the functional units clock.

On resume, we reconfigure the pins and re-enable the clock. 
Unfortunately, this results in GCR being left with zeros, and GSR
remains all zeros, and the codec is inaccessible, with lots of
warnings from the read/write functions scrolling by:

pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x0)                           
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x0)                             
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x0)                             
...

Setting GCR to '2' (to release cold reset) using devmem2 starts things
moving again, shutting up this warning.


2. maybe as a result of the above problem, the wm9705 touchscreen
driver doesn't reinitialize, causing loss of touchscreen.  Unbinding
and re-binding the driver restores the touchscreen, but with a very
long lag between touching the screen and it being registered.


I bring (2) up because I notice that the resume actions in (1) are
deferred.  Given that codecs have shared functions (such as
touchscreens) need to access the codec from their own resume
functions, how can this deferral be safe?

Liam - this problem has been noticed on a NetbookPro (I'm sure you
remember that platform...)

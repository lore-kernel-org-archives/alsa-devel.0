From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Fix possibly incorrect offset in
	wm97xx-core
Date: Thu, 4 Jun 2009 22:05:48 +0200
Message-ID: <200906042205.48277.marek.vasut@gmail.com>
References: <200906032344.37640.marek.vasut@gmail.com>
	<200906041159.02380.marek.vasut@gmail.com>
	<20090604110609.GH6983@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ckCKKMJSo3/reTh"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 592EA10380B
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 22:05:47 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1070081bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 13:05:46 -0700 (PDT)
In-Reply-To: <20090604110609.GH6983@rakim.wolfsonmicro.main>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_ckCKKMJSo3/reTh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 04 of June 2009 13:06:09 Mark Brown wrote:
> On Thu, Jun 04, 2009 at 11:59:02AM +0200, Marek Vasut wrote:
> > On Thursday 04 of June 2009 10:46:03 Mark Brown wrote:
> > > Nack, the existing code reflects the behaviour of the silicon.
> >
> > The patch above reflects the behavior of my silicon (WM9712G) :-/
>
> Could you expand on the behaviour you're seeing, please?  Also, what are
> the full markings on the chip?

Actually, after discussing this on IRC with you, I come with the following 
patch (it should be applied on top of the mainstone accelerated touch patch 
which follows).

--Boundary-00=_ckCKKMJSo3/reTh
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0002-Add-possibility-to-control-the-GPIO_STATUS-shift.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Add-possibility-to-control-the-GPIO_STATUS-shift.patch"

=46rom cb511c67296ed0cbb7b82a690cd4a027511b149b Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 4 Jun 2009 21:56:59 +0200
Subject: [PATCH 2/2] Add possibility to control the GPIO_STATUS shift

This patch allows tweaking the behaviour of GPIO_STATUS register
shift quirk that's in wm97xx-core. The problem with GPIO_STATUS
register being shifted by one doesn't appear on all hardware it
seems and causes problems with accelerated touchscreen drivers on
Palm hardware. Therefore an accelerated touchscreen driver can select
if the shift is/isn't happening on the hardware.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 drivers/input/touchscreen/mainstone-wm97xx.c |    2 ++
 drivers/input/touchscreen/wm97xx-core.c      |   19 +++++++++----------
 include/linux/wm97xx.h                       |    1 +
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/t=
ouchscreen/mainstone-wm97xx.c
index 60bda9a..7ed54f5 100644
=2D-- a/drivers/input/touchscreen/mainstone-wm97xx.c
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c
@@ -200,6 +200,8 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
 	if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) {
 		pen_int =3D 1;
 		irq =3D 27;
+		wm->gpio_offset =3D 0;	/* interestingly, on Palm hardware, the
+					 * GPIO_STATUS shift doesn't occur */
 	} else if (machine_is_mainstone() && pen_int)
 		irq =3D 4;
=20
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchs=
creen/wm97xx-core.c
index 69af838..cada765 100644
=2D-- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -204,10 +204,7 @@ void wm97xx_set_gpio(struct wm97xx *wm, u32 gpio,
 	else
 		reg &=3D ~gpio;
=20
=2D	if (wm->id =3D=3D WM9712_ID2)
=2D		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg << 1);
=2D	else
=2D		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg);
+	wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg << wm->gpio_offset);
 	mutex_unlock(&wm->codec_mutex);
 }
 EXPORT_SYMBOL_GPL(wm97xx_set_gpio);
@@ -307,12 +304,8 @@ static void wm97xx_pen_irq_worker(struct work_struct *=
work)
 					 WM97XX_GPIO_13);
 		}
=20
=2D		if (wm->id =3D=3D WM9712_ID2)
=2D			wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
=2D						~WM97XX_GPIO_13) << 1);
=2D		else
=2D			wm97xx_reg_write(wm, AC97_GPIO_STATUS, status &
=2D						~WM97XX_GPIO_13);
+		wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
+				~WM97XX_GPIO_13) << wm->gpio_offset);
 		mutex_unlock(&wm->codec_mutex);
 	}
=20
@@ -582,6 +575,12 @@ static int wm97xx_probe(struct device *dev)
=20
 	wm->id =3D wm97xx_reg_read(wm, AC97_VENDOR_ID2);
=20
+	/* On some versions of WM9712, the GPIO_STATUS register is shifted */
+	if (wm->id =3D=3D WM9712_ID2)
+		wm->gpio_offset	=3D 1;
+	else
+		wm->gpio_offset	=3D 0;
+
 	dev_info(wm->dev, "detected a wm97%02x codec\n", wm->id & 0xff);
=20
 	switch (wm->id & 0xff) {
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 6f69968..c6dc15b 100644
=2D-- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -283,6 +283,7 @@ struct wm97xx {
 	unsigned pen_is_down:1;		/* Pen is down */
 	unsigned aux_waiting:1;		/* aux measurement waiting */
 	unsigned pen_probably_down:1;	/* used in polling mode */
+	unsigned gpio_offset:1;		/* gpio register offset */
 	u16 suspend_mode;               /* PRP in suspend mode */
 };
=20
=2D-=20
1.6.2.1


--Boundary-00=_ckCKKMJSo3/reTh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_ckCKKMJSo3/reTh--

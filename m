From: Marek Vasut <marek.vasut@gmail.com>
Subject: Palm27x-asoc: fix it to work without jack gpio
	specified
Date: Mon, 1 Jun 2009 22:30:58 +0200
Message-ID: <200906012230.58977.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CqDJKf0ue1cFbCN"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id C33EB2438A
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 22:31:01 +0200 (CEST)
Received: by bwz11 with SMTP id 11so8217468bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 01 Jun 2009 13:31:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_CqDJKf0ue1cFbCN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the patch follows. The problem was with palmz72 which doesn't have the jack 
detection.

--Boundary-00=_CqDJKf0ue1cFbCN
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-Palm27x-aSoC-Make-it-work-without-jack-GPIO-specifi.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Palm27x-aSoC-Make-it-work-without-jack-GPIO-specifi.patch"

=46rom 4b569013e47b03199d7efda812cb329736723f0a Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Mon, 1 Jun 2009 17:57:15 +0200
Subject: [PATCH 1/2] Palm27x-aSoC: Make it work without jack GPIO specified

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 sound/soc/pxa/palm27x.c |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index e6102fd..628e13e 100644
=2D-- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -204,25 +204,22 @@ static int palm27x_asoc_probe(struct platform_device =
*pdev)
 {
 	int ret;
=20
=2D	if (!(machine_is_palmtx() || machine_is_palmt5() ||
=2D		machine_is_palmld() || machine_is_palmte2()))
=2D		return -ENODEV;
=2D
=2D	if (pdev->dev.platform_data)
+	if (pdev->dev.platform_data) {
 		palm27x_ep_gpio =3D ((struct palm27x_asoc_info *)
 			(pdev->dev.platform_data))->jack_gpio;
=20
=2D	ret =3D gpio_request(palm27x_ep_gpio, "Headphone Jack");
=2D	if (ret)
=2D		return ret;
=2D	ret =3D gpio_direction_input(palm27x_ep_gpio);
=2D	if (ret)
=2D		goto err_alloc;
=2D
=2D	if (request_irq(gpio_to_irq(palm27x_ep_gpio), palm27x_interrupt,
=2D			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
=2D			"Headphone jack", NULL))
=2D		goto err_alloc;
+		ret =3D gpio_request(palm27x_ep_gpio, "Headphone Jack");
+		if (ret)
+			return ret;
+		ret =3D gpio_direction_input(palm27x_ep_gpio);
+		if (ret)
+			goto err_alloc;
+
+		if (request_irq(gpio_to_irq(palm27x_ep_gpio), palm27x_interrupt,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"Headphone jack", NULL))
+			goto err_alloc;
+	}
=20
 	palm27x_snd_device =3D platform_device_alloc("soc-audio", -1);
 	if (!palm27x_snd_device) {
@@ -242,17 +239,21 @@ static int palm27x_asoc_probe(struct platform_device =
*pdev)
 put_device:
 	platform_device_put(palm27x_snd_device);
 err_dev:
=2D	free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
+	if (pdev->dev.platform_data)
+		free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
 err_alloc:
=2D	gpio_free(palm27x_ep_gpio);
+	if (pdev->dev.platform_data)
+		gpio_free(palm27x_ep_gpio);
=20
 	return ret;
 }
=20
 static int __devexit palm27x_asoc_remove(struct platform_device *pdev)
 {
=2D	free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
=2D	gpio_free(palm27x_ep_gpio);
+	if (pdev->dev.platform_data) {
+		free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
+		gpio_free(palm27x_ep_gpio);
+	}
 	platform_device_unregister(palm27x_snd_device);
 	return 0;
 }
=2D-=20
1.6.2.1


--Boundary-00=_CqDJKf0ue1cFbCN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_CqDJKf0ue1cFbCN--

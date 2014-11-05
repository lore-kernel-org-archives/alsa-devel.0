From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio
	Interface	support to quirks-table
Date: Wed, 05 Nov 2014 22:17:23 +0100
Message-ID: <545A93E3.7020906@ladisch.de>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>	<531DAB14.5080201@ladisch.de>	<76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>	<531DDD04.5050902@ladisch.de>	<0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>	<531EC9CC.4060203@ladisch.de>	<88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>
 <545895AD.7020004@ladisch.de> <545A697C.5070800@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 60CEF2614FF
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 22:17:34 +0100 (CET)
In-Reply-To: <545A697C.5070800@bobobeach.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrus Harmon <cyrus@bobobeach.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cyrus Harmon wrote:
> [    2.964094] snd-usb-audio 3-3.2:1.0: checking PCM interface
> [    2.964104] snd-usb-audio: probe of 3-3.2:1.0 failed with error -5
> [    2.966339] snd-usb-audio 3-3.2:1.1: checking PCM interface
> [    2.966341] snd-usb-audio 3-3.2:1.1: altsets found
> [    2.966342] snd-usb-audio 3-3.2:1.1: endpoint found
> [    2.966343] snd-usb-audio 3-3.2:1.1: iso found
> [    2.966344] snd-usb-audio 3-3.2:1.1: descriptors found
> [    2.968544] usb 3-3.2:1.0: checking PCM interface
> [    2.968546] usb 3-3.2:1.2: checking PCM interface
> [    2.968547] usb 3-3.2:1.2: altsets found
> [    2.968547] usb 3-3.2:1.2: endpoint found
> [    2.968548] usb 3-3.2:1.2: iso found
> [    2.968549] usb 3-3.2:1.2: descriptors found
> [    2.970657] usb 3-3.2:1.3: checking PCM interface
> [    2.970666] usb 3-3.2:1.4: checking PCM interface
> [    2.970930] snd-usb-audio: probe of 3-3.2:1.1 failed with error -5

Strange; in theory, this cannot happen.

Please add this patch and try again.


Regards,
Clemens


--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -536,7 +536,9 @@ snd_usb_audio_probe(struct usb_device *dev,
 	err = 1; /* continue */
 	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
 		/* need some special handlings */
-		if ((err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk)) < 0)
+		err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk);
+		dev_info(&intf->dev, "quirk return code: %d\n", err);
+		if (err < 0)
 			goto __error;
 	}

@@ -547,11 +549,13 @@ snd_usb_audio_probe(struct usb_device *dev,
 			goto __error;
 		}
 	}
+	dev_info(&intf->dev, "probe step 2\n");

 	/* we are allowed to call snd_card_register() many times */
 	if (snd_card_register(chip->card) < 0) {
 		goto __error;
 	}
+	dev_info(&intf->dev, "probe step 3\n");

 	usb_chip[chip->index] = chip;
 	chip->num_interfaces++;
@@ -560,6 +564,7 @@ snd_usb_audio_probe(struct usb_device *dev,
 	return chip;

  __error:
+	dev_info(&intf->dev, "probe failed\n");
 	if (chip) {
 		if (!chip->num_interfaces)
 			snd_card_free(chip->card);
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -367,6 +367,7 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
 	err = create_autodetect_quirk(chip, iface, driver);
 	if (err < 0)
 		return err;
+	dev_info(&iface->dev, "first interface successful\n");

 	/*
 	 * ALSA PCM playback/capture devices cannot be registered in two steps,
@@ -385,9 +386,13 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,

 		err = create_autodetect_quirk(chip, iface, driver);
 		if (err >= 0)
+		{
 			usb_driver_claim_interface(driver, iface, (void *)-1L);
+			dev_info(&iface->dev, "interface %d successful\n", ifnum);
+		}
 	}

+	dev_info(&iface->dev, "create_autodetect_quirks successful\n");
 	return 0;
 }

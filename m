From: Alexander <subaparts@yandex.ru>
Subject: Does anyone really have success experience with SPI
 codecs with new name-based SOC API?
Date: Thu, 18 Nov 2010 14:31:06 +0300
Message-ID: <1290079866.1496.55.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward19.mail.yandex.net (forward19.mail.yandex.net
	[95.108.253.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 68886103914
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 12:31:11 +0100 (CET)
Received: from smtp18.mail.yandex.net (smtp18.mail.yandex.net [95.108.252.18])
	by forward19.mail.yandex.net (Yandex) with ESMTP id 978EE3440368
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 14:31:07 +0300 (MSK)
Received: from [192.168.1.202] (ppp91-78-231-64.pppoe.mtu-net.ru
	[91.78.231.64])
	by smtp18.mail.yandex.net (Yandex) with ESMTPA id 602FA36780C2
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 14:31:07 +0300 (MSK)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Does anyone really have success experience with SPI codecs with new
name-based SOC API?
There are really few SPI codecs in ASoC subsystem, so I wonder if only I
cannot bind my SPI codec to machine driver.

The codec is registered with name spi0.0 it's the behavior of SPI
subsystem, I suppose. So the form is %s%d.%d and not %s.%d as supposed
in fmt_single_name() in soc_core.c

For me
dev_name(dev)==spi0.0
dev->driver->name==cs4271-codec

Is this really working code?
-----
	strncpy(name, dev_name(dev), NAME_SIZE);

	/* are we a "%s.%d" name (platform and SPI components) */
	found = strstr(name, dev->driver->name);
	if (found) {
		/* get ID */
		if (sscanf(&found[strlen(dev->driver->name)], ".%d", id) == 1) {

			/* discard ID from name if ID == -1 */
			if (*id == -1)
				found[strlen(dev->driver->name)] = '\0';
		}

	} else {
-----

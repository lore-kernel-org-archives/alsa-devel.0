Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23906C010A2
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:54:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF8521D6C
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H0Y5azBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF8521D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC9F7170B;
	Tue,  5 Nov 2019 12:53:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC9F7170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572954846;
	bh=J6MHyjekK+/IfIHIGsBGZN/NDoLJyAh+kzkYC67+6X8=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H0Y5azBgh0fno588Z0W5jM9ZNtqA1AcRpfrx1lKjawh6DX593ic+p0atbRXU71lmm
	 IMzTPE4npS++KT/BrwMuz0D/3MhhAM+t8s5KXeMuzFduk/b9RjsLnrB/LHJQhWJduR
	 VHWCQYLAN7tytU1zq1eGIonHdVmC3WQftcfhvH+8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D75A2F8060E;
	Tue,  5 Nov 2019 12:50:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26ADCF8049B; Tue,  5 Nov 2019 11:54:15 +0100 (CET)
Received: from mailgate1.rohmeurope.com (mailgate1.rohmeurope.com
 [178.15.145.194])
 by alsa1.perex.cz (Postfix) with ESMTP id E0ABBF800F3
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 11:54:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0ABBF800F3
X-AuditID: c0a8fbf4-183ff70000001fa6-9b-5dc154d30e3a
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com
 [192.168.251.177])
 by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id
 1C.45.08102.3D451CD5; Tue,  5 Nov 2019 11:54:11 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Tue, 5 Nov 2019 11:54:06 +0100
From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To: "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>
Thread-Topic: [PATCH 00/62] Add definition for GPIO direction
Thread-Index: AQHVk8EYmzhgkSAfS0Ot5MRDeZesqad8VmiA
Date: Tue, 5 Nov 2019 10:54:06 +0000
Message-ID: <98b0fcbae31f548d42264c91b1b853d71167607c.camel@fi.rohmeurope.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-ID: <25949A246E0DB248848B1397A8FF864E@de.rohmeurope.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0wcZRSG/Wa+mR0oS4YtyFdsm7iaGrW2gv44am36o03GaqtYjUYldJCR
 RWEhu0vTNk2kt5BdhEKK6TICtcjGciuwiyLbLoXthZZegHAptGBdAS0YLgZIuaozrC38mXnm
 vOc97/lxhqN1OVwEl2i0SCajmKRnA3Hj2fmalzo+aIp5eSr7FagZvIGgs91LgbuDg6wjpyjI
 nDhFQ2XWFQxThS0YOo87EVzMukTD3NhlDfi63oXSPAy9h89TMN+6SMMxuRhD2bf1GIZcAxTk
 LfxIgXOgm4Gj5bdpcJ1eQGCbK6Whw13AwnclJzD095ch+Gl4jAJb9yAD1imZhQeVdxi4VjKN
 wFdagKHAcQ1D0WIlA2PDH0OD6yYFk+MXGWj6cxRDu72VhqF8FwuLdU4MGaWdSlv5IIK22V4K
 HtSGQ5/LxYC94jyCWXcRhnu5JxFkjTtY8Pw6ibZFCV0Zbo1QPXmEFcZ7jmsE+f4tVrDPF2PB
 3RghZE56aaFe7tcI7X9fpQVnmZUV+rovsELR9WjBVfK10Go/g4SciVGlPONA7639ZNWWONGy
 b09ignHz1r2rDH2dRVRqNrN/vnMap6MFbEMBHOFfJT2lpykbCuR0fBcic0PjrP+jGZH63GnG
 hjiO5bcQW69GxVD+NVLTHqK20PzDMNLxWw+rDlqttNw4ehapHMq/Scrvu1g/R5EZTwGlMuaf
 JY3pLUus5XeT6tq2pSV0/HZyt9m7xAH8DmK/ZF1ixK8j1vSxpX6aDyfOPx4y/qV5UnKhlfZz
 GBke+Of/up54Zn1Y3ZPmnydV7s1+6zby88wY4+enSV6mT+NfIYRczx/EOehJeUWCvOyWV7jl
 FW55hft7xJQhkiwmJiWIFilyk0lK22RKMSQrr89Tkp3If9tTv6B/vW95EcUhL1rDUfow7cbX
 G2N0wXEp8QcMotkQa0pLksxeRDhaH6ptt3tidNp48cBByZTySHqKw/pw7XO+3Bgdr2Z9JUmp
 kumRupbj9ER78/2mGF2ISUqQ9n+RmGRZlikuQB0eGBFqlozxkklMsxhi1fOINSv3oUpBSu4P
 exS71pwqJitVv7UFRXI5w4XFNHe50KE874x7HLQOG1OMUkS4VqsaeNVgSDM+jhtB4RzSr9Ya
 VDVI+c0fTxtRgigl6J2BBjXIIi5LEenoZFLV3N1TQxs37BPXN0fvzX4ioCKsxyH7KoLPmC3B
 ddKh9Z6MAJQQpP89eLG2xxu0rq74sDGqwmw9t6YoT5LNrrh43VVq/vboR8+80XzCvstRdqvp
 s7a/XqzJunLo4PYPz1V7o6ls49ad1p0TxwardudvuPf2lw1N34xMfBqyo69xV7Eemw1i5Au0
 ySz+B97DnWejBAAA
X-Mailman-Approved-At: Tue, 05 Nov 2019 12:50:45 +0100
Cc: "semi.malinen@ge.com" <semi.malinen@ge.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "david.daney@cavium.com" <david.daney@cavium.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "ptyser@xes-inc.com" <ptyser@xes-inc.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "marek.behun@nic.cz" <marek.behun@nic.cz>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 "bamv2005@gmail.com" <bamv2005@gmail.com>, "joel@jms.id.au" <joel@jms.id.au>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
 "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
 "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
 "rjui@broadcom.com" <rjui@broadcom.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "nandor.han@ge.com" <nandor.han@ge.com>,
 "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "ssantosh@kernel.org" <ssantosh@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "sbranden@broadcom.com" <sbranden@broadcom.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "info@metux.net" <info@metux.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "t.scherer@eckelmann.de" <t.scherer@eckelmann.de>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [alsa-devel] [PATCH 00/62] Add definition for GPIO direction
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


On Tue, 2019-11-05 at 12:09 +0200, Matti Vaittinen wrote:
> The patch series adds definitions for GPIO line directions.

Argh. Sorry peeps. My new cool patch script messed up the message-id
header causing the messages to not be nicely grouped in one thread.
Patches are now all scattered around your (in)boxes :/

I won't resend the series unless requested though - sending 62 mails is
not fun - receiving them may be even less fun... 

Sorry once more
--Matti
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

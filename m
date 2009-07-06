From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Model quirks and duplicate device IDs
Date: Mon, 06 Jul 2009 21:56:57 +0300
Message-ID: <4A5248F9.1050607@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A99EE24450
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 20:56:54 +0200 (CEST)
Received: from [192.168.1.2] (unknown [88.249.178.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by lider.pardus.org.tr (Postfix) with ESMTPSA id 02B6DA7ADA2
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 21:56:25 +0300 (EEST)
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

Hi,

A user reports that toshiba model is working fine with its
laptop(Subsystem: 152d:0763). I checked the patch_realtek file and saw
that the exact ID was mapped against ALC268_ACER 2 years ago for ALSA
issue #3343.

Both laptops are not-so-popular local brands and checking against 152d
points to:

152d  QUANTA Computer Inc

according to the pci.ids database.

So how should we act on those situations seen that we can't match against DMI data(which would possibly be crap on those laptops)?

Thanks,
Ozan Caglayan

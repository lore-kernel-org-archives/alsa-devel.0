From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: sound/pci/hda/hda_tegra.c
Date: Fri, 13 Feb 2015 17:11:49 +1300
Message-ID: <54DD7985.2040009@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A1FA2652F1
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 05:12:02 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1YM7bl-0003Th-62
 for alsa-devel@alsa-project.org; Fri, 13 Feb 2015 05:12:01 +0100
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 05:12:01 +0100
Received: from eliot by 121-72-250-62.cable.telstraclear.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 05:12:01 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Browsing code I came across this...

sound/pci/hda/hda_tegra.c

static int hda_tegra_init_chip(struct azx *chip, struct platform_device
*pdev)
...

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	hda->regs = devm_ioremap_resource(dev, res);

Checking chip->remap_addr before assignment looks wierd to me, am I
missing something?  Should it be 'hda->regs' here?

	if (IS_ERR(chip->remap_addr))
		return PTR_ERR(chip->remap_addr);

	chip->remap_addr = hda->regs + HDA_BAR0;
	chip->addr = res->start + HDA_BAR0;
	

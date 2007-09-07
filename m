From: Chris Pemberton <cjpembo@gmail.com>
Subject: Lenovo 3000 N100 Laptop quirk
Date: Thu, 06 Sep 2007 22:09:37 -0500
Message-ID: <46E0C0F1.7020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id E073A1037F6
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 05:29:42 +0200 (CEST)
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

To enable sound on a Lenovo 3000 N100 laptop...

In patch_realtek.c (near line # 10882):

Change:

SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo", ALC861VD_LENOVO),

to:

SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo 3000 N100", ALC861VD_3ST),

Thanks,

Chris

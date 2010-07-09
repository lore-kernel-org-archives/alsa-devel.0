From: errordeveloper@gmail.com
Subject: Kirkwood SoC - AVB support questions ..?
Date: Fri, 9 Jul 2010 21:01:17 +0100
Message-ID: <20100709200117.GC7635@00110101.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id AB344243CA
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 22:01:22 +0200 (CEST)
Received: by wyf19 with SMTP id 19so1863907wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Jul 2010 13:01:22 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello dear ALSA developer list members,

I have a question regarding hardware features of Marvell Kirkwood chip.

I is known that the NIC core on the chip includes support for Ethernet
AV Bridging, which is still a draft standard ..but i suppose that
Marvell released this chip with quite functional AVB implementation.

grepping the sk98 driver code actually shows numerous lines with AVB as
well as PTP, so i suppose they have implemented IOCTL in the sk98 driver
..i'm still doubtfull about Linux kernel PTP implementation ..is there
now in some form or not?

Did any of you have a look at AVB ?
how do you think the driver for it could fit into Linux Netdev and ALSA?

How are the CobraNet and EtherSound drivers designed, has anyone used
those cards ?? (one was from DigiGram and another from Audio Science IIRC)


Regards,
-- 
Ilya Dmitrichenko 

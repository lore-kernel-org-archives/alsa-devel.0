From: Yiliang Bao <yiliangb@gmail.com>
Subject: Why use spin_lock or spin_lock_irq in trigger callback
	(audio capture)?
Date: Thu, 25 Feb 2010 13:32:16 -0800
Message-ID: <e5baf3861002251332n7333fb12tb15b055baffaa4a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f192.google.com (mail-pz0-f192.google.com
	[209.85.222.192])
	by alsa0.perex.cz (Postfix) with ESMTP id EE476103979
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 22:32:18 +0100 (CET)
Received: by pzk30 with SMTP id 30so12831pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 13:32:16 -0800 (PST)
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

I looked at some PCI audio capture driver like BT878 (sound/pci/bt87x.c) or
SAA7134 (drivers/media/video/saa7134-alsa.c), I found that spin_lock instead
of spin_lock_irq (or spin_lock_irqsave) is used in trigger function. Is
there any reason for that?

Thanks,
Yiliang

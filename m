From: =?UTF-8?Q?lin=5Fg?= <lin_g@o2.pl>
Subject: =?utf-8?q?refreshing_the_reg_cache_in_asoc_driver?=
Date: Wed, 29 Sep 2010 11:43:24 +0200
Message-ID: <17b6865a.5133de6e.4ca30a3c.3659c@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rekin26.go2.pl (rekin26.go2.pl [193.17.41.76])
	by alsa0.perex.cz (Postfix) with ESMTP id B6DBF1038D2
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 11:43:26 +0200 (CEST)
Received: from rekin26.go2.pl (unknown [10.0.0.76])
	by rekin26.go2.pl (Postfix) with ESMTP id 7A9BA35D806
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 11:43:26 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.36])
	by rekin26.go2.pl (Postfix) with SMTP
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 11:43:25 +0200 (CEST)
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
I'm writing the driver for wm8804 s/pdif transceiver. However, my problem is that I would like to refresh my register cache inside the driver by periodically reading the values stored in device's registers. There is an interrupt handler fsi_interrupt() (in fsi.c) called when codec receives some data, but I suppose I need to find something closer to the 'codec layer'. Or maybe I'm just thinking wrongly and there is much simpler way of doing this. Appreciate any advice.

Thank you very much,
best regards,
Greg

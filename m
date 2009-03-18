From: Daniel Mack <daniel@caiaq.de>
Subject: Cleanup patches for snd-usb-caiaq
Date: Wed, 18 Mar 2009 11:03:52 +0100
Message-ID: <1237370635-27728-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DD67C1038BE
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 11:04:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 3F4B37F4052
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 11:04:04 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XtyYteMe37ft for <alsa-devel@alsa-project.org>;
	Wed, 18 Mar 2009 11:04:01 +0100 (CET)
Received: from localhost.localdomain (pd95699b2.dip0.t-ipconnect.de
	[217.86.153.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTPSA id 426DD7F401B
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 11:04:01 +0100 (CET)
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

Following up to this mail are 3 patches to clean up the snd-usb-caiaq
driver.

[PATCH 1/3] snd-usb-caiaq: only warn once on streaming errors
[PATCH 2/3] snd-usb-caiaq: drop bogus iso packets
[PATCH 3/3] snd-usb-caiaq: bump version number

From: Eliot Blennerhassett <linux@audioscience.com>
Subject: amixer scontents fails, amixer contents succeeds
Date: Wed, 03 Feb 2010 22:56:39 +1300
Message-ID: <4B694857.8050606@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A5F424368
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 10:56:50 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KX900MJ4FMM3B10@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 03 Feb 2010 22:56:46 +1300 (NZDT)
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

Greetings,

Probably a bug in my driver (asihpi), but I don't understand how "amixer
controls" can work while "amixer scontrols" fails.

(with error code -EINVAL: "Mixer hw:1 load error: Invalid argument")

Where should I start looking for why this happens?

thanks

--
Eliot

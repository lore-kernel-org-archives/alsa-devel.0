From: Maarten de Boer <maarten@resorama.com>
Subject: pthread or snd_async_add_pcm_handler
Date: Wed, 14 Sep 2011 16:30:53 +0200
Message-ID: <892B4BD9-F32C-4B24-87BF-F54EC5722330@resorama.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
	[217.70.183.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 409B524133
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 16:30:57 +0200 (CEST)
Received: from mfilter7-d.gandi.net (mfilter7-d.gandi.net [217.70.178.136])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id AE1FD172099
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 16:30:55 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter7-d.gandi.net (mfilter7-d.gandi.net [10.0.15.180])
	(amavisd-new, port 10024)
	with ESMTP id J5gBUr2aBuCg for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 16:30:54 +0200 (CEST)
Received: from [84.88.76.79] (unknown [84.88.76.79])
	(Authenticated sender: maarten@resorama.com)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5A24017209F
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 16:30:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I am doing MMAP-based full duplex audio processing. I looked at the direct_loop code in the alsa-lib/test/pcm.c example. 

Now I want to run do the audio processing asynchronously. The async_direct_loop in the example does this, but I was wondering: is there any advantage to using snd_async_add_pcm_handler over using a simple pthread?

Thanks,

Maarten

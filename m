From: Maarten de Boer <maarten@resorama.com>
Subject: how to obtain hardware playback position after
	underrun?
Date: Wed, 25 Apr 2012 18:42:16 +0200
Message-ID: <AAA058DF-C950-48A6-9C9C-9EB5A8E4BAB9@resorama.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
	[217.70.183.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 713091049D5
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 18:42:18 +0200 (CEST)
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 709BC1720A5
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 18:42:18 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180])
	(amavisd-new, port 10024)
	with ESMTP id b+9aAF4DXN9z for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 18:42:17 +0200 (CEST)
Received: from [84.88.76.79] (unknown [84.88.76.79])
	(Authenticated sender: maarten.smtp@resorama.com)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id F1167172076
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 18:42:16 +0200 (CEST)
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

I am trying to figure out how to obtain the hardware playback position
after an underrun occured. When I have no underruns, I can simply keep
track of the time by counting the samples processed. (I am using
snd_pcm_mmap_commit). But in the unlucky event an underrun occurs, I
would like to know what the playback position would have been without
any underrun. Is this possible? I have been looking at the API docs,
and at the source code, but to no avail.

Thanks,

Maarten

 

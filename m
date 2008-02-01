From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: =?utf-8?q?Salsa-lib_add_snd=5Fpcm=5Fget=5Fparams?=
Date: Fri, 1 Feb 2008 09:03:59 +0000 (UTC)
Message-ID: <loom.20080201T085922-521@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id AEEC62441C
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 10:04:15 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JKrod-00030C-Hn
	for alsa-devel@alsa-project.org; Fri, 01 Feb 2008 09:04:07 +0000
Received: from 6.177.115-78.rev.gaoland.net ([6.177.115-78.rev.gaoland.net])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 01 Feb 2008 09:04:07 +0000
Received: from matthieu.castet by 6.177.115-78.rev.gaoland.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 01 Feb 2008 09:04:07 +0000
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

in 0.0.14, snd_pcm_get_params is missing.
Is is not even in the stub form in pcm_macros.h.

Why this function is missing ?

As it is quite trivial, could it be added in pcm_macros.h or pcm_params.c.


Thanks

Matthieu

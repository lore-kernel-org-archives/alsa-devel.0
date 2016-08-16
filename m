From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: locking looks odd
Date: Tue, 16 Aug 2016 23:03:22 +0200
Message-ID: <20160816210322.GD4466@var.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.aquilenet.fr (hera.aquilenet.fr [141.255.128.1])
 by alsa0.perex.cz (Postfix) with ESMTP id D8E5D26683F
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 23:03:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 19BA782B0
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 23:03:23 +0200 (CEST)
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PMag62UCQxel for <alsa-devel@alsa-project.org>;
 Tue, 16 Aug 2016 23:03:22 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (unknown
 [IPv6:2a01:cb19:1af:4600:3602:86ff:fe2c:6a19])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id E1227375
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 23:03:22 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.87)
 (envelope-from <samuel.thibault@ens-lyon.org>) id 1bZlW6-0007B9-H7
 for alsa-devel@alsa-project.org; Tue, 16 Aug 2016 23:03:22 +0200
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We are having odd issues with libasound 1.1.2 which we didn't have with
libasound 1.1.1, more precisely

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=833950

so I'm having a look at the locking API introduced in 1.1.2, and there
are some oddities:

- snd_pcm_new seems to initialize pcm->thread_safe to 0 by default, this
  does not seem safe. The attached patch initializes it to 1, which
  fixes the bug in our tests.

- snd_pcm_hw_open_fd forces it to 1, thus ignoring what snd_pcm_new set.

- one can find both __snd_pcm_lock and snd_pcm_lock functions, what is
  the expected difference between them?

- __snd_pcm_lock takes locks when thread_safe >= 0, while snd_pcm_lock
  takes locks when thread_safe == 0, this looks really odd.

- libasound could just not link against libpthread,
  pthread_mutex_lock/unlock are already provided as empty stubs by libc,
  the overhead will thus only be hit when the application links against
  libpthread (libasound will then properly use pthread locks).

Samuel

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- ./src/pcm/pcm.c.orig	2016-08-10 19:39:59.881564371 +0200
+++ ./src/pcm/pcm.c	2016-08-10 19:40:04.211539997 +0200
@@ -2544,6 +2544,7 @@
 	pcm->fast_op_arg = pcm;
 	INIT_LIST_HEAD(&pcm->async_handlers);
 #ifdef THREAD_SAFE_API
+	pcm->thread_safe = 1;
 	pthread_mutex_init(&pcm->lock, NULL);
 	{
 		static int default_thread_safe = -1;

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z--

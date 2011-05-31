From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: [alsa-lib] Possible bug in function 'snd_ctl_hw_open',
	file control_hw.c
Date: Tue, 31 May 2011 14:48:43 +0200
Message-ID: <BANLkTi=jC+eQh3SzP-nGzv0dh5rF35FMKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E55E81037E3
	for <alsa-devel@alsa-project.org>;
	Tue, 31 May 2011 14:48:43 +0200 (CEST)
Received: by wwi18 with SMTP id 18so2348960wwi.2
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2011 05:48:43 -0700 (PDT)
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

Hello,
I've noticed at some point function snd_ctl_hw_open() calls
snd_ctl_new() to allocate memory for variable snd_ctl_t *ctl; then it
tries to handle an error condition, but, regardless of such an error,
memory locations pointed by ctl are accessed and filled in (eventually
with invalid data, since the error causes 'fd' to be closed and 'hw'
to be freed). Since ctl could point a random area in case of
allocation failure, perhaps the function should return if such an
error occurs and avoid dereferencing it. An easy fix would be the
following, unless I'm missing something.

------------------------------------------------------
control_hw.patch
--------------------------------------------------------------
--- old/src/control/control_hw.c	2011-05-31 14:20:12.975999400 +0200
+++ new/src/control/control_hw.c	2011-05-31 14:21:35.559999388 +0200
@@ -414,6 +414,7 @@
 	if (err < 0) {
 		close(fd);
 		free(hw);
+		return err;
 	}
 	ctl->ops = &snd_ctl_hw_ops;
 	ctl->private_data = hw;

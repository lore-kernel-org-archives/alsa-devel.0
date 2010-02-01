From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: alsa-pulse plugin
Date: Mon, 1 Feb 2010 16:28:27 +0800
Message-ID: <4f3252891002010028u338830d4jba98dae1d383bb97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FAF024450
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 09:28:28 +0100 (CET)
Received: by pzk1 with SMTP id 1so136824pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 00:28:28 -0800 (PST)
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

When try to abort aplay -D pulse any.wav  in a terminal  on Fedora 12

the following error appear on some occasion and the terminal hang

aplay -v any.wav
,,,
 ^CAborted by signal Interrupt...
Assertion 'pthread_mutex_destroy(&m->mutex) == 0' failed at
pulsecore/mutex-posix.c:83 function pa_mutex_free(). Aborting
Aborted by signal Aborted....
*** glibc detected *** aplay: double free corruption(top): 0x09e69708 ****
*** glibc detected *** aplay corrupted double-linked list : 0x09e5dcb8 ***


Is there any way to debug this issue ?

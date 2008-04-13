From: Rong-Jhe <r93922118@ntu.edu.tw>
Subject: =?utf-8?q?How_to_kill_thread_server=5Fjob=28=29_in_s?=
	=?utf-8?b?bmRfcGNtX29wZW4oKQ==?=
Date: Sun, 13 Apr 2008 08:05:53 +0000 (UTC)
Message-ID: <loom.20080413T080045-322@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D8AE924602
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 10:06:03 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JkxDt-0005e2-Hg
	for alsa-devel@alsa-project.org; Sun, 13 Apr 2008 08:06:02 +0000
Received: from 220.128.79.26 ([220.128.79.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 13 Apr 2008 08:06:01 +0000
Received: from r93922118 by 220.128.79.26 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 13 Apr 2008 08:06:01 +0000
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

I found that the thread server_job() can not be killed by using snd_pcm_close
().
The code in snd_pcm_direct_server_discard() is disabled, and then it can not 
send signal to kill the thread.
Why the code is disabled?
Is there any bugs if I enable the code?

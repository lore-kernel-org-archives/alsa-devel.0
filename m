From: Rong-Jhe <r93922118@ntu.edu.tw>
Subject: Re:
	=?utf-8?q?How_to_kill_thread_server=5Fjob=28=29_in_s?=
	=?utf-8?b?bmRfcGNtX29wZW4oKQ==?=
Date: Mon, 14 Apr 2008 02:18:00 +0000 (UTC)
Message-ID: <loom.20080414T020651-351@post.gmane.org>
References: <loom.20080413T080045-322@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id B4EA4243C9
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 04:18:16 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlEGp-0000Pd-9F
	for alsa-devel@alsa-project.org; Mon, 14 Apr 2008 02:18:12 +0000
Received: from 220.128.79.26 ([220.128.79.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 02:18:11 +0000
Received: from r93922118 by 220.128.79.26 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 02:18:11 +0000
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

Rong-Jhe <r93922118 <at> ntu.edu.tw> writes:

> 
> I found that the thread server_job() can not be killed by using snd_pcm_close
> ().
> The code in snd_pcm_direct_server_discard() is disabled, and then it can not 
> send signal to kill the thread.
> Why the code is disabled?
> Is there any bugs if I enable the code?
> 

I have enabled the code in snd_pcm_direct_server_discard(), but it can not 
kill the thread of server_job(). The dmix->server_pid is wrong.
In snd_pcm_direct_server_create(), the main thread uses fork() to establish a 
child thread and the child uses fork() to establish another child thread again.
The main thread only keeps the pid of the first child thread, and the second 
child thread executes server_job(). Do to this, the main thread kills wrong 
pid.
Further, the main thread uses waitpid() before keeping the pid of the first 
child thread, and the first child thread dies after establishing the second 
child thread. In this way, the pid kept in dmix->server_pid is useless.
Why does the program need to use fork() two times?

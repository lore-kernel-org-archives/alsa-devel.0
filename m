From: Jaroslav Kysela <perex@perex.cz>
Subject: Re:
 =?utf-8?q?How_to_kill_thread_server=5Fjob=28=29_in_s?=
 =?utf-8?b?bmRfcGNtX29wZW4oKQ==?=
Date: Mon, 14 Apr 2008 08:57:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804140855460.13990@tm8103.perex-int.cz>
References: <loom.20080413T080045-322@post.gmane.org>
	<loom.20080414T020651-351@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4788724471
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 08:57:55 +0200 (CEST)
In-Reply-To: <loom.20080414T020651-351@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rong-Jhe <r93922118@ntu.edu.tw>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Apr 2008, Rong-Jhe wrote:

> Rong-Jhe <r93922118 <at> ntu.edu.tw> writes:
> 
> > 
> > I found that the thread server_job() can not be killed by using snd_pcm_close
> > ().
> > The code in snd_pcm_direct_server_discard() is disabled, and then it can not 
> > send signal to kill the thread.
> > Why the code is disabled?
> > Is there any bugs if I enable the code?
> > 
> 
> I have enabled the code in snd_pcm_direct_server_discard(), but it can not 
> kill the thread of server_job(). The dmix->server_pid is wrong.
> In snd_pcm_direct_server_create(), the main thread uses fork() to establish a 
> child thread and the child uses fork() to establish another child thread again.
> The main thread only keeps the pid of the first child thread, and the second 
> child thread executes server_job(). Do to this, the main thread kills wrong 
> pid.
> Further, the main thread uses waitpid() before keeping the pid of the first 
> child thread, and the first child thread dies after establishing the second 
> child thread. In this way, the pid kept in dmix->server_pid is useless.
> Why does the program need to use fork() two times?

What you're trying to do? The server process will timeout (ends) 
itself when dmix clients are inactive.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

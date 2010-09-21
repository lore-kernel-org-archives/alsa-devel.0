From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-kernel repository corrupted?
Date: Tue, 21 Sep 2010 17:14:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211712570.6226@eeebox2.perex-int.cz>
References: <1285071931.1852.6.camel@marvin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7308A2438E
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 17:14:19 +0200 (CEST)
In-Reply-To: <1285071931.1852.6.camel@marvin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andy Owen <andy-alsa@ultra-premium.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Sep 2010, Andy Owen wrote:

> Hi, I'm trying to put together a patch for the ca0106 driver, and I'm
> having trouble cloning the alsa-kernel repository. I've tried it a few
> times from different places and while it is downloading I get "fatal:
> delta size changed" when it is partially through. Here are two runs of
> git clone with slightly different output (consecutive runs on the same
> computer):
>
> % git clone git://git.alsa-project.org/alsa-kernel.git alsa-kernel
> Initialized empty Git repository in /home/andy/src/alsa-kernel/.git/
> remote: Counting objects: 1708307, done.
> remote: Compressing objects: 100% (313659/313659), done.
> remote: fatal: delta size changed
> remote: aborting due to possible repository corruption on the remote
> side.
> fatal: early EOF
> fatal: index-pack failed

It's fixed now. The 'git gc' command on server fixed this issue.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
